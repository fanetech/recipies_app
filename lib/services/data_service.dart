import 'package:recipies_app/models/recipie.dart';
import 'package:recipies_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipie>?> getRecipies(String filter) async {
    String path = '/recipes';
    if(filter.isNotEmpty){
      path += '/meal-type/$filter';
    }
    var response = await _httpService.get(path);

    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recipie> recipies = data.map((e) => Recipie.fromJson(e)).toList();
      print(recipies);
      return recipies;
    } else {
      print('erreur');
    }
  }
}
