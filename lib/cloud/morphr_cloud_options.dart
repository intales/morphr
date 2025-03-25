class MorphrCloudOptions {
  final String projectId;
  final String endpoint;
  final String accessToken;
  final String refreshToken;

  const MorphrCloudOptions({
    required this.projectId,
    required this.endpoint,
    required this.accessToken,
    required this.refreshToken,
  });
}
