// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:triolingo/database/dao/palavradao.dart';

import 'package:triolingo/database/dao/preferenciadao.dart';
import 'package:triolingo/database/dao/traducaodao.dart';
import 'package:triolingo/model/palavra.dart';
import 'package:triolingo/model/traducao.dart';
import 'package:video_player/video_player.dart';

late Traducao traducao;
late String lingua;

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  if ((await buscarLingua()).isNotEmpty) {
    traducao = Traducao.fromMap((await buscarTraducao(
            (await buscarLingua()).first.values.first.toString()))
        .first);
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
        (await buscarLingua()).isEmpty ? const HomePage() : const Preferencia(),
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
                    traducao = Traducao.fromMap(
                        (await buscarTraducao('portugues')).first);
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
                    traducao = Traducao.fromMap(
                        (await buscarTraducao('ingles')).first);
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
                    traducao =
                        Traducao.fromMap((await buscarTraducao('latim')).first);
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

class Preferencia extends StatefulWidget {
  const Preferencia({super.key});

  @override
  State<Preferencia> createState() => _PreferenciaState();
}

class _PreferenciaState extends State<Preferencia> {
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/img/fuinha.mp4');

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _controller.play();
              
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
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
                    lingua = 'portugues';
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
                    lingua = 'ingles';
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
                    lingua = 'latim';
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

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage({
              'portugues': 'assets/img/brasil-bandeira.jpg',
              'ingles': 'assets/img/eua-bandeira.jpg',
              'latim': 'assets/img/sacro-imperio-romano-bandeira.jpg'
            }[lingua]!),
          ),
          Text(
            {
              'portugues': 'Português',
              'ingles': 'Inglês',
              'latim': 'Latim'
            }[lingua]!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Conhecidas())).then(
                    (value) {
                      setState(() {});
                    },
                  );
                  ;
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: contarConhecidas(lingua),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return const Center(
                                        child: Text(
                                            'Não foi possível ler os cadastros da base de dados.'),
                                      );
                                    case ConnectionState.waiting:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    case ConnectionState.active:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    case ConnectionState.done:
                                      return Column(
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: PieChart(
                                                  PieChartData(sections: [
                                                PieChartSectionData(
                                                    value: (snapshot.data! *
                                                        100 /
                                                        66),
                                                    radius: 25,
                                                    title:
                                                        '${snapshot.data! * 100 ~/ 66}%',
                                                    titleStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    color: const Color.fromARGB(
                                                        255, 79, 29, 58)),
                                                PieChartSectionData(
                                                    value:
                                                        ((66 - snapshot.data!) *
                                                                100 /
                                                                66)
                                                            .ceilToDouble(),
                                                    radius: 25,
                                                    titleStyle: const TextStyle(
                                                        fontSize: 0),
                                                    color: Colors.white)
                                              ]))),
                                          Text(
                                            traducao.conhecoPalavras.replaceAll(
                                                'x', snapshot.data!.toString()),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ParaRevisar())).then(
                    (value) {
                      setState(() {});
                    },
                  );
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: contarDesconhecidas(lingua),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return const Center(
                                        child: Text(
                                            'Não foi possível ler os cadastros da base de dados.'),
                                      );
                                    case ConnectionState.waiting:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    case ConnectionState.active:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    case ConnectionState.done:
                                      return Text(
                                        snapshot.data!.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 55,
                                            fontWeight: FontWeight.w700),
                                      );
                                  }
                                }),
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
          FutureBuilder(
            future: sortearPalavra(lingua),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text(
                        'Não foi possível ler os cadastros da base de dados.'),
                  );
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    return Center(
                        child: SizedBox(
                      child: Icon(
                        Icons.workspace_premium,
                        size: 100,
                        shadows: [
                          Shadow(
                              color: Color.fromARGB(128, 168, 168, 168),
                              blurRadius: 8,
                              offset: Offset(4, 4))
                        ],
                        color: Color.fromARGB(255, 79, 29, 58),
                      ),
                    ));
                  }

                  Palavra palavra = Palavra.fromMap(snapshot.data!.cast());
                  return Container(
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
                            Text(
                              {
                                'portugues': palavra.grafiaPortugues,
                                'ingles': palavra.grafiaIngles,
                                'latim': palavra.grafiaLatim
                              }[lingua]!,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            SizedBox(
                                width: 300,
                                child: FutureBuilder(
                                    future: buscarLingua(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return const Center(
                                            child: Text(
                                                'Não foi possível ler os cadastros da base de dados.'),
                                          );
                                        case ConnectionState.waiting:
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case ConnectionState.active:
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case ConnectionState.done:
                                          return Text(
                                            {
                                              'portugues':
                                                  palavra.significadoPortugues,
                                              'ingles':
                                                  palavra.significadoIngles,
                                              'latim': palavra.significadoLatim
                                            }[snapshot.data!.first.values.first
                                                .toString()]!,
                                            textAlign: TextAlign.center,
                                          );
                                      }
                                    })),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: TextButton(
                                      onPressed: () async {
                                        cadastrarConhecida(
                                            palavra.idPalavra,
                                            (await buscarLingua())
                                                .first
                                                .values
                                                .first
                                                .toString(),
                                            lingua);
                                        setState(() {});
                                      },
                                      style: const ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              ContinuousRectangleBorder()),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 79, 29, 58))),
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
                                      onPressed: () async {
                                        cadastrarDesconhecida(
                                            palavra.idPalavra,
                                            (await buscarLingua())
                                                .first
                                                .values
                                                .first
                                                .toString(),
                                            lingua);
                                        setState(() {});
                                      },
                                      style: const ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              ContinuousRectangleBorder()),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 79, 29, 58))),
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
                  );
              }
            },
          )
        ],
      ),
    ));
  }
}

class Conhecidas extends StatefulWidget {
  const Conhecidas({super.key});

  @override
  State<Conhecidas> createState() => _ConhecidasState();
}

class _ConhecidasState extends State<Conhecidas> {
  PageStorageKey _key = PageStorageKey('conhecidas');
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
      temConfiguracoes: true,
      body: FutureBuilder(
        future: buscarLingua(),
        builder: (context, snapshotLingua) {
          switch (snapshotLingua.connectionState) {
            case ConnectionState.none:
              return const Center(
                child:
                    Text('Não foi possível ler os cadastros da base de dados.'),
              );
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return FutureBuilder(
                future: buscarConhecidas(lingua),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text(
                            'Não foi possível ler os cadastros da base de dados.'),
                      );
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        key: _key,
                        controller: _controller,
                        itemCount: snapshot.data!.isEmpty
                            ? 2
                            : snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Center(
                                child: Text(
                              traducao.palavrasConhecidas,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 36),
                            ));
                          }

                          if (snapshot.data!.isEmpty) {
                            return Center(
                                child: Text(traducao.vazioConhecidas));
                          }

                          Palavra palavra = Palavra.fromMap(
                              snapshot.data!.elementAt(index - 1));

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              child: Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  excluirConhecida(palavra.idPalavra, lingua);
                                  setState(() {});
                                },
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Stack(
                                      children: [
                                        Container(
                                          color: Color.fromARGB(
                                              255, 255, 251, 183),
                                          width: double.infinity,
                                          height: 75,
                                        ),
                                        ListTile(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                              constraintsModal) =>
                                                          SizedBox(
                                                        width: constraintsModal
                                                                .maxWidth *
                                                            0.9,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              {
                                                                'portugues': palavra
                                                                    .grafiaPortugues,
                                                                'ingles': palavra
                                                                    .grafiaIngles,
                                                                'latim': palavra
                                                                    .grafiaLatim
                                                              }[lingua]!,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 24,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 16.0,
                                                            ),
                                                            Text(
                                                              {
                                                                'portugues': palavra
                                                                    .significadoPortugues,
                                                                'ingles': palavra
                                                                    .significadoIngles,
                                                                'latim': palavra
                                                                    .significadoLatim
                                                              }[snapshotLingua
                                                                      .data!.first
                                                                      .cast()[
                                                                  'lingua']]!,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          20),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          title: Text(
                                            {
                                              'portugues':
                                                  palavra.grafiaPortugues,
                                              'ingles': palavra.grafiaIngles,
                                              'latim': palavra.grafiaLatim
                                            }[lingua]!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                            {
                                              'portugues':
                                                  palavra.significadoPortugues,
                                              'ingles':
                                                  palavra.significadoIngles,
                                              'latim': palavra.significadoLatim
                                            }[snapshotLingua.data!.first
                                                .cast()['lingua']]!,
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              );
          }
        },
      ),
    );
  }
}

class ParaRevisar extends StatefulWidget {
  const ParaRevisar({super.key});

  @override
  State<ParaRevisar> createState() => _ParaRevisarState();
}

class _ParaRevisarState extends State<ParaRevisar> {
  PageStorageKey _key = PageStorageKey('pararevisar');
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
        temConfiguracoes: true,
        body: FutureBuilder(
          future: buscarLingua(),
          builder: (context, snapshotLingua) {
            switch (snapshotLingua.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text(
                      'Não foi possível ler os cadastros da base de dados.'),
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return FutureBuilder(
                  future: buscarDesconhecidas(lingua),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Center(
                          child: Text(
                              'Não foi possível ler os cadastros da base de dados.'),
                        );
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        return ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            key: _key,
                            controller: _controller,
                            itemCount: snapshot.data!.isEmpty
                                ? 2
                                : snapshot.data!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Center(
                                    child: Text(
                                  traducao.paraRevisar,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 36),
                                ));
                              }

                              if (snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text(traducao.vazioRevisar));
                              }

                              Palavra palavra = Palavra.fromMap(
                                  snapshot.data!.elementAt(index - 1));

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: LayoutBuilder(
                                              builder: (context, constraints) =>
                                                  SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.9,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      {
                                                        'portugues': palavra
                                                            .grafiaPortugues,
                                                        'ingles': palavra
                                                            .grafiaIngles,
                                                        'latim':
                                                            palavra.grafiaLatim
                                                      }[lingua]!,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16.0,
                                                    ),
                                                    Text(
                                                      {
                                                        'portugues': palavra
                                                            .significadoPortugues,
                                                        'ingles': palavra
                                                            .significadoIngles,
                                                        'latim': palavra
                                                            .significadoLatim
                                                      }[snapshotLingua
                                                          .data!.first
                                                          .cast()['lingua']]!,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  tileColor:
                                      const Color.fromARGB(255, 255, 251, 183),
                                  title: Text(
                                    {
                                      'portugues': palavra.grafiaPortugues,
                                      'ingles': palavra.grafiaIngles,
                                      'latim': palavra.grafiaLatim
                                    }[lingua]!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    {
                                      'portugues': palavra.significadoPortugues,
                                      'ingles': palavra.significadoIngles,
                                      'latim': palavra.significadoLatim
                                    }[snapshotLingua.data!.first
                                        .cast()['lingua']]!,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        checarDesconhecida(
                                            palavra.idPalavra, lingua);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                      )),
                                ),
                              );
                            });
                    }
                  },
                );
            }
          },
        ));
  }
}

class Configuracoes extends StatelessWidget {
  const Configuracoes({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPadrao(
        temConfiguracoes: false,
        body: FutureBuilder(
            future: buscarLingua(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text(
                        'Não foi possível ler os cadastros da base de dados.'),
                  );
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      Center(
                          child: Text(
                        traducao.configuracoes,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 36),
                      )),
                      const SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        tileColor: const Color.fromARGB(255, 255, 251, 183),
                        title: Text(
                          traducao.alterarLingua,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text('${traducao.linguaAtual}: ${{
                          'portugues': traducao.portugues,
                          'ingles': traducao.ingles,
                          'latim': traducao.latim
                        }[snapshot.data!.first.cast()['lingua']]}.'),
                      )
                    ],
                  );
              }
            }));
  }
}
