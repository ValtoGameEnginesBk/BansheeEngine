#include "BsFontImporter.h"
#include "BsFontImportOptions.h"
#include "BsPixelData.h"
#include "BsTexture.h"
#include "BsResources.h"
#include "BsDebug.h"
#include "BsPath.h"
#include "BsTexAtlasGenerator.h"
#include "BsCoreApplication.h"
#include "BsCoreThread.h"
#include "BsCoreThreadAccessor.h"

#include <ft2build.h>
#include <freetype/freetype.h>
#include FT_FREETYPE_H

using namespace std::placeholders;

namespace BansheeEngine
{
	FontImporter::FontImporter()
		:SpecificImporter() 
	{
		mExtensions.push_back(L"ttf");
		mExtensions.push_back(L"otf");
	}

	FontImporter::~FontImporter() 
	{

	}

	bool FontImporter::isExtensionSupported(const WString& ext) const
	{
		WString lowerCaseExt = ext;
		StringUtil::toLowerCase(lowerCaseExt);

		return find(mExtensions.begin(), mExtensions.end(), lowerCaseExt) != mExtensions.end();
	}

	bool FontImporter::isMagicNumberSupported(const UINT8* magicNumPtr, UINT32 numBytes) const
	{
		// TODO
		return false;
	}

	ImportOptionsPtr FontImporter::createImportOptions() const
	{
		return bs_shared_ptr<FontImportOptions, ScratchAlloc>();
	}

	ResourcePtr FontImporter::import(const Path& filePath, ConstImportOptionsPtr importOptions)
	{
		const FontImportOptions* fontImportOptions = static_cast<const FontImportOptions*>(importOptions.get());

		FT_Library library;

		FT_Error error = FT_Init_FreeType(&library);
		if (error)
			BS_EXCEPT(InternalErrorException, "Error occurred during FreeType library initialization.");

		FT_Face face;
		error = FT_New_Face(library, filePath.toString().c_str(), 0, &face);

		if (error == FT_Err_Unknown_File_Format)
		{
			BS_EXCEPT(InternalErrorException, "Failed to load font file: " + filePath.toString() + ". Unsupported file format.");
		}
		else if (error)
		{
			BS_EXCEPT(InternalErrorException, "Failed to load font file: " + filePath.toString() + ". Unknown error.");
		}

		Vector<std::pair<UINT32, UINT32>> charIndexRanges = fontImportOptions->getCharIndexRanges();
		Vector<UINT32> fontSizes = fontImportOptions->getFontSizes();
		UINT32 dpi = fontImportOptions->getDPI();

		FT_Int32 loadFlags = FT_LOAD_RENDER;
		if(!fontImportOptions->getAntialiasing())
			loadFlags |= FT_LOAD_TARGET_MONO | FT_LOAD_NO_AUTOHINT;

		Vector<FontData> dataPerSize;
		for(size_t i = 0; i < fontSizes.size(); i++)
		{
			FT_F26Dot6 ftSize = (FT_F26Dot6)(fontSizes[i] * (1 << 6));
			if(FT_Set_Char_Size( face, ftSize, 0, dpi, dpi))
				BS_EXCEPT(InternalErrorException, "Could not set character size." );

			FontData fontData;

			// Get all char sizes so we can generate texture layout
			Vector<TexAtlasElementDesc> atlasElements;
			Map<UINT32, UINT32> seqIdxToCharIdx;
			for(auto iter = charIndexRanges.begin(); iter != charIndexRanges.end(); ++iter)
			{
				for(UINT32 charIdx = iter->first; charIdx <= iter->second; charIdx++)
				{
					error = FT_Load_Char(face, (FT_ULong)charIdx, loadFlags);

					if(error)
						BS_EXCEPT(InternalErrorException, "Failed to load a character");

					FT_GlyphSlot slot = face->glyph;

					TexAtlasElementDesc atlasElement;
					atlasElement.input.width = slot->bitmap.width;
					atlasElement.input.height = slot->bitmap.rows;

					atlasElements.push_back(atlasElement);
					seqIdxToCharIdx[(UINT32)atlasElements.size() - 1] = charIdx;
				}
			}

			// Add missing glyph
			{
				error = FT_Load_Glyph(face, (FT_ULong)0, loadFlags);

				if(error)
					BS_EXCEPT(InternalErrorException, "Failed to load a character");

				FT_GlyphSlot slot = face->glyph;

				TexAtlasElementDesc atlasElement;
				atlasElement.input.width = slot->bitmap.width;
				atlasElement.input.height = slot->bitmap.rows;

				atlasElements.push_back(atlasElement);
			}

			// Create an optimal layout for character bitmaps
			TexAtlasGenerator texAtlasGen(false, MAXIMUM_TEXTURE_SIZE, MAXIMUM_TEXTURE_SIZE);
			Vector<TexAtlasPageDesc> pages = texAtlasGen.createAtlasLayout(atlasElements);

			INT32 baselineOffset = 0;
			UINT32 lineHeight = 0;

			// Create char bitmap atlas textures and load character information
			UINT32 pageIdx = 0;
			for(auto pageIter = pages.begin(); pageIter != pages.end(); ++pageIter)
			{
				UINT32 bufferSize = pageIter->width * pageIter->height * 2;

				// TODO - I don't actually need a 2 channel texture
				PixelDataPtr pixelData = bs_shared_ptr<PixelData>(pageIter->width, pageIter->height, 1, PF_R8G8);

				pixelData->allocateInternalBuffer();
				UINT8* pixelBuffer = pixelData->getData();
				memset(pixelBuffer, 0, bufferSize);

				for(size_t elementIdx = 0; elementIdx < atlasElements.size(); elementIdx++)
				{
					// Copy character bitmap
					if(atlasElements[elementIdx].output.page != pageIdx)
						continue;

					TexAtlasElementDesc curElement = atlasElements[elementIdx];
					bool isMissingGlypth = elementIdx == (atlasElements.size() - 1); // It's always the last element

					UINT32 charIdx = 0;
					if(!isMissingGlypth)
					{
						charIdx = seqIdxToCharIdx[(UINT32)elementIdx];

						error = FT_Load_Char(face, charIdx, loadFlags);
					}
					else
					{
						error = FT_Load_Glyph(face, 0, loadFlags);
					}

					if(error)
						BS_EXCEPT(InternalErrorException, "Failed to load a character");

					FT_GlyphSlot slot = face->glyph;

					if(slot->bitmap.buffer == nullptr && slot->bitmap.rows > 0 && slot->bitmap.width > 0)
						BS_EXCEPT(InternalErrorException, "Failed to render glyph bitmap");

					UINT8* sourceBuffer = slot->bitmap.buffer;
					UINT8* dstBuffer = pixelBuffer + (curElement.output.y * pageIter->width * 2) + curElement.output.x * 2;

					if(slot->bitmap.pixel_mode == ft_pixel_mode_grays)
					{
						for(INT32 bitmapRow = 0; bitmapRow < slot->bitmap.rows; bitmapRow++)
						{
							for(INT32 bitmapColumn = 0; bitmapColumn < slot->bitmap.width; bitmapColumn++)
							{
								dstBuffer[bitmapColumn * 2 + 0] = sourceBuffer[bitmapColumn];
								dstBuffer[bitmapColumn * 2 + 1] = sourceBuffer[bitmapColumn];
							}

							dstBuffer += pageIter->width * 2;
							sourceBuffer += slot->bitmap.pitch;
						}
					}
					else if(slot->bitmap.pixel_mode == ft_pixel_mode_mono)
					{
						// 8 pixels are packed into a byte, so do some unpacking
						for(INT32 bitmapRow = 0; bitmapRow < slot->bitmap.rows; bitmapRow++)
						{
							for(INT32 bitmapColumn = 0; bitmapColumn < slot->bitmap.width; bitmapColumn++)
							{
								UINT8 srcValue = sourceBuffer[bitmapColumn >> 3];
								UINT8 dstValue = (srcValue & (128 >> (bitmapColumn & 7))) != 0 ? 255 : 0;

								dstBuffer[bitmapColumn * 2 + 0] = dstValue;
								dstBuffer[bitmapColumn * 2 + 1] = dstValue;
							}

							dstBuffer += pageIter->width * 2;
							sourceBuffer += slot->bitmap.pitch;
						}
					}
					else
						BS_EXCEPT(InternalErrorException, "Unsupported pixel mode for a FreeType bitmap.");

					// Store character information
					CHAR_DESC charDesc;

					float invTexWidth = 1.0f / pageIter->width;
					float invTexHeight = 1.0f / pageIter->height;

					charDesc.charId = charIdx;
					charDesc.width = curElement.input.width;
					charDesc.height = curElement.input.height;
					charDesc.page = curElement.output.page;
					charDesc.uvWidth = invTexWidth * curElement.input.width;
					charDesc.uvHeight = invTexHeight * curElement.input.height;
					charDesc.uvX = invTexWidth * curElement.output.x;
					charDesc.uvY = invTexHeight * curElement.output.y;
					charDesc.xOffset = slot->bitmap_left;
					charDesc.yOffset = slot->bitmap_top;
					charDesc.xAdvance = slot->advance.x >> 6;
					charDesc.yAdvance = slot->advance.y >> 6;

					baselineOffset = std::max(baselineOffset, (INT32)(slot->metrics.horiBearingY >> 6));
					lineHeight = std::max(lineHeight, charDesc.height);

					// Load kerning and store char
					if(!isMissingGlypth)
					{
						FT_Vector resultKerning;
						for(auto kerningIter = charIndexRanges.begin(); kerningIter != charIndexRanges.end(); ++kerningIter)
						{
							for(UINT32 kerningCharIdx = kerningIter->first; kerningCharIdx <= kerningIter->second; kerningCharIdx++)
							{
								if(kerningCharIdx == charIdx)
									continue;

								error = FT_Get_Kerning(face, charIdx, kerningCharIdx, FT_KERNING_DEFAULT, &resultKerning);

								if(error)
									BS_EXCEPT(InternalErrorException, "Failed to get kerning information for character: " + toString(charIdx));

								INT32 kerningX = (INT32)(resultKerning.x >> 6); // Y kerning is ignored because it is so rare
								if(kerningX == 0) // We don't store 0 kerning, this is assumed default
									continue;

								KerningPair pair;
								pair.amount = kerningX;
								pair.otherCharId = kerningCharIdx;

								charDesc.kerningPairs.push_back(pair);
							}
						}

						fontData.fontDesc.characters[charIdx] = charDesc;
					}
					else
					{
						fontData.fontDesc.missingGlyph = charDesc;
					}
				}

				HTexture newTex = Texture::create(TEX_TYPE_2D, pageIter->width, pageIter->height, 0, PF_R8G8);
				UINT32 subresourceIdx = newTex->getProperties().mapToSubresourceIdx(0, 0);

				// It's possible the formats no longer match
				if (newTex->getProperties().getFormat() != pixelData->getFormat())
				{
					PixelDataPtr temp = newTex->getProperties().allocateSubresourceBuffer(subresourceIdx);
					PixelUtil::bulkPixelConversion(*pixelData, *temp);

					newTex->writeSubresource(gCoreAccessor(), subresourceIdx, temp, false);
				}
				else
				{
					newTex->writeSubresource(gCoreAccessor(), subresourceIdx, pixelData, false);
				}

				newTex->setName(L"FontPage" + toWString((UINT32)fontData.texturePages.size()));
				fontData.texturePages.push_back(newTex);

				pageIdx++;
			}

			fontData.size = fontSizes[i];
			fontData.fontDesc.baselineOffset = baselineOffset;
			fontData.fontDesc.lineHeight = lineHeight;

			// Get space size
			error = FT_Load_Char(face, 32, loadFlags);

			if(error)
				BS_EXCEPT(InternalErrorException, "Failed to load a character");

			fontData.fontDesc.spaceWidth = face->glyph->advance.x >> 6;

			dataPerSize.push_back(fontData);
		}

		FontPtr newFont = Font::_createPtr(dataPerSize);

		FT_Done_FreeType(library);

		WString fileName = filePath.getWFilename(false);
		newFont->setName(fileName);

		return newFont;
	}
}