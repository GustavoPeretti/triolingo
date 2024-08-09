// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:triolingo/database/dao/palavradao.dart';

import 'package:triolingo/database/dao/preferenciadao.dart';
import 'package:triolingo/database/dao/traducaodao.dart';
import 'package:triolingo/model/traducao.dart';

late Traducao traducao;
late List<Map<String, Object?>> dicionario;

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  if ((await buscarLingua()).isNotEmpty) {
    traducao = Traducao.fromMap((await buscarTraducao((await buscarLingua()).first.values.first.toString())).first);
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: (await buscarLingua()).isEmpty ? const HomePage() : const Preferencia(),
    theme: ThemeData(useMaterial3: true, fontFamily: 'Dosis'),
  ));
}

// ignore: must_be_immutable
class ScaffoldPadrao extends StatelessWidget {
  Widget? body;
  bool temConfiguracoes;

  ScaffoldPadrao({super.key, this.body, this.temConfiguracoes = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Triolingo',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 251, 183),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: temConfiguracoes
            ? [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Configuracoes()));
                    },
                    icon: const Icon(Icons.settings))
              ]
            : null,
        backgroundColor: const Color.fromARGB(255, 79, 41, 88),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 251, 183)),
      ),
      body: body,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      temConfiguracoes: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/img/tesouro.gif',
              height: 250,
            ),
            const Text(
              'Vocabulário: seu tesouro de ferramentas!',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Selecione sua língua principal',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    alterarLingua('portugues');
                    traducao = Traducao.fromMap((await buscarTraducao('portugues')).first);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Preferencia()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/img/brasil-bandeira.jpg'),
                      ),
                      title: Text(
                        'Português',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    alterarLingua('ingles');
                    traducao = Traducao.fromMap((await buscarTraducao('ingles')).first);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Preferencia()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/img/eua-bandeira.jpg'),
                      ),
                      title: Text(
                        'Inglês',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    alterarLingua('latim');
                    traducao = Traducao.fromMap((await buscarTraducao('latim')).first);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Preferencia()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(
                            'assets/img/sacro-imperio-romano-bandeira.jpg'),
                      ),
                      title: Text(
                        'Latim',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Preferencia extends StatelessWidget {
  const Preferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/gatito.gif',
              height: 250,
            ),
            Text(
              traducao.desejoAprimorar,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    dicionario = await buscarPares(traducao.lingua, 'portugues');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/img/brasil-bandeira.jpg'),
                      ),
                      title: Text(
                        traducao.portugues,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    dicionario = await buscarPares(traducao.lingua, 'ingles');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/img/eua-bandeira.jpg'),
                      ),
                      title: Text(
                        traducao.ingles,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    dicionario = await buscarPares(traducao.lingua, 'latim');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(255, 91, 124, 141),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(
                            'assets/img/sacro-imperio-romano-bandeira.jpg'),
                      ),
                      title: Text(
                        traducao.latim,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage:
                AssetImage('assets/img/sacro-imperio-romano-bandeira.jpg'),
          ),
          const Text(
            'Latim',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Conhecidas()));
                },
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        color: const Color.fromARGB(255, 102, 182, 171),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: PieChart(PieChartData(sections: [
                                PieChartSectionData(
                                    value: 67,
                                    radius: 25,
                                    title: '67%',
                                    titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                    color:
                                        const Color.fromARGB(255, 79, 29, 58)),
                                PieChartSectionData(
                                    value: 33,
                                    radius: 25,
                                    titleStyle:
                                        const TextStyle(color: Colors.white),
                                    color: Colors.white)
                              ])),
                            ),
                            const Text(
                              'Conheço 34 palavras',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ParaRevisar()));
                },
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        color: const Color.fromARGB(255, 102, 182, 171),
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            const Text(
                              '10',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              traducao.paraRevisar,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 32.0),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                blurRadius: 32,
                spreadRadius: -8,
              ),
            ]),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: const ContinuousRectangleBorder(),
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Cogito',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const SizedBox(
                        width: 300,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        )),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 120,
                            child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      ContinuousRectangleBorder()),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 79, 29, 58))),
                              child: Text(
                                traducao.conheco,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                        SizedBox(
                            width: 120,
                            child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      ContinuousRectangleBorder()),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 79, 29, 58))),
                              child: Text(
                                traducao.naoConheco,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class Conhecidas extends StatelessWidget {
  const Conhecidas({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      temConfiguracoes: true,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
              child: Text(
            traducao.palavrasConhecidas,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          )),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            tileColor: const Color.fromARGB(255, 255, 251, 183),
            title: const Text(
              'Palavra',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Lorem ipsum dolor sit amet consectetur adisciping elit...'),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                )),
          )
        ],
      ),
    );
  }
}

class ParaRevisar extends StatelessWidget {
  const ParaRevisar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      temConfiguracoes: true,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
              child: Text(
            traducao.paraRevisar,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          )),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            tileColor: const Color.fromARGB(255, 255, 251, 183),
            title: const Text(
              'Palavra',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Lorem ipsum dolor sit amet consectetur adisciping elit...'),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check,
                )),
          )
        ],
      ),
    );
  }
}

class Configuracoes extends StatelessWidget {
  const Configuracoes({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      temConfiguracoes: false,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
              child: Text(
            traducao.configuracoes,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
          )),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage())
              );
            },
            tileColor: const Color.fromARGB(255, 255, 251, 183),
            title: Text(
              traducao.alterarLingua,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
                'Atual: Português'),
          )
        ],
      ),
    );
  }
}
