# figma_api.model.Node

## Load the model package
```dart
import 'package:figma_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**name** | **String** |  | [optional] 
**type** | **String** |  | 
**visible** | **bool** |  | [optional] [default to true]
**locked** | **bool** |  | [optional] [default to false]
**opacity** | **num** |  | [optional] [default to 1]
**blendMode** | [**BlendMode**](BlendMode.md) |  | [optional] 
**preserveRatio** | **bool** |  | [optional] [default to false]
**layoutAlign** | **String** |  | [optional] 
**constraints** | [**LayoutConstraint**](LayoutConstraint.md) |  | [optional] 
**transitionNodeID** | **String** |  | [optional] 
**transitionDuration** | **num** |  | [optional] 
**transitionEasing** | [**EasingType**](EasingType.md) |  | [optional] 
**absoluteBoundingBox** | [**Rectangle**](Rectangle.md) |  | [optional] 
**fills** | [**List&lt;Paint&gt;**](Paint.md) |  | [optional] 
**strokes** | [**List&lt;Paint&gt;**](Paint.md) |  | [optional] 
**strokeWeight** | **num** |  | [optional] 
**strokeAlign** | **String** |  | [optional] 
**strokeDashes** | **List&lt;num&gt;** |  | [optional] 
**cornerRadius** | **num** |  | [optional] 
**rectangleCornerRadii** | **List&lt;num&gt;** |  | [optional] 
**exportSettings** | [**List&lt;ExportSetting&gt;**](ExportSetting.md) |  | [optional] 
**effects** | [**List&lt;Effect&gt;**](Effect.md) |  | [optional] 
**isMask** | **bool** |  | [optional] [default to false]
**layoutMode** | **String** |  | [optional] 
**primaryAxisSizingMode** | **String** |  | [optional] 
**counterAxisSizingMode** | **String** |  | [optional] 
**primaryAxisAlignItems** | **String** |  | [optional] 
**counterAxisAlignItems** | **String** |  | [optional] 
**paddingLeft** | **num** |  | [optional] 
**paddingRight** | **num** |  | [optional] 
**paddingTop** | **num** |  | [optional] 
**paddingBottom** | **num** |  | [optional] 
**itemSpacing** | **num** |  | [optional] 
**layoutGrids** | [**List&lt;LayoutGrid&gt;**](LayoutGrid.md) |  | [optional] 
**clipsContent** | **bool** |  | [optional] [default to true]
**children** | [**List&lt;Node&gt;**](Node.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


