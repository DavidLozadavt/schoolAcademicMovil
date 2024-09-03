import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class CalendarProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
  var events = <Map<String, dynamic>>[].obs;

  Future<void> fetchEventsStudent(String? id) async {
    String token = await authService.getToken();

   /* Map<String, dynamic> requestData = {
      'idPrograma': 3,
      'relations': [
        'infraestructura.sede',
        'dia',
        'materia.materia',
        'materia.grado.programa',
        'periodo'
      ]
    };*/
   
    //Uri uri = Uri.parse(horarioMateriaURL);

    /*Uri requestUri = uri
        .replace(queryParameters: {'data_encoded': json.encode(requestData)});*/

    Response response = await get(
      '$getDiaryStudentUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        events.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }

  Future<void> fetchEventsTeacher(String? id) async {
    String token = await authService.getToken();

    /*Map<String, dynamic> requestData = {
      'idPrograma': 3,
      'relations': [
        'infraestructura.sede',
        'dia',
        'materia.materia',
        'materia.grado.programa',
        'periodo'
      ]
    };
   
    Uri uri = Uri.parse(horarioMateriaURL);

    Uri requestUri = uri
        .replace(queryParameters: {'data_encoded': json.encode(requestData)});
 print(requestUri);*/
    Response response = await get(
      '$getDiaryTeacherUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('2025 ${response.body}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        events.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }
}
