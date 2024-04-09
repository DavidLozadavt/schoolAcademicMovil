const baseURL = 'http://192.168.1.101:8000/api/';
//const baseURL = 'https://pre-school-plataform.virtualt.org/api/';

const loginURL = '${baseURL}auth/login';

const getHorarioMateriaURL = '${baseURL}materias/horario_materia';
const getDiaryTeacherUrl = '${baseURL}get_matriculas_academicas_by_id_persona_docente/';
const getDiaryStudentUrl = '${baseURL}get_matriculas_academicas_by_id_persona/';
const getNotificationsAllUrl = '${baseURL}notificacionesAll';
const putReadNotificationsUrl = '${baseURL}notificacion/read/';
const replyActivityUrl = '${baseURL}responder_actividad/';

const getTypeActivityUrl = '${baseURL}tipo_actividades?idActividad=';
const getActivityByIdUrl = '${baseURL}actividadesByid?id=';
const getActivityQuestionnaireUrl = '${baseURL}cuestionario/actividad_cuestionario/';
const postReplyActivityUrl = '${baseURL}responder_actividad/';

const logoutUrl = '${baseURL}auth/logout';
const urlUpdateProfile = '${baseURL}auth/update_profile';
const urlCiudad = '${baseURL}ciudades';

// ----- Errors -----
const serverError = 'Eror en la respuesta';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
