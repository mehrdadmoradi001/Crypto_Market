// In: data/mappers/crypto_mapper.dart

import '../../domain/entities/crypto.dart';
import '../dtos/crypto_dto.dart';

class CryptoMapper {
  /// یک نمونه DTO را به یک نمونه Entity تبدیل می‌کند
  static Crypto fromDTO(CryptoDTO dto) {
    return Crypto(
      id: dto.id ?? '', // مدیریت null
      name: dto.name ?? 'Unknown',
      symbol: dto.symbol ?? '',
      changePercent24hr: _parseDouble(dto.changePercent24Hr), // استفاده از منطق تبدیل
      priceUsd: _parseDouble(dto.priceUsd),
      marketCapUsd: _parseDouble(dto.marketCapUsd),
      rank: _parseInt(dto.rank),
    );
  }

  /// یک لیست از DTOها را به لیستی از Entityها تبدیل می‌کند
  static List<Crypto> fromDTOList(List<CryptoDTO> dtoList) {
    // اینجا از متد fromDTO که در بالا تعریف شده برای تبدیل تک تک آیتم‌ها استفاده می‌کنیم
    return dtoList.map((dto) => fromDTO(dto)).toList();
  }

  // توابع تبدیل نوع به اینجا منتقل می‌شوند
  static double _parseDouble(dynamic value, {double defaultDoubleValue = 0.0}) {
    if (value == null) return defaultDoubleValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? defaultDoubleValue;
    }
    return defaultDoubleValue;
  }

  /// با اطمینان یک مقدار dynamic را به int تبدیل می‌کند
  static int _parseInt(dynamic value, {int defaultIntValue = 0}) {
    if (value == null) return defaultIntValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? defaultIntValue;
    }
    return defaultIntValue;
  }
}