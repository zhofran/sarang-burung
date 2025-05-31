part of '../class/app_env.dart';

class AppApi {
  // production / live
  // static const String baseURL = 'https://service.tandycom.online/api';
  // static const String imageURL = 'https://service.tandycom.online/storage';

  // staging / dev
  static const String baseURL = 'https://gelajianest.jualsolusi.com/api';
  static const String imageURL = 'https://api.report_sarang.id/';

  static Future<bool> keepToken({
    required String token,
    required String username,
    required String password,
    required String siteId,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString('username', username);
    storage.setString('password', password);
    storage.setString('siteId', siteId);
    return storage.setString("token", token);
  }

  static Future<bool> removeToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove("username");
    storage.remove("password");
    storage.remove("siteId");
    // Response response = await AppApi.post(path: '/logout');

    // log('logout : ${response.data}', name: 'AppApi');

    return storage.remove("token");
  }

  static Future<bool> setAuth({required String value}) async {
    return (await SharedPreferences.getInstance())
        .setString('DATA_CURRENT_USER', value);
  }

  static Future getCurrentUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? currentAuth = storage.getString("DATA_CURRENT_USER");
    // log('curAuth : $currentAuth', name: 'Log current Auth');
    return User.fromJson(
      jsonDecode(
        currentAuth ??
            '{"id": "","fullname": "","email": ","nik": "","email_verified_at": "0000-00-00","referral_code": "","created_at": "0000-00-00","updated_at": "0000-00-00","deleted_at": "0000-00-00}',
      ),
    );
  }

  static Future getCurrentUserApi() async {
    try {
      Response response = await AppApi.get(path: '/me');

      log('response : $response', name: 'getCurrentUserApi');

      if (response.statusCode == 200) {
        // save data user
        UserModel dataCurrentUser =
            UserModel.fromJson(response.data['data'] ?? {});

        await AppApi.setAuth(value: jsonEncode(dataCurrentUser));

        return dataCurrentUser;
      }
    } catch (e) {
      log('err : $e', name: 'getCurrentUserApi');
    }
    return AppApi.getCurrentUser();
  }

  static Future get<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    // if (withToken) {
    //   SharedPreferences storage = await SharedPreferences.getInstance();
    //   String? token = storage.getString("token");
    //   // log('token : $token', name: 'AppApi');
    //   try {
    //     final response = await Dio().get<T>(
    //       baseURL + path,
    //       queryParameters: param,
    //       options: Options(
    //           headers: {
    //             "Authorization": "Bearer ${token!}",
    //             "Accept": "application/json"
    //           },
    //           receiveTimeout: AppConstant.timeout,
    //           sendTimeout: AppConstant.timeout),
    //     );
    //     return _returnResponse(response);
    //   } on DioException catch (e) {
    //     if (e.response!.statusCode! >= 500) {
    //       return _returnResponse(e.response!);
    //     } else {
    //       return e.response!;
    //     }
    //   }
    // } else {
      try {
        final response = await Dio().get<T>(
          baseURL + path,
          queryParameters: param,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response ?? Response(
          requestOptions: RequestOptions(path: path),
          statusCode: 500,
          statusMessage: "Unknown Error",
          data: {"error": "Unknown error occurred while making GET request"},
        ));
      }
    // }
  }

  static Future post<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      // log('token : $token', name: 'AppApi');
      try {
        final response = await Dio().post<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {
                  "Authorization": "Bearer ${token!}",
                  "Accept": "application/json",
                  "Content-Type": "application/json", 
                },
                receiveTimeout: AppConstant.timeout,
                sendTimeout: AppConstant.timeout),
            data: formdata);
        return _returnResponse(response);
      } on DioException catch (e) {
        log('err : $e', name: 'AppApi');
        if (e.response?.data['status']  >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    } else {
      try {
        final response = await Dio().post(
          baseURL + path,
          data: formdata,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );

        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response;
        }
      }
    }
  }
  
  static Future put<T extends Object>(
      {required String path,
      bool withToken = true,
      dynamic formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().put<T>(baseURL + path,
            queryParameters: param,
            options: Options(
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json"
              },
              // receiveTimeout: AppConstant.timeout,
              // sendTimeout: AppConstant.timeout,
            ),
            data: formdata);
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    } else {
      try {
        final response = await Dio().put<T>(
          baseURL + path,
          queryParameters: param,
          data: formdata != null ? FormData.fromMap(formdata) : null,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            // receiveTimeout: AppConstant.timeout,
            // sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        if (e.response!.statusCode! >= 500) {
          return _returnResponse(e.response!);
        } else {
          return e.response!;
        }
      }
    }
  }

  // static Future<Response> put<T extends Object>({
  //   required String path,
  //   bool withToken = true,
  //   Map<String, dynamic>? formdata,
  //   Map<String, dynamic>? param,
  // }) async {
  //   try {
  //     String fullUrl = "$baseURL$path";
  //     log("PUT Request: $fullUrl");
  //     log("Query Parameters: ${param.toString()}");
  //     log("Form Data: ${formdata.toString()}");

  //     Options options = Options(
  //       headers: {
  //         "Accept": "application/json",
  //       },
  //       receiveTimeout: AppConstant.timeout,
  //       sendTimeout: AppConstant.timeout,
  //     );

  //     // Jika `withToken` aktif, tambahkan Authorization header
  //     if (withToken) {
  //       SharedPreferences storage = await SharedPreferences.getInstance();
  //       String? token = storage.getString("token");

  //       if (token == null) {
  //         throw DioException(
  //           requestOptions: RequestOptions(path: fullUrl),
  //           error: "Token tidak ditemukan! Pastikan user sudah login.",
  //           type: DioExceptionType.unknown,
  //         );
  //       }

  //       options.headers!["Authorization"] = "Bearer $token";
  //     }

  //     final response = await Dio().put<T>(
  //       fullUrl,
  //       queryParameters: param,
  //       options: options,
  //       data: formdata != null ? FormData.fromMap(formdata) : null,
  //     );

  //     log("Response Status Code: ${response.statusCode}");
  //     log("Response Data: ${response.data}");

  //     return response;
  //   } on DioException catch (e) {
  //     log("DioException: ${e.message}");
  //     if (e.response != null) {
  //       log("Response Error Data: ${e.response?.data}");
  //       log("Response Status Code: ${e.response?.statusCode}");
  //     }

  //     return e.response ??
  //         Response(
  //           requestOptions: RequestOptions(path: path),
  //           statusCode: 500,
  //           statusMessage: "Unknown Error",
  //           data: {"error": "Unknown error occurred while making PUT request"},
  //         );
  //   } catch (e) {
  //     log("Unexpected Error: $e");

  //     return Response(
  //       requestOptions: RequestOptions(path: path),
  //       statusCode: 500,
  //       statusMessage: "Unexpected Error",
  //       data: {"error": e.toString()},
  //     );
  //   }
  // }

  // static Future put<T extends Object>(
  //     {required String path,
  //     bool withToken = true,
  //     Map<String, dynamic>? formdata,
  //     Map<String, dynamic>? param}) async {
  //   if (withToken) {
  //     SharedPreferences storage = await SharedPreferences.getInstance();
  //     String? token = storage.getString("token");
  //     try {
  //       final response = await Dio().put<T>(baseURL + path,
  //           queryParameters: param,
  //           options: Options(
  //               headers: {
  //                 "Authorization": "Bearer ${token!}",
  //                 "Accept": "application/json"
  //               },
  //               receiveTimeout: AppConstant.timeout,
  //               sendTimeout: AppConstant.timeout),
  //           data: formdata != null ? FormData.fromMap(formdata) : null);
  //       return _returnResponse(response);
  //     } on DioException catch (e) {
  //       if (e.response!.statusCode! >= 500) {
  //         return _returnResponse(e.response!);
  //       } else {
  //         return e.response!;
  //       }
  //     }
  //   } else {
  //     try {
  //       final response = await Dio().put<T>(
  //         baseURL + path,
  //         queryParameters: param,
  //         data: formdata != null ? FormData.fromMap(formdata) : null,
  //         options: Options(
  //           headers: {
  //             "Accept": "application/json",
  //           },
  //           receiveTimeout: AppConstant.timeout,
  //           sendTimeout: AppConstant.timeout,
  //         ),
  //       );
  //       return _returnResponse(response);
  //     } on DioException catch (e) {
  //       if (e.response!.statusCode! >= 500) {
  //         return _returnResponse(e.response!);
  //       } else {
  //         return e.response!;
  //       }
  //     }
  //   }
  // }

  static delete<T extends Object>(
      {required String path, bool withToken = true}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
              headers: {
                "Authorization": "Bearer ${token!}",
                "Accept": "application/json",
              },
              receiveTimeout: AppConstant.timeout,
              sendTimeout: AppConstant.timeout),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    } else {
      try {
        final response = await Dio().delete<T>(
          baseURL + path,
          options: Options(
            headers: {
              "Accept": "application/json",
            },
            receiveTimeout: AppConstant.timeout,
            sendTimeout: AppConstant.timeout,
          ),
        );
        return _returnResponse(response);
      } on DioException catch (e) {
        return _returnResponse(e.response!);
      }
    }
  }

  /// Parsing Error Message Mostly From API
  // static String parse(String value) {
  //   if (value.contains(
  //       "type 'String' is not a subtype of type 'Map<String, dynamic>'")) {
  //     return "[1015] Invalid JSON Response\n\nData yang diminta tidak sesuai\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("[DioErrorType.connectTimeout]")) {
  //     return "[522] Connection Timed Out\n\nServer Membutuhkan Waktu Terlalu Lama untuk Membalas Permintaan Data dari Perangkat Ini\n\nCoba Muat Ulang";
  //   } else if (value.contains("[DioErrorType.receiveTimeout]")) {
  //     return "[522] Received Timed Out\n\nPerangkat Membutuhkan Waktu Terlalu Lama untuk Menerima Permintaan Data dari Server\n\nCoba Muat Ulang";
  //   } else if (value.contains("Http status error [503]")) {
  //     return "[503] Service Unavailable\n\nLayanan Tidak Tersedia Entah Karena Kelebihan Muatan Atau Sedang Perawatan\n\nTunggu Selama Beberapa Saat Lagi";
  //   } else if (value.contains("Http status error [500]")) {
  //     return "[500] Internal Server Error\n\nKesalahan Dalam Server\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains('Http status error [429]')) {
  //     return "[429] Too Many Request\n\nPembatasan Server Karena Terlalu Sering Memuat Halaman\n\nCoba Logout dan Login Kembali atau Tunggu Beberapa Saat Sebelum Memuat Ulang Lagi";
  //   } else if (value.contains("Http status error [414]")) {
  //     return "[414] URI Too Long\n\nServer tidak mampu menampung kiriman data dari perangkat\n\nHubungi Pengembang untuk Memperbaikinya";
  //   } else if (value.contains("Http status error [413]")) {
  //     return "[413] Request entity too large\n\nServer tidak mampu menampung kiriman data melebihi batasan yang ditentukan\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains('Http status error [410]')) {
  //     return "[410] Gone\n\nJalur Yang Diakses Tidak Tersedia\n\nKembali dan Jelajahi Halaman Lainnya";
  //   } else if (value.contains("Http status error [405]")) {
  //     return "[405] Method Not Allowed\n\nServer Tidak Mendukung Permintaan Akses\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value
  //       .contains("The request returned an invalid status code of 404")) {
  //     return "[404] Not Found\n\nJalur Yang Diakses Telah Dihapus atau Sudah Dipindahkan\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("Http status error [403]")) {
  //     return "[403] Forbidden\n\nToken Sudah Kadaluwarsa, sepertinya ada yang menggunakan akunmu diperangkat lain\n\nLog Out dan coba Log In lagi";
  //   } else if (value.contains("Http status error [302]")) {
  //     return "[302] Found\n\nSumber daya yang diminta sudah dipindah.\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("Http status error [301]")) {
  //     return "[301] Moved Permanently\n\nSumber daya yang diminta sudah dipindah.\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("No route to host")) {
  //     return "[113] No Route to Host\n\nKoneksi Internet Tidak Dapat Mengakses Server.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Tidak";
  //   } else if (value.contains("Connection refused, errno = 111")) {
  //     return "[111] Connection Refused\n\nUpaya Untuk Menghubungkan Server dengan Aplikasi Ditolak.\n\nCoba Tunggu Beberapa Saat Lagi atau Hubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("Connection reset by peer")) {
  //     return "[104] Connection Reset By Peer\n\nServer menolak kiriman data.\n\nHubungi Pengembang Untuk Memperbaikinya";
  //   } else if (value.contains("Network is unreachable, errno = 101")) {
  //     return "[101] Network Error\n\nJaringan Internet Bermasalah.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Tidak";
  //   } else if (value.contains("Broken pipe, errno = 32")) {
  //     return "[32] Broken Pipe\n\nMasalah dari Jaringan atau dari Sisi Server.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Hubungi Pengembang Untuk Memperbaikinya";
  //   } else {
  //     return value;
  //   }
  // }
}

dynamic _returnResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 201:
      return response;
    case 400:
      throw BadRequestException(response.data['message']);
    case 401:
      throw UnauthorizedException(response.data['message']);
    case 403:
      throw ForbiddenException(response.data['message']);
    case 404:
      throw BadRequestException(response.data);
    case 500:
      throw FetchDataException('Internal Server Error');
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? details;

  AppException({this.details});

  @override
  String toString() {
    return '$details';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details) : super(details: details);
}

class BadRequestException extends AppException {
  BadRequestException(String? details) : super(details: details);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? details) : super(details: details);
}

class ForbiddenException extends AppException {
  ForbiddenException(String? details) : super(details: details);
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details) : super(details: details);
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details) : super(details: details);
}

class TimeOutException extends AppException {
  TimeOutException(String? details) : super(details: details);
}
