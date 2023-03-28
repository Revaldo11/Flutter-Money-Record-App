import 'package:get/get.dart';
import 'package:money_record/source/source_analysis.dart';

class HomeController {
  final _today = 0.0.obs;
  double get today => _today.value;

  final _todayPercent = '0'.obs;
  String get todayPercent => _todayPercent.value;

  getAnalysis(String idUser) async {
    Map data = await SourceHistory.analysis(idUser);

    // today outcome
    _today.value = data['today'];
    double yesterday = data['yesterday'];
    double different = (today - yesterday).abs();
    bool isSame = today.isEqual(yesterday);
    bool isPlus = today.isGreaterThan(yesterday);
    double byYesterday = yesterday == 0 ? 1 : yesterday;
    double percent = (different / byYesterday) * 100;
    _todayPercent.value = isSame
        ? '100% sama dengan kemarin'
        : isPlus
            ? '+${percent.toStringAsFixed(1)}% dari kemarin'
            : '-${percent.toStringAsFixed(1)}% dari kemarin';
  }
}
