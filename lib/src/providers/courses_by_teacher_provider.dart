import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class CoursesByTeacherProvider extends GetConnect {
  final AuthProvider authService = AuthProvider();
  var allCourses = <Map<String, dynamic>>[].obs;
  var sessions = <Map<String, dynamic>>[].obs;
  var assistance = <Map<String, dynamic>>[].obs;
  var competences = <Map<String, dynamic>>[].obs;
  var rapsBySubject = <Map<String, dynamic>>[].obs;
  var rapsSession = <Map<String, dynamic>>[].obs;
  Future<void> getAllCourses() async {
    String token = await authService.getToken();
    Response response = await get(
      getCoursesByTeacherUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      allCourses.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      allCourses.assignAll([]);
    }
  }

  Future<Map<String, dynamic>> getCourseById(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getCourseByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {};
    }
  }

  Future<void> getSessions(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getSessionByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      sessions.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      sessions.assignAll([]);
    }
  }

  Future<void> getAssistance(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getAssistanceByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      assistance.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      assistance.assignAll([]);
    }
  }

  Future<void> getCompetences(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getCompetencesByIdUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      competences.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      competences.assignAll([]);
    }
  }

  Future<void> getRapsBySubject(
      String idCurse, String idSubject, String idProgram) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getCompetencesRapUrl$idCurse/materia/$idSubject/$idProgram',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      rapsBySubject.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      rapsBySubject.assignAll([]);
    }
  }

  Future<void> getSessionRaps(String id) async {
    String token = await authService.getToken();
    Response response = await get(
      '$getSessionRapsUrl$id',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      rapsSession.assignAll(response.body.cast<Map<String, dynamic>>());
    } else {
      rapsSession.assignAll([]);
    }
  }
}
