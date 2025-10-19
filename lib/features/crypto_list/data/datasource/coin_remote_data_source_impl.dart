import 'package:flutter/foundation.dart';

import '../../../../config/app_config.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/entities/crypto.dart';
import '../dtos/crypto_dto.dart';
import '../mappers/crypto_mapper.dart';
import 'coin_remote_data_source.dart';

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  final ApiService _apiService;
  CoinRemoteDataSourceImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<List<Crypto>> getCoinList({String? query}) async {
    try {
      // ۱. آماده‌سازی پارامترهای درخواست برای API v3
      // apiKey و پارامتر جستجو (در صورت وجود) در اینجا اضافه می‌شوند
      final Map<String, dynamic> queryParameters = {
        'apiKey': AppConfig.config.apiKey,
      };

      if (query != null && query.isNotEmpty) {
        queryParameters['search'] = query;
      }

      debugPrint("1. Calling ApiService getAssets with parameters: $queryParameters");
      final response = await _apiService.getAssets(queryParameters: queryParameters);
      debugPrint("2. Response received in DataSource.");

      // ۲. تبدیل داده خام JSON به لیست DTO
      // این مرحله به لطف DTO بسیار امن است و در مقابل داده‌های غیرمنتظره مقاوم است
      final List<dynamic> data = response['data'];
      debugPrint("3. Parsing ${data.length} items into DTOs.");
      final dtoList = data
          .map<CryptoDTO>((jsonMapObject) => CryptoDTO.fromMapJson(jsonMapObject))
          .toList();

      // ۳. تبدیل لیست DTO به لیست Entity با استفاده از Mapper
      // تمام منطق تبدیل نوع و مدیریت null در Mapper کپسوله شده است
      debugPrint("4. Mapping DTOs to Entities.");
      final result = CryptoMapper.fromDTOList(dtoList);
      debugPrint("5. Mapping completed successfully. Returning Entities.");
      return result;

    } catch (e, stackTrace) {
      // خطا به لایه‌های بالاتر ارسال می‌شود تا مدیریت شود (مثلاً در BLoC)
      debugPrint("!!! ERROR in CoinRemoteDataSourceImpl: $e");
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}