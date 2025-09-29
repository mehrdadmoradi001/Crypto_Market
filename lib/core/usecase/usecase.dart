// Type: aza_return_usecase
// Params: Vorodi_haye_usecase
abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}
// کلاس NoParams برای UseCase هایی استفاده می‌شه که هیچ پارامتر ورودی ندارند
class NoParams {}