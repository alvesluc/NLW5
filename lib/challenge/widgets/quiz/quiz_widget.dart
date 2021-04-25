import 'package:devquiz/challenge/widgets/answer/answer_widget.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/shared/models/answers_model.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelectedAnswer;

  const QuizWidget({
    Key? key,
    required this.question,
    required this.onSelectedAnswer,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedIndex = -1;

  AnswerModel answer(int index) => widget.question.answers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question.title,
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 24),
            for (var i = 0; i < widget.question.answers.length; i++)
              AnswerWidget(
                answer: answer(i),
                disabled: selectedIndex != -1,
                isSelected: selectedIndex == i,
                onTap: (value) {
                  selectedIndex = i;
                  setState(() {});
                  widget.onSelectedAnswer(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}
