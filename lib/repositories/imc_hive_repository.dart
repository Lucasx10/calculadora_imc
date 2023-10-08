import 'package:dioproject/models/imc_hive_model.dart';
import 'package:hive/hive.dart';

class ImcHiveRepository {
  static late Box box;

  ImcHiveRepository._carregar();

  static Future<ImcHiveRepository> carregar() async {
    if (Hive.isBoxOpen('imcHiveModel')) {
      box = Hive.box('imcHiveModel');
    } else {
      box = await Hive.openBox('imcHiveModel');
    }
    return ImcHiveRepository._carregar();
  }

  salvar(ImcHiveModel imcHiveModel) {
    box.put('imcHiveModel', imcHiveModel);
  }

  Future<void> editar(ImcHiveModel imcHiveModel) async {
    final box = await Hive.openBox('imcHiveModel');
    await box.put('imcHiveModel', imcHiveModel);
  }

  ImcHiveModel obterDados() {
    var imcHiveModel = box.get('imcHiveModel');
    if (imcHiveModel == null) {
      return ImcHiveModel.vazio();
    }
    return imcHiveModel;
  }
}
