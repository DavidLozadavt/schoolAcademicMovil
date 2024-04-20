import 'package:flutter/material.dart';

class CardQuestions extends StatefulWidget {
  final String question;
  final List<String>? options;
  final Function(int)? onChanged;
  final String idTypeQuestion;

  const CardQuestions({
    Key? key,
    required this.question,
    this.options,
    this.onChanged,
    required this.idTypeQuestion,
  }) : super(key: key);

  @override
  _CardQuestionsState createState() => _CardQuestionsState();
}

class _CardQuestionsState extends State<CardQuestions> {
  int? _selectedOption;
  final List<int> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    if (widget.idTypeQuestion == "3") {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.options!.length,
                (index) => RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xff00C535);
                      }
                      return Colors.white;
                    },
                  ),
                  title: Text(
                    widget.options![index],
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: index,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                    widget.onChanged!(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if(widget.idTypeQuestion == "8"){
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.options!.length,
                (index) => CheckboxListTile(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xff00C535);
                      }
                      return Colors.white;
                    },
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    widget.options![index],
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: _selectedOptions.contains(index),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedOptions.add(index);
                      } else {
                        _selectedOptions.remove(index);
                      }
                    });
                  
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      return const SizedBox();
    }
  }
}
