import '../nc_cookbook_api.dart';

const _supportedEpoch = 0;
const _supportedMajor = 1;
const _supportedMinor = 1;

extension CookbookVersionSupported on NcCookbookApi {
  /// Checks if the app on the server is supported by the client
  Future<int> isSupported() async {
    final response = await getMiscApi().version();

    return isSupportedSync(response.data!.apiVersion);
  }

  int isSupportedSync(APIVersion apiVersion) {
    if (apiVersion.epoch == _supportedEpoch &&
        apiVersion.major == _supportedMajor &&
        apiVersion.minor == _supportedMinor) {
      // If is tested and target version
      return 0;
    } else if ((apiVersion.epoch >= _supportedEpoch) &&
        (apiVersion.major >= _supportedMajor || (apiVersion.major < _supportedMajor && apiVersion.epoch > _supportedEpoch)) &&
        (apiVersion.minor >= _supportedMinor || (apiVersion.minor < _supportedMinor && apiVersion.epoch > _supportedEpoch)) || (apiVersion.minor < _supportedMinor && apiVersion.major > _supportedMajor)) {
      // If is above supported version
      return 1;
    } else {
      // If is below supported version
      return -1;
    }
  }
}
