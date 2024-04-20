import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/widgets/card_chats.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';

class Chats extends StatelessWidget {
  Chats({super.key});
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> tasks = [
  {
    'id': '1',
    'urlPhotoSender':
        'https://phantom-marca.unidadeditorial.es/c56848cfee85df94876073904cfdd799/resize/660/f/webp/assets/multimedia/imagenes/2022/07/30/16591778851898.jpg',
    'nameOfsender': 'Cristiano Ronaldo',
    'endMessage': 'Hola'
  },
  {
    'id': '2',
    'urlPhotoSender':
        'https://lavibrante.com/wp-content/uploads/2024/01/Messi-1-822x526.jpg',
    'nameOfsender': 'Lionel Messi',
    'endMessage': 'Hola'
  },
  {
    'id': '3',
    'urlPhotoSender':
        'https://estaticos-cdn.prensaiberica.es/clip/c9534f85-2e84-428c-802f-acca219d508c_16-9-discover-aspect-ratio_default_0.webp',
    'nameOfsender': 'Neymar Jr',
    'endMessage': 'Hola'
  },
  {
    'id': '4',
    'urlPhotoSender':
        'https://images.ecestaticos.com/P9ovQ7si4TazPafV8B9-gWdhJms=/0x0:2272x1515/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2F00f%2Fac8%2F7de%2F00fac87de6b58efa81f8f57419f010c7.jpg',
    'nameOfsender': 'Sergio Ramos',
    'endMessage': 'Hola'
  },
  {
    'id': '5',
    'urlPhotoSender':
        'https://assets-es.imgfoot.com/media/cache/1200x675/kevin-de-bruyne-2324-659ad0d84a033.jpg',
    'nameOfsender': 'Kevin De Bruyne',
    'endMessage': 'Hola'
  },
  {
    'id': '6',
    'urlPhotoSender':
        'https://cadenaser.com/resizer/C-J91fUFyAB4malv82WNxfWrRNI=/768x576/filters:format(jpg):quality(70)/cloudfront-eu-central-1.images.arcpublishing.com/prisaradio/P4NRNBKXQJBGFA64SPM772RN7E.jpg',
    'nameOfsender': 'Robert Lewandowski',
    'endMessage': 'Hola'
  },
 {
    'id': '7',
    'urlPhotoSender':
        'https://images.daznservices.com/di/library/DAZN_News/38/f7/casemiro-real-madrid-liga-20220819_b7bk98dkrjbt105emmrlvtgb2.jpg?t=-1275723422&w=800',
    'nameOfsender': 'Carlos Casemiro',
    'endMessage': 'Hola'
  },
  {
    'id': '8',
    'urlPhotoSender':
        'https://assets.goal.com/images/v3/blt50ba2ab2d0b0c5a3/GettyImages-1416521766.jpg?auto=webp&format=pjpg&width=640&quality=60',
    'nameOfsender': 'Eden Hazard',
    'endMessage': 'Hola'
  },
  {
    'id': '9',
    'urlPhotoSender':
        'https://www.semana.com/resizer/aIZGAPDtPvPrMqf9CATHglS2RVQ=/1280x720/smart/filters:format(jpg):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/semana/EX2EW5ON3NCLTCLA6YGJXBQZSE.jpg',
    'nameOfsender': 'James Rodriguez',
    'endMessage': 'Hola'
  },
  {
    'id': '10',
    'urlPhotoSender':
        'https://static.independent.co.uk/2023/07/21/13/newFile-1.jpg?quality=75&width=1250&crop=3%3A2%2Csmart&auto=webp',
    'nameOfsender': 'Jordan Henderson',
    'endMessage': 'Hola'
  },
  {
    'id': '11',
    'urlPhotoSender':
        'https://www.mundodeportivo.com/us/files/image_948_465/uploads/2023/11/17/6557fd63d73b4.jpeg',
    'nameOfsender': 'Son Heung-min',
    'endMessage': 'Hola'
  },
  {
    'id': '12',
    'urlPhotoSender':
        'https://madridistareal.com/wp-content/uploads/2023/11/fbl-eur-c1-realmadrid-psg-e1614274093105.jpg',
    'nameOfsender': 'Marcelo Viera',
    'endMessage': 'Hola'
  },
  {
    'id': '13',
    'urlPhotoSender':
        'https://assets-es.imgfoot.com/media/cache/1200x675/luka-modric-2324-65e1c107d7591.jpg',
    'nameOfsender': 'Luka Modrić',
    'endMessage': 'Hola'
  },
  {
    'id': '14',
    'urlPhotoSender':
        'https://media.c5n.com/p/a2be2b70e6c5cf1fcc39e5954b672201/adjuntos/326/imagenes/000/199/0000199028/790x0/smart/angel-di-maria.jpg',
    'nameOfsender': 'Ángel Di María',
    'endMessage': 'Hola'
  },
  {
    'id': '15',
    'urlPhotoSender':
        'https://masfichajes.com/wp-content/uploads/2024/03/radamel-falcao-scaled-e1709739002730.webp',
    'nameOfsender': 'Radamel Falcao',
    'endMessage': 'Hola'
  },
  {
    'id': '16',
    'urlPhotoSender':
        'https://periodismo.ull.es/wp-content/uploads/2022/08/Mbappe1.jpg',
    'nameOfsender': 'Kylian Mbappé',
    'endMessage': 'Hola'
  },
  {
    'id': '17',
    'urlPhotoSender':
        'https://phantom-elmundo.unidadeditorial.es/16b0bdae192d643d0401fca984d59bc5/resize/473/f/webp/assets/multimedia/imagenes/2023/04/18/16818341854738.jpg',
    'nameOfsender': 'Sadio Mané',
    'endMessage': 'Hola'
  },
  {
    'id': '18',
    'urlPhotoSender':
        'https://imgresizer.eurosport.com/unsafe/120x0/filters:format(webp)/origin-imgresizer.eurosport.com/2023/11/25/3831690-77866728-2560-1440.jpg',
    'nameOfsender': 'Trent Alexander-Arnold',
    'endMessage': 'Hola'
  },
  {
    'id': '19',
    'urlPhotoSender':
        'https://img.vavel.com/foden-1707173407109.jpeg',
    'nameOfsender': 'Phil Foden',
    'endMessage': 'Hola'
  },
  {
    'id': '20',
    'urlPhotoSender':
        'https://media.revistavanityfair.es/photos/60e84a7f29af8ce08356d971/master/w_1600,c_limit/45191.jpg',
    'nameOfsender': 'Iker Casillas',
    'endMessage': 'Hola'
  },

];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 80),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              listColor[14],
              listColor[11],
            ],
          ),
        ),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            'Chats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: listColor[10],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 18.0, right: 18.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                //_taskStudentController.filterActivities(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: listColor[11],
                hintText: "Buscar",
                hintStyle: TextStyle(color: listColor[14]),
                prefixIcon: Icon(
                  Icons.search,
                  color: _searchController.text.isNotEmpty
                      ? Colors.white
                      : listColor[14],
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: listColor[14],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _searchController.text.isNotEmpty
                        ? Colors.white
                        : listColor[14],
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0),
              ),
              style: TextStyle(
                color: listColor[10],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/chat');
                  },
                  onLongPress: () {
                    showOptionsModal();
                  },
                  child: CardChats(
                    idActivity: task['id']!,
                    urlPhotoSender: task['urlPhotoSender']!,
                    name: task['nameOfsender']!,
                    endMessage: task['endMessage']!,
                  ),
                );
              },
            ),
          ),
        ]));
  }

  void showOptionsModal() {
    Get.bottomSheet(
      optionsModal(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  Widget optionsModal() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            listColor[11],
            listColor[11],
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ContSup(),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(
                left: 18,
              ),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Archivar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18, top: 30, bottom: 30),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18, bottom: 30),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Center(
                    child: Text(
                      'Marcar como leido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/comentario.png'),
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Abrir chat',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
