import 'package:dio/dio.dart';
import 'dart:async';

/*
 * 封装restful请求
 * 
 * get, post, put, patch, delete
 * 主要作用：为统一处理相关事务
 * --统一处理请求前缀；
 * --统一打印请求信息
 * --统一打印相应信息
 * --统一打印报错信息
 */

class DioUtils {
  //global dio object
  static Dio dio;

  //default options
  static const String API_PREFIX = '';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  //->get请求
  static void getHttp(String url) async {
    try {
      Response response = await Dio().get(url);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  //->post请求
  static void postHttp<T>(
    String url, {
    Map<String, String> parameters,
    Function(T t) onSuccess,
    Function(String errorText) onError,
  }) async {
    //定义请求参数：非空处理
    parameters = parameters ?? {};

    //参数处理
    parameters.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    try {
      print(parameters);
      Dio dio = _createInstance();
      print(dio);
      Response response = await dio.post(url, data: parameters);
      if (response != null && response.statusCode == 200) {
        if (onSuccess != null) onSuccess(response.data);
      } else {
        throw Exception('statusCode:${response.statusCode}');
      }
      print('相应数据: ' + response.toString());
    } catch (e) {
      print('请求出错: ' + e.toString());
      onError(e.toString());
    }
  }

  //->request请求

  //->创建dio实例
  static Dio _createInstance() {
    if (dio == null) {
      var options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return true; //不使用http状态码判断状态，使用AdapterInterceptor来处理(适用于标准Rest风格)
        },
        baseUrl: "http://poetry.huhustory.com/",
      );
      dio = new Dio(options);
    }
    return dio;
  }

  //->回收dio
  static void _clear() {
    dio = null;
  }
}
