import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app_task/Models/error_response.dart';
import 'package:weather_app_task/Models/weatherForFiveDays.dart';
import 'package:weather_app_task/Models/weatherForOneDay.dart';

import 'api_constant.dart';

enum RequestType {
  GetOnedayWeather,
  GetFiveDaysWeather,
  GetLocation,
}

dynamic getRequestBody(String requestBody) {
  return requestBody;
}

String genericHandleErrorResponse(ErrorResponse errorResponse) {
  logD(errorResponse.message.toString() + errorResponse.key.toString());

  if (errorResponse.message == CODE_1) {
    return "There is no internet connection!";
  } else if (errorResponse.message == CODE_2) {
    return 'Server error check with Adminstrator! \n' + errorResponse.error!;
  } else if (errorResponse.code != null && errorResponse.code == CODE_401) {
    return 'token Expired';
  } else {
    return 'Invalid error ,try Again later ';
  }
}

Future<dynamic> getCallService(String url, RequestType requestType,
    {String? headerToken}) async {
  logD('get url $url');
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(url), headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // if (headerToken != null)
          //   HttpHeaders.authorizationHeader: 'Bearer $headerToken',
        }).timeout(const Duration(seconds: 60));
        final statusCode = response.statusCode;
        logD('statusCode $statusCode');
        logD('response ${response.body}');
        if (statusCode != 200) {
          logD('error response ${response.body}');
          if (statusCode > 500 && statusCode < 599) {
            throw ErrorResponse(
                message: CODE_2, error: "statusCode:" + statusCode.toString());
          } else if (statusCode == 401) {
            var errorResponse = errorResponseFromJson(response.body);
            throw ErrorResponse(
                code: CODE_401,
                key: errorResponse.key,
                message: errorResponse.message,
                error: errorResponse.error);
          } else {
            var errorResponse = errorResponseFromJson(response.body);
            throw ErrorResponse(
                code: errorResponse.code,
                key: errorResponse.key,
                message: errorResponse.message,
                error: errorResponse.error);
          }
        }
        switch (requestType) {
          case RequestType.GetFiveDaysWeather:
            return weatherForFiveDayesResponse(response.body);

          case RequestType.GetOnedayWeather:
            return oneDayWeatherModelResponse(response.body);

          default:
            {}
        }
      } on NoSuchMethodError catch (e) {
        logD('error here $e');

        throw ErrorResponse(
            message: CODE_2, error: e.toString() + " NoSuchMethodError");
      } on SocketException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, error: e.message + " SocketException");
      } on TimeoutException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, error: e.message! + " TimeoutException");
      } on HandshakeException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, error: e.message + " HandshakeException");
      } on TypeError catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, error: '${e.toString()} TypeError');
      } on FormatException catch (e) {
        logD('error here $e');
        throw ErrorResponse(
            message: CODE_2, error: e.message + "formatException");
      } catch (e) {}
    }
  } on SocketException catch (e) {
    print('aaaa');
    logD('error here $e');
    throw ErrorResponse(message: CODE_1);
  }
}
