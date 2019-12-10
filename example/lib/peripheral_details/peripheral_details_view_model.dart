import 'package:blemulator_example/scan/scan_result_view_model.dart';

class PeripheralDetailsViewModel {
  final String name;
  final String identifier;
  final PeripheralCategoryViewModel category;

  PeripheralDetailsViewModel(this.name, this.identifier, this.category);

  factory PeripheralDetailsViewModel.fromScanResult(ScanResultViewModel scanResult) {
    return PeripheralDetailsViewModel(
        scanResult.name, scanResult.identifier, scanResult.category);
  }

  @override
  List<Object> get props => [name, identifier, category];
}