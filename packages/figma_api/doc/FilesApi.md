# figma_api.api.FilesApi

## Load the API package
```dart
import 'package:figma_api/api.dart';
```

All URIs are relative to *https://api.figma.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getFile**](FilesApi.md#getfile) | **GET** /v1/files/{file_key} | Get file JSON
[**getImages**](FilesApi.md#getimages) | **GET** /v1/images/{file_key} | Get images


# **getFile**
> GetFile200Response getFile(fileKey)

Get file JSON

### Example
```dart
import 'package:figma_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: PersonalAccessToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('PersonalAccessToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('PersonalAccessToken').apiKeyPrefix = 'Bearer';

final api = FigmaApi().getFilesApi();
final String fileKey = fileKey_example; // String | File to export JSON from

try {
    final response = api.getFile(fileKey);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FilesApi->getFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fileKey** | **String**| File to export JSON from | 

### Return type

[**GetFile200Response**](GetFile200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2), [PersonalAccessToken](../README.md#PersonalAccessToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getImages**
> GetImages200Response getImages(fileKey, ids, scale, format)

Get images

### Example
```dart
import 'package:figma_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: PersonalAccessToken
//defaultApiClient.getAuthentication<ApiKeyAuth>('PersonalAccessToken').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('PersonalAccessToken').apiKeyPrefix = 'Bearer';

final api = FigmaApi().getFilesApi();
final String fileKey = fileKey_example; // String | File to export images from
final String ids = ids_example; // String | Node IDs to render
final num scale = 8.14; // num | Image scaling factor
final String format = format_example; // String | Image format

try {
    final response = api.getImages(fileKey, ids, scale, format);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FilesApi->getImages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fileKey** | **String**| File to export images from | 
 **ids** | **String**| Node IDs to render | 
 **scale** | **num**| Image scaling factor | [optional] 
 **format** | **String**| Image format | [optional] [default to 'png']

### Return type

[**GetImages200Response**](GetImages200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2), [PersonalAccessToken](../README.md#PersonalAccessToken)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

