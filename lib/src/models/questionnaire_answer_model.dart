class QuestionnaireAnswer {
  final int idPregunta;
  final String respuestaId;
  final String respuestas;

  QuestionnaireAnswer({
    required this.idPregunta,
    required this.respuestaId,
    required this.respuestas,
  });

 @override
  String toString() {
    return '{"idPregunta": $idPregunta, "respuesta": "$respuestaId", "respuestas": "$respuestas"}';
  }
}