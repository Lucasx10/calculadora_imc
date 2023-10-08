import 'package:dioproject/models/imcCalculo.dart';
import 'package:dioproject/models/imc_hive_model.dart';
import 'package:dioproject/repositories/imc_hive_repository.dart';
import 'package:flutter/material.dart';

class DadosHiveImc extends StatefulWidget {
  const DadosHiveImc({super.key});

  @override
  State<DadosHiveImc> createState() => _DadosImcHiveState();
}

class _DadosImcHiveState extends State<DadosHiveImc> {
  late ImcHiveRepository imcHiveRepository;
  var imcHiveModel = ImcHiveModel.vazio();

  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  double imc = 0;
  var situacao = "";
  var calculoimc = IMCCalculo();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    imcHiveRepository = await ImcHiveRepository.carregar();
    imcHiveModel = imcHiveRepository.obterDados();
    pesoController.text = (imcHiveModel.peso ?? 0).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),

            //TextField for Peso Value
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Preencha com seu peso em Kg, por favor:",
                style: TextStyle(fontSize: 18),
              ),
            ),

            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  imcHiveModel.peso = double.tryParse(pesoController.text);
                });
              },
            ),

            const SizedBox(
              height: 15,
            ),

            //TextField for Altura value

            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Preencha com sua altura em metros, por favor:",
                style: TextStyle(fontSize: 18),
              ),
            ),

            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  imcHiveModel.altura = double.tryParse(alturaController.text);
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),

            //Calculate IMC
            Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                      child: Text("Calcular"),
                      onPressed: () async {
                        // setState(() {
                        //   imcHiveModel.peso = double.parse(pesotext);
                        //   imcHiveModel.altura = double.parse(alturatext);
                        // });
                        //Check if fields are empty
                        if (pesoController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("O peso deve ser preenchido"),
                            ),
                          );
                        } else if (imcHiveModel.altura == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erro, altura igual ou menor a 0"),
                            ),
                          );
                        } else if (alturaController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("A altura deve ser preenchida"),
                            ),
                          );
                        } else if ((alturaController.text.contains(",")) ||
                            (pesoController.text.contains(","))) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Por favor use apenas \".\" para inserir os dados"),
                            ),
                          );
                        } else {
                          //Store values

                          setState(() {
                            //Calculate
                            imc = calculoimc.Calculo(
                                imcHiveModel.peso, imcHiveModel.altura);
                            situacao = calculoimc.Situacao(imc);
                          });

                          imcHiveModel.altura =
                              double.parse(alturaController.text);
                          imcHiveModel.peso = double.parse(pesoController.text);
                          imcHiveModel.imc = imc;
                          imcHiveModel.situacao = situacao;

                          imcHiveRepository.salvar(imcHiveModel);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Resultado",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
            ),

            //Shows results
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Text(
                          "IMC: ${imc.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Sua situação é: \n$situacao",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
