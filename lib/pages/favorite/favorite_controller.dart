import '../../common/apis/user_api.dart';
import '../../common/entities/FavorisRequest.dart';
import '../../common/entities/FavorisResponse.dart';

class FavoriteController {
  Future<FavorisResponse> addFavoris(FavorisRequest request) async {
    return await UserAPI.addFavoris(request);
  }

  Future<List<FavorisResponse>> getFavoris() async {
    return await UserAPI.getFavoris();
  }
}
