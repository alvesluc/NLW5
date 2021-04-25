import 'package:devquiz/core/core.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final int score;

  const ChartWidget({Key? key, required this.score}) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void _initAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.score.toDouble(),
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  value: _animation.value / 100,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
                  backgroundColor: AppColors.chartSecondary,
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value).toStringAsPrecision(2)}%",
                style: AppTextStyles.heading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
