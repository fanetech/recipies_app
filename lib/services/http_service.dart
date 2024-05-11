import 'package:dio/dio.dart';
import 'package:recipies_app/consts.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();
  final _dio = Dio();
  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final options = BaseOptions(
      headers: headers,
      baseUrl: API_BASE_URL,
      validateStatus: (status) {
       if(status == null) return false;
       return status < 500;
      }
    );
    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      print(e);
    }
  }
}
