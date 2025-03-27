import 'package:morphr/cloud/morphr_cloud_client.dart';
import 'helpers/config_helper.dart';

MorphrCloudClient getClient({
  required final String server,
}) {
  final config = ConfigHelper.loadConfig();

  final accessToken = config["access_token"] as String?;
  final refreshToken = config["refresh_token"] as String?;

  final client = MorphrCloudClient(
    baseUrl: server,
    accessToken: accessToken,
    refreshToken: refreshToken,
    onTokenRefreshed: (accessToken, refreshToken) => _onTokenRefreshed(
      accessToken: accessToken,
      refreshToken: refreshToken,
    ),
  );

  return client;
}

void _onTokenRefreshed({
  required final String accessToken,
  required final String refreshToken,
}) {
  ConfigHelper.updateConfig({
    "access_token": accessToken,
    "refresh_token": refreshToken,
  });
}
