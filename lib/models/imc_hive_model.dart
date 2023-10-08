import 'package:hive/hive.dart';

part 'imc_hive_model.g.dart';

@HiveType(typeId: 0)
class ImcHiveModel extends HiveObject {
  @HiveField(0)
  double? peso;

  @HiveField(1)
  double? altura;

  @HiveField(2)
  double? imc;

  @HiveField(3)
  String? situacao = "";

  ImcHiveModel();

  ImcHiveModel.vazio() {
    peso = 0;
    altura = 0;
    imc = 0;
    situacao = "";
  }
}
