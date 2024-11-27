# figma_api.model.Node

## Load the model package
```dart
import 'package:figma_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | [optional] 
**name** | **String** |  | [optional] 
**type** | **String** |  | [optional] 
**visible** | **bool** |  | [optional] [default to true]
**locked** | **bool** |  | [optional] [default to false]
**children** | [**List&lt;Node&gt;**](Node.md) |  | [optional] 
**absoluteBoundingBox** | [**Rectangle**](Rectangle.md) |  | [optional] 
**constraints** | [**LayoutConstraint**](LayoutConstraint.md) |  | [optional] 
**layoutMode** | **String** |  | [optional] 
**primaryAxisAlignItems** | **String** |  | [optional] 
**counterAxisAlignItems** | **String** |  | [optional] 
**paddingLeft** | **num** |  | [optional] 
**paddingRight** | **num** |  | [optional] 
**paddingTop** | **num** |  | [optional] 
**paddingBottom** | **num** |  | [optional] 
**itemSpacing** | **num** |  | [optional] 
**fills** | [**List&lt;Paint&gt;**](Paint.md) |  | [optional] 
**strokes** | [**List&lt;Paint&gt;**](Paint.md) |  | [optional] 
**strokeWeight** | **num** |  | [optional] 
**effects** | [**List&lt;Effect&gt;**](Effect.md) |  | [optional] 
**characters** | **String** |  | [optional] 
**style** | [**TypeStyle**](TypeStyle.md) |  | [optional] 
**cornerRadius** | **num** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


