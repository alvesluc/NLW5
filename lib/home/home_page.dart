import 'package:devquiz/challenge/challenge_page.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/home/home_state.dart';

import 'home_controller.dart';
import 'widgets/app_bar/app_bar_widget.dart';
import 'widgets/level_button/level_button_widget.dart';
import 'widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.getUser();
    _controller.getQuizzes();
    _controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.state == HomeState.success) {
      return Scaffold(
          appBar: AppBarWidget(
            user: _controller.user!,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LevelButtonWidget(
                      label: 'Fácil',
                    ),
                    LevelButtonWidget(
                      label: 'Médio',
                    ),
                    LevelButtonWidget(
                      label: 'Difícil',
                    ),
                    LevelButtonWidget(
                      label: 'Perito',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                    children: _controller.quizzes!
                        .map(
                          (quiz) => QuizCardWidget(
                            title: quiz.title,
                            completed:
                                "${quiz.questionsAnswered}/${quiz.questions.length}",
                            percent:
                                quiz.questionsAnswered / quiz.questions.length,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChallengePage(
                                    questions: quiz.questions,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
