import 'dart:convert';
import 'dart:io';

import 'package:bookkeeping/app_data.dart';
import 'package:bookkeeping/app_tools.dart';
import 'package:bookkeeping/bean/achievement_bean.dart';
import 'package:bookkeeping/bean/bar_chart_mon_bean.dart';
import 'package:bookkeeping/bean/bar_chart_week_bean.dart';
import 'package:bookkeeping/bean/bar_chart_year_bean.dart';
import 'package:bookkeeping/bean/bill_bean.dart';
import 'package:bookkeeping/bean/bookkeeping_suggest_bean.dart';
import 'package:bookkeeping/bean/crop_enhance_bean.dart';
import 'package:bookkeeping/bean/exchange_rate_bean.dart';
import 'package:bookkeeping/bean/expect_expend_bean.dart';
import 'package:bookkeeping/bean/home_data_bean.dart';
import 'package:bookkeeping/bean/login_bean.dart';
import 'package:bookkeeping/bean/receipt_classify.dart';
import 'package:bookkeeping/bean/search_bill_bean.dart';
import 'package:bookkeeping/bean/shop_ticket_bean.dart';
import 'package:bookkeeping/bean/speech_recognition_bean.dart';
import 'package:bookkeeping/bean/text_sort_bean.dart';
import 'package:bookkeeping/bean/total_mon_data_bean.dart';
import 'package:bookkeeping/bean/train_ticket_bean.dart';
import 'package:bookkeeping/bean/universal_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppNet {
  static Dio dio = Dio();

  static late final String baseURL;
  // static String _registerURL = '${baseURL}register/';
  // static String _loginURL = '${baseURL}login/';
  // static String _sendPinURL = '${baseURL}send_text/';
  // static String _getBillURL = '${baseURL}get_record/';
  // static String _searchURL = '${baseURL}get_search_record/';
  // static String _newBill = '${baseURL}input_record/';
  // static String _changeBill = '${baseURL}change_record/';
  // static String _deleteBill = '${baseURL}delete_record/';
  // static String _barChartYear = '${baseURL}get_line_year_record/';
  // static String _barChartMon = '${baseURL}get_line_month_record/';
  // static String _barChartWeek = '${baseURL}get_line_week_record/';
  // static String _exchangeRateURL = '${baseURL}huilv/';
  // static String _achievementURL = '${baseURL}achievement/';
  // static String _homeDataURL = '${baseURL}get_all_record/';
  // static String _expectExpendURL = '${baseURL}forcase/';
  // static String _totalMonDataURL = '${baseURL}get_all_month_record/';
  // static String _textSortURL = '${baseURL}fff/';
  // static String _bookkeepingSuggestURL = '${baseURL}huaxiang/';
  // static String _speechRecognitionURL = '${baseURL}yuyinshibie/';

  static late String _registerURL;
  static late String _loginURL;
  static late String _sendPinURL;
  static late String _getBillURL;
  static late String _searchURL;
  static late String _newBill;
  static late String _changeBill;
  static late String _deleteBill;
  static late String _barChartYear;
  static late String _barChartMon;
  static late String _barChartWeek;
  static late String _exchangeRateURL;
  static late String _achievementURL;
  static late String _homeDataURL;
  static late String _expectExpendURL;
  static late String _totalMonDataURL;
  static late String _textSortURL;
  static late String _bookkeepingSuggestURL;
  static late String _speechRecognitionURL;

  static getBaseURL() async {
    Response response =
        await dio.get('https://princesaoke.github.io/PrinceSaoKe.txt');
    if (kDebugMode) {
      debugPrint('--------------------------baseURL--------------------------');
      debugPrint(response.data.toString());
    }
    if (response.statusCode == 200) {
      Map map = jsonDecode(response.toString());
      String url = map['bookkeeping_base_url'];
      baseURL = url;
    } else {
      baseURL = 'https://47.99.83.24:11451/';
    }
    _registerURL = '${baseURL}register/';
    _loginURL = '${baseURL}login/';
    _sendPinURL = '${baseURL}send_text/';
    _getBillURL = '${baseURL}get_record/';
    _searchURL = '${baseURL}get_search_record/';
    _newBill = '${baseURL}input_record/';
    _changeBill = '${baseURL}change_record/';
    _deleteBill = '${baseURL}delete_record/';
    _barChartYear = '${baseURL}get_line_year_record/';
    _barChartMon = '${baseURL}get_line_month_record/';
    _barChartWeek = '${baseURL}get_line_week_record/';
    _exchangeRateURL = '${baseURL}huilv/';
    _achievementURL = '${baseURL}achievement/';
    _homeDataURL = '${baseURL}get_all_record/';
    _expectExpendURL = '${baseURL}forcase/';
    _totalMonDataURL = '${baseURL}get_all_month_record/';
    _textSortURL = '${baseURL}fff/';
    _bookkeepingSuggestURL = '${baseURL}huaxiang/';
    _speechRecognitionURL = '${baseURL}yuyinshibie/';
  }

  /// 注册
  static Future<UniversalBean> register({
    required String tele,
    required String userName,
    required String password,
    required String password2,
    required String pin,
  }) async {
    FormData formData = FormData.fromMap({
      'telephone': tele,
      'username': userName,
      'password': password,
      'password2': password2,
      'user_code': pin,
    });
    Response response = await dio.post(_registerURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return UniversalBean.fromMap(response.data);
  }

  /// 登录
  static Future<LoginBean> login({
    required String tele,
    required String password,
  }) async {
    FormData formData = FormData.fromMap(
      {'telephone': tele, 'password': password},
    );
    Response response = await dio.post(_loginURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data.toString());
    }
    return LoginBean.formMap(response.data);
  }

  /// 发送验证码
  static Future<UniversalBean> sendPin({required String tele}) async {
    FormData formData = FormData.fromMap({'telephone': tele});
    Response response = await dio.post(_sendPinURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data.toString());
    }
    return UniversalBean.fromMap(response.data);
  }

  /// 增加账单
  static Future<UniversalBean> newBill({
    int? userID,
    required String type,
    required String subtype,
    required String receiptType,
    required DateTime time,
    required double money,
    required String from,
    required String item,
    File? image,
    String? remark,
  }) async {
    FormData formData = FormData.fromMap({
      'user_id': (userID ?? AppData().currUserID).toString(),
      'type': type,
      'subtype': subtype,
      'bill': receiptType,
      'date': AppTools.toY0M0D(time),
      'time': '${AppTools.to0Hour0Min(time)}:00',
      'money': money.toString(),
      'froms': from,
      'value': item,
      if (image != null) 'image': await MultipartFile.fromFile(image.path),
      'remarks': remark,
    });
    Response response = await dio.post(_newBill, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return UniversalBean.fromMap(response.data);
  }

  /// 修改账单
  static Future<UniversalBean> changeBill({
    required int billID,
    String? type,
    String? subtype,
    String? receiptType,
    DateTime? time,
    double? money,
    String? from,
    String? item,
    File? image,
    String? remark,
  }) async {
    FormData formData = FormData.fromMap({
      'user_id': billID.toString(),
      'type': type,
      'subtype': subtype,
      'bill': receiptType,
      'date': time == null ? null : AppTools.toY0M0D(time),
      'time': time == null ? null : AppTools.to0Hour0Min(time),
      'money': money?.toString(),
      'froms': from,
      'value': item,
      'image': image,
      'remarks': remark,
    });
    Response response = await dio.post(_changeBill, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return UniversalBean.fromMap(response.data);
  }

  /// 删除账单
  static Future<UniversalBean> deleteBill({required int billID}) async {
    FormData formData = FormData.fromMap({'id': billID});
    Response response = await dio.post(_deleteBill, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return UniversalBean.fromMap(response.data);
  }

  /// 获取单个账单的信息
  static Future<BillBean> getBill({required int billID}) async {
    Response response = await dio.get(
      _getBillURL,
      queryParameters: {'id': billID},
    );
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return BillBean.fromMap(response.data);
  }

  /// 获取首页信息
  static Future<HomeDataBean> getHomeData({
    int? userID,
    required DateTime date,
  }) async {
    if (kDebugMode) {
      debugPrint('-------------获取首页信息----------------------------');
      debugPrint(_homeDataURL);
      debugPrint('-------------获取首页信息结束----------------------------');
    }
    Response response = await dio.get(_homeDataURL, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'date': AppTools.toY0M0D(date)
    });
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return HomeDataBean.fromMap(response.data);
  }

  /// 首页搜索
  static search({
    required int userID,
    required String searchString,
    String? order,
    String? type = 'expand',
    DateTime? startTime,
    DateTime? endTime,
    double? minMoney,
    double? maxMoney,
    required subtype,
  }) async {
    FormData formData = FormData.fromMap({
      'user_id': userID,
      'search': searchString,
      'order': order,
      'type': type,
      'str_date': startTime == null ? null : AppTools.toY0M0D(startTime),
      'end_date': endTime == null ? null : AppTools.toY0M0D(endTime),
      'str_money': minMoney.toString(),
      'end_money': maxMoney.toString(),
      'subtype': subtype,
    });
    Response response = await dio.post(_searchURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return SearchBillBean.fromMap(response.data);
  }

  /// 汇率转换
  static Future<ExchangeRateBean> exchangeRate(
      {required String currCountry, required double currMoney}) async {
    FormData formData = FormData.fromMap(
      {'type1': currCountry, 'money1': currMoney},
    );
    Response response = await dio.post(_exchangeRateURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return ExchangeRateBean.fromMap(response.data);
  }

  /// 获取成就数据
  static Future getAchievementData({int? userID}) async {
    Response response = await dio.get(
      _achievementURL,
      queryParameters: {'user_id': userID ??= AppData().currUserID},
    );
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return AchievementBean.fromMap(response.data);
  }

  /// 年柱状图
  static Future<BarChartYearBean> getBarChartYearData({
    int? userID,
    String type = 'expend',
    required int year,
  }) async {
    Response response = await dio.get(_barChartYear, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'type': type,
      'year': year,
    });
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return BarChartYearBean.fromMap(response.data);
  }

  /// 月柱状图
  static Future<BarChartMonBean> getBarChartMonthData({
    int? userID,
    String type = 'expend',
    required int year,
    required int month,
    String? subType,
  }) async {
    Response response = await dio.get(_barChartMon, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'type': type,
      'year': year,
      'month': month,
      'subtype': subType,
    });
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return BarChartMonBean.fromMap(response.data);
  }

  /// 周柱状图
  static Future<BarChartWeekBean> getBarChartWeekData({
    int? userID,
    String type = 'expend',
    required DateTime dateTime,
  }) async {
    Response response = await dio.get(_barChartWeek, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'type': type,
      'year': dateTime.year,
      'month': dateTime.month,
      'day': dateTime.day,
    });
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return BarChartWeekBean.fromMap(response.data);
  }

  /// 预测下月消费
  static Future<ExpectExpendBean> expectExpend({
    int? userID,
    String type = 'expend',
    required DateTime date,
    String? subType,
  }) async {
    FormData formData = FormData.fromMap({
      'user_id': userID ?? AppData().currUserID,
      'type1': type,
      'date': AppTools.toY0M0D(date),
      'subtype': subType,
    });
    Response response = await dio.post(_expectExpendURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return ExpectExpendBean.fromMap(response.data);
  }

  /// 月总数据
  static Future<TotalMonDataBean> totalMonData({
    int? userID,
    String type = 'expend',
    required DateTime dateTime,
    String? subType,
  }) async {
    if (kDebugMode) {
      debugPrint((userID ?? AppData().currUserID).toString());
      debugPrint(dateTime.year.toString());
      debugPrint(dateTime.month.toString());
      debugPrint(subType);
      debugPrint(type);
    }
    if (subType == '') subType = null;
    Response response = await dio.get(_totalMonDataURL, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'type': type,
      'year': dateTime.year,
      'month': dateTime.month,
      if (subType != null) 'subtype': subType,
    });
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return TotalMonDataBean.fromMap(response.data);
  }

  /// 文本分类
  static Future<TextSortBean> textSort({required String text}) async {
    if (kDebugMode) {
      debugPrint(text);
    }
    Response response =
        await dio.get(_textSortURL, queryParameters: {'text': text});
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return TextSortBean.fromMap(response.data);
  }

  /// 用户画像、布奇建议
  static Future<BookkeepingSuggestBean> bookkeepingSuggest({
    int? userID,
    required DateTime dateTime,
  }) async {
    Response response = await dio.get(_bookkeepingSuggestURL, queryParameters: {
      'user_id': userID ?? AppData().currUserID,
      'date': AppTools.toY0M0D(dateTime),
    });
    if (response.data['status'] == 404) {
      return bookkeepingSuggest(userID: userID, dateTime: dateTime);
    }
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return BookkeepingSuggestBean.fromMap(response.data);
  }

  /// 语音识别
  static Future<SpeechRecognitionBean> speechRecognition({
    required String filePath,
    String language = '中文',
  }) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'yuzhong': language,
    });
    Response response = await dio.post(_speechRecognitionURL, data: formData);
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return SpeechRecognitionBean.fromMap(response.data);
  }

  static const _shopTicketURL = 'https://api.textin.com/robot/v1.0/api/receipt';
  static const _cropEnhanceURL =
      'https://api.textin.com/ai/service/v1/crop_enhance_image?';
  static const _receiptClassifyURL =
      'https://api.textin.com/robot/v1.0/api/general_receipt_classify';
  static const _trainTicketURL =
      'https://api.textin.com/robot/v1.0/api/train_ticket';

  /// 商铺小票识别
  static Future<ShopTicketBean> shopTicketOCR(File file) async {
    Uint8List image = file.readAsBytesSync();
    var data = Stream.fromIterable(image.map((e) => [e]));
    Response response = await dio.post(
      _shopTicketURL,
      data: data,
      options: _options,
    );
    return ShopTicketBean.fromMap(response.data);
  }

  /// 火车票识别
  static Future<TrainTicketBean> trainTicketOCR(File file) async {
    Uint8List image = file.readAsBytesSync();
    var data = Stream.fromIterable(image.map((e) => [e]));
    Response response = await dio.post(
      _trainTicketURL,
      data: data,
      options: _options,
    );
    return TrainTicketBean.fromMap(response.data);
  }

  /// 图片裁剪增强
  static Future<CropEnhanceBean> cropEnhance(
    File file, {
    bool needCrop = true,
    bool correctDirection = false,
    int? enhanceMode,
    bool roundImage = false,
    bool onlyPostion = false,
    int quality = 95,
    int? cropScene,
    String? sizeAndPositon,
  }) async {
    Uint8List image = file.readAsBytesSync();
    String realURL = _cropEnhanceURL;

    if (enhanceMode != null) realURL += '&enhance_mode=$enhanceMode';
    if (!needCrop) realURL += '&crop_image=0';
    if (cropScene != null) realURL += '&crop_scene=$cropScene';
    if (onlyPostion) realURL += '&only_position=$onlyPostion';
    if (roundImage) realURL += '&round_image=1';
    if (correctDirection) realURL += '&correct_direction=1';
    if (sizeAndPositon != null) realURL += '&size_and_positon=$sizeAndPositon';
    realURL += '&jpeg_quality=$quality';
    if (kDebugMode) {
      debugPrint(realURL);
    }

    Response response = await dio.post(
      realURL,
      data: Stream.fromIterable(image.map((e) => [e])),
      options: _options,
    );
    if (kDebugMode) {
      debugPrint(response.data);
    }
    return CropEnhanceBean.fromMap(response.data);
  }

  /// 票据分类
  static Future<ReceiptClassifyBean> receiptClassify(File file) async {
    Uint8List image = file.readAsBytesSync();
    var data = Stream.fromIterable(image.map((e) => [e]));
    Response response = await dio.post(
      _receiptClassifyURL,
      data: data,
      options: _options,
    );
    return ReceiptClassifyBean.fromMap(response.data);
  }

  /// 合合信息请求头
  static final Options _options = Options(
    headers: {
      'x-ti-app-id': '915a6127a44de7e068c1583405c2510a',
      'x-ti-secret-code': '08144fbc51a5f67f539e109b0a727836',
    },
  );
}
