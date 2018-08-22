set(BS_SBANSHEEENGINE_INC_NOFILTER
	"BsScriptObject.h"
	"BsScriptEnginePrerequisites.h"
	"BsManagedComponent.h"
	"BsScriptResourceManager.h"
	"BsScriptGameObjectManager.h"
	"BsScriptObjectImpl.h"
	"BsManagedResource.h"
	"BsManagedResourceMetaData.h"
	"BsManagedResourceManager.h"
	"BsScriptObjectManager.h"
	"BsEngineScriptLibrary.h"
	"BsPlayInEditorManager.h"
)

set(BS_SBANSHEEENGINE_SRC_WRAPPERS_GUI
	"Wrappers/GUI/BsScriptRange.cpp"
	"Wrappers/GUI/BsScriptStep.cpp"
	"Wrappers/GUI/BsScriptGUIButton.cpp"
	"Wrappers/GUI/BsScriptGUIElementStateStyle.cpp"
	"Wrappers/GUI/BsScriptGUIElementStyle.cpp"
	"Wrappers/GUI/BsScriptGUIFixedSpace.cpp"
	"Wrappers/GUI/BsScriptGUIFlexibleSpace.cpp"
	"Wrappers/GUI/BsScriptGUIInputBox.cpp"
	"Wrappers/GUI/BsScriptGUILabel.cpp"
	"Wrappers/GUI/BsScriptGUILayout.cpp"
	"Wrappers/GUI/BsScriptGUIListBox.cpp"
	"Wrappers/GUI/BsScriptGUIScrollArea.cpp"
	"Wrappers/GUI/BsScriptGUITexture.cpp"
	"Wrappers/GUI/BsScriptGUIToggle.cpp"
	"Wrappers/GUI/BsScriptGUIToggleGroup.cpp"
	"Wrappers/GUI/BsScriptGUIElement.cpp"
	"Wrappers/GUI/BsScriptGUIUtility.cpp"
	"Wrappers/GUI/BsScriptGUIRenderTexture.cpp"
	"Wrappers/GUI/BsScriptGUISlider.cpp"
	"Wrappers/GUI/BsScriptGUIProgressBar.cpp"
	"Wrappers/GUI/BsScriptGUISkin.cpp"
	"Wrappers/GUI/BsScriptGUIWidget.cpp"
	"Wrappers/GUI/BsScriptGUI.cpp"
	"Wrappers/GUI/BsScriptGUICanvas.cpp"
	"Wrappers/GUI/BsScriptGUIScrollBar.cpp"
)

set(BS_SBANSHEEENGINE_INC_SERIALIZATION_RTTI
	"RTTI/BsManagedSerializableArrayRTTI.h"
	"RTTI/BsManagedSerializableDictionaryRTTI.h"
	"RTTI/BsManagedSerializableListRTTI.h"
	"RTTI/BsManagedSerializableObjectRTTI.h"
	"RTTI/BsManagedSerializableFieldRTTI.h"
	"RTTI/BsManagedSerializableObjectInfoRTTI.h"
	"RTTI/BsManagedSerializableDiffRTTI.h"
)

set(BS_SBANSHEEENGINE_INC_WRAPPERS
	"Wrappers/BsScriptBuiltin.h"
	"Wrappers/BsScriptColor.h"
	"Wrappers/BsScriptComponent.h"
	"Wrappers/BsScriptContextMenu.h"
	"Wrappers/BsScriptCursor.h"
	"Wrappers/BsScriptDebug.h"
	"Wrappers/BsScriptGameObject.h"
	"Wrappers/BsScriptInput.h"
	"Wrappers/BsScriptInputConfiguration.h"
	"Wrappers/BsScriptLogEntry.h"
	"Wrappers/BsScriptManagedResource.h"
	"Wrappers/BsScriptPixelUtility.h"
	"Wrappers/BsScriptPlainText.h"
	"Wrappers/BsScriptPrefab.h"
	"Wrappers/BsScriptResource.h"
	"Wrappers/BsScriptVirtualInput.h"
	"Wrappers/BsScriptVirtualButton.h"
	"Wrappers/BsScriptVector2I.h"
	"Wrappers/BsScriptVector.h"
	"Wrappers/BsScriptTime.h"
	"Wrappers/BsScriptShaderInclude.h"
	"Wrappers/BsScriptSerializableUtility.h"
	"Wrappers/BsScriptSerializableProperty.h"
	"Wrappers/BsScriptSerializableObject.h"
	"Wrappers/BsScriptSerializableList.h"
	"Wrappers/BsScriptSerializableField.h"
	"Wrappers/BsScriptSerializableDictionary.h"
	"Wrappers/BsScriptScriptCode.h"
	"Wrappers/BsScriptSerializableArray.h"
	"Wrappers/BsScriptSceneObject.h"
	"Wrappers/BsScriptScene.h"
	"Wrappers/BsScriptResources.h"
	"Wrappers/BsScriptRRefBase.h"
	"Wrappers/BsScriptManagedComponent.h"
	"Wrappers/BsScriptQuaternion.h"
)

set(BS_SBANSHEEENGINE_INC_WRAPPERS_GUI
	"Wrappers/GUI/BsScriptRange.h"
	"Wrappers/GUI/BsScriptStep.h"
	"Wrappers/GUI/BsScriptGUIButton.h"
	"Wrappers/GUI/BsScriptGUIElementStateStyle.h"
	"Wrappers/GUI/BsScriptGUIElementStyle.h"
	"Wrappers/GUI/BsScriptGUIFixedSpace.h"
	"Wrappers/GUI/BsScriptGUIFlexibleSpace.h"
	"Wrappers/GUI/BsScriptGUIInputBox.h"
	"Wrappers/GUI/BsScriptGUILabel.h"
	"Wrappers/GUI/BsScriptGUILayout.h"
	"Wrappers/GUI/BsScriptGUIListBox.h"
	"Wrappers/GUI/BsScriptGUIScrollArea.h"
	"Wrappers/GUI/BsScriptGUITexture.h"
	"Wrappers/GUI/BsScriptGUIToggle.h"
	"Wrappers/GUI/BsScriptGUIToggleGroup.h"
	"Wrappers/GUI/BsScriptGUIElement.h"
	"Wrappers/GUI/BsScriptGUIUtility.h"
	"Wrappers/GUI/BsScriptGUIRenderTexture.h"
	"Wrappers/GUI/BsScriptGUISlider.h"
	"Wrappers/GUI/BsScriptGUIProgressBar.h"
	"Wrappers/GUI/BsScriptGUISkin.h"
	"Wrappers/GUI/BsScriptGUIWidget.h"
	"Wrappers/GUI/BsScriptGUI.h"
	"Wrappers/GUI/BsScriptGUICanvas.h"
	"Wrappers/GUI/BsScriptGUIScrollBar.h"
)

set(BS_SBANSHEEENGINE_SRC_SERIALIZATION
	"Serialization/BsManagedSerializableArray.cpp"
	"Serialization/BsManagedSerializableDictionary.cpp"
	"Serialization/BsManagedSerializableField.cpp"
	"Serialization/BsManagedSerializableList.cpp"
	"Serialization/BsManagedSerializableObject.cpp"
	"Serialization/BsManagedSerializableObjectInfo.cpp"
	"Serialization/BsScriptAssemblyManager.cpp"
	"Serialization/BsManagedSerializableDiff.cpp"
	"Serialization/BsManagedDiff.cpp"
)

set(BS_SBANSHEEENGINE_SRC_WRAPPERS
	"Wrappers/BsScriptBuiltin.cpp"
	"Wrappers/BsScriptColor.cpp"
	"Wrappers/BsScriptComponent.cpp"
	"Wrappers/BsScriptContextMenu.cpp"
	"Wrappers/BsScriptCursor.cpp"
	"Wrappers/BsScriptDebug.cpp"
	"Wrappers/BsScriptGameObject.cpp"
	"Wrappers/BsScriptInput.cpp"
	"Wrappers/BsScriptInputConfiguration.cpp"
	"Wrappers/BsScriptLogEntry.cpp"
	"Wrappers/BsScriptManagedResource.cpp"
	"Wrappers/BsScriptPixelUtility.cpp"
	"Wrappers/BsScriptPlainText.cpp"
	"Wrappers/BsScriptPrefab.cpp"
	"Wrappers/BsScriptVirtualInput.cpp"
	"Wrappers/BsScriptVirtualButton.cpp"
	"Wrappers/BsScriptVector2I.cpp"
	"Wrappers/BsScriptVector.cpp"
	"Wrappers/BsScriptTime.cpp"
	"Wrappers/BsScriptShaderInclude.cpp"
	"Wrappers/BsScriptSerializableUtility.cpp"
	"Wrappers/BsScriptSerializableProperty.cpp"
	"Wrappers/BsScriptSerializableObject.cpp"
	"Wrappers/BsScriptSerializableList.cpp"
	"Wrappers/BsScriptSerializableField.cpp"
	"Wrappers/BsScriptSerializableDictionary.cpp"
	"Wrappers/BsScriptSerializableArray.cpp"
	"Wrappers/BsScriptScriptCode.cpp"
	"Wrappers/BsScriptSceneObject.cpp"
	"Wrappers/BsScriptScene.cpp"
	"Wrappers/BsScriptResources.cpp"
	"Wrappers/BsScriptRRefBase.cpp"
	"Wrappers/BsScriptResource.cpp"
	"Wrappers/BsScriptManagedComponent.cpp"
	"Wrappers/BsScriptQuaternion.cpp"
)

set(BS_SBANSHEEENGINE_INC_SERIALIZATION
	"Serialization/BsManagedSerializableArray.h"
	"Serialization/BsManagedSerializableDictionary.h"
	"Serialization/BsManagedSerializableList.h"
	"Serialization/BsManagedSerializableObject.h"
	"Serialization/BsManagedSerializableField.h"
	"Serialization/BsManagedSerializableObjectInfo.h"
	"Serialization/BsScriptAssemblyManager.h"
	"Serialization/BsManagedSerializableDiff.h"
	"Serialization/BsManagedDiff.h"
	"Serialization/BsBuiltinComponentLookup.h"
	"Serialization/BsBuiltinResourceLookup.h"
)

set(BS_SBANSHEEENGINE_SRC_NOFILTER
	"BsScriptEnginePlugin.cpp"
	"BsManagedComponent.cpp"
	"BsScriptResourceManager.cpp"
	"BsScriptGameObjectManager.cpp"
	"BsScriptObjectImpl.cpp"
	"BsScriptObject.cpp"
	"BsManagedResource.cpp"
	"BsManagedResourceMetaData.cpp"
	"BsManagedResourceManager.cpp"
	"BsScriptObjectManager.cpp"
	"BsEngineScriptLibrary.cpp"
	"BsPlayInEditorManager.cpp"
)

set(BS_SBANSHEEENGINE_INC_RTTI
	"RTTI/BsManagedComponentRTTI.h"
	"RTTI/BsManagedResourceRTTI.h"
	"RTTI/BsManagedResourceMetaDataRTTI.h"
)

set(BS_SBANSHEEENGINE_INC_EXTENSIONS
	"Extensions/BsPixelDataEx.h"
	"Extensions/BsAsyncOpEx.h"
	"Extensions/BsTextureEx.h"
	"Extensions/BsMeshDataEx.h"
	"Extensions/BsMeshEx.h"
	"Extensions/BsSkeletonEx.h"
	"Extensions/BsPhysicsMeshEx.h"
	"Extensions/BsAnimationEx.h"
	"Extensions/BsShaderEx.h"
	"Extensions/BsMaterialEx.h"
	"Extensions/BsRenderTargetEx.h"
	"Extensions/BsColorGradientEx.h"
)

set(BS_SBANSHEEENGINE_SRC_EXTENSIONS
	"Extensions/BsPixelDataEx.cpp"
	"Extensions/BsAsyncOpEx.cpp"
	"Extensions/BsTextureEx.cpp"
	"Extensions/BsMeshDataEx.cpp"
	"Extensions/BsMeshEx.cpp"
	"Extensions/BsSkeletonEx.cpp"
	"Extensions/BsPhysicsMeshEx.cpp"
	"Extensions/BsAnimationEx.cpp"
	"Extensions/BsShaderEx.cpp"
	"Extensions/BsMaterialEx.cpp"
	"Extensions/BsRenderTargetEx.cpp"
	"Extensions/BsColorGradientEx.cpp"
)

source_group("Header Files" FILES ${BS_SBANSHEEENGINE_INC_NOFILTER})
source_group("Source Files\\Wrappers\\GUI" FILES ${BS_SBANSHEEENGINE_SRC_WRAPPERS_GUI})
source_group("Header Files\\Serialization\\RTTI" FILES ${BS_SBANSHEEENGINE_INC_SERIALIZATION_RTTI})
source_group("Header Files\\Wrappers" FILES ${BS_SBANSHEEENGINE_INC_WRAPPERS})
source_group("Header Files\\Wrappers\\GUI" FILES ${BS_SBANSHEEENGINE_INC_WRAPPERS_GUI})
source_group("Source Files\\Serialization" FILES ${BS_SBANSHEEENGINE_SRC_SERIALIZATION})
source_group("Source Files\\Wrappers" FILES ${BS_SBANSHEEENGINE_SRC_WRAPPERS})
source_group("Header Files\\Serialization" FILES ${BS_SBANSHEEENGINE_INC_SERIALIZATION})
source_group("Source Files" FILES ${BS_SBANSHEEENGINE_SRC_NOFILTER})
source_group("Header Files\\RTTI" FILES ${BS_SBANSHEEENGINE_INC_RTTI})
source_group("Header Files\\Extensions" FILES ${BS_SBANSHEEENGINE_INC_EXTENSIONS})
source_group("Source Files\\Extensions" FILES ${BS_SBANSHEEENGINE_SRC_EXTENSIONS})

set(BS_SBANSHEEENGINE_SRC
	${BS_SBANSHEEENGINE_INC_NOFILTER}
	${BS_SBANSHEEENGINE_SRC_WRAPPERS_GUI}
	${BS_SBANSHEEENGINE_INC_SERIALIZATION_RTTI}
	${BS_SBANSHEEENGINE_INC_WRAPPERS}
	${BS_SBANSHEEENGINE_INC_WRAPPERS_GUI}
	${BS_SBANSHEEENGINE_SRC_SERIALIZATION}
	${BS_SBANSHEEENGINE_SRC_WRAPPERS}
	${BS_SBANSHEEENGINE_INC_SERIALIZATION}
	${BS_SBANSHEEENGINE_SRC_NOFILTER}
	${BS_SBANSHEEENGINE_INC_RTTI}
	${BS_SBANSHEEENGINE_INC_EXTENSIONS}
	${BS_SBANSHEEENGINE_SRC_EXTENSIONS}
)