import 'dart:async';
import 'package:flutter/material.dart';
import '../simple_animation_progress_bar_platform_interface.dart';

class SimpleAnimationProgressBar extends StatefulWidget {
  Future<String?> getPlatformVersion() {
    return SimpleAnimationProgressBarPlatform.instance.getPlatformVersion();
  }

  const SimpleAnimationProgressBar(
      {super.key,
      required this.currentStep,
      required this.totalStep,
      required this.width,
      required this.height,
      this.borderRadius,
      this.border,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.duration,
      required this.curve,
      this.reverseAlignment,
      this.waitDelay,
      this.gradientColor,
      this.boxShadow,
      this.dividerWidth = 1,
      this.dividerColor = Colors.black,
      required this.glowColor});
  final int currentStep;
  final int totalStep;
  final double width; //Sets progress bar width
  final double height; //Sets progress bar height

  final BorderRadius? borderRadius; //Gives border radius for progress bar
  final Border? border; //Gives border radius for progress bar
  final Color backgroundColor; //Sets the background of the progress bar
  final Color glowColor; //Sets the background of the progress bar
  final Color foregroundColor; //Sets the foreground of the progress bar
  final Duration duration; //Sets the animation speed in the progress bar
  final Curve curve; //Sets the animation type
  final bool?
      reverseAlignment; //Reverses the bar alignment, such as left-to-right or right-to-left
  final Duration? waitDelay; //Sets you to delay the start of animation
  final Gradient? gradientColor; //Sets gardient color in progress bar
  final List<BoxShadow>? boxShadow; //Sets shadow in progress bar

  final Color dividerColor;
  final double dividerWidth;
  @override
  State<SimpleAnimationProgressBar> createState() =>
      _SimpleAnimationProgressBarState();
}

class _SimpleAnimationProgressBarState
    extends State<SimpleAnimationProgressBar> {
  ValueNotifier<double> ratio = ValueNotifier(
      0); //Since the ratio value can change again with the new value, it is defined as ValueNotifier.

  @override
  void initState() {
    super.initState();
    if (ratio.value == 0) {
      /*
      Here, the animation is started by assigning a value to the ratio
      double variable at the beginning of the progress bar.
      */
      (widget.waitDelay != null)
          ? widget.waitDelay!
          : Timer(
              const Duration(),
              () {
                /*
                Duration() command is used to transfer the value later and
                display it as animated by the animated container.
                */
                ratio.value = widget.currentStep / widget.totalStep;
              },
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressRatio = widget.currentStep / widget.totalStep;
    print(
        'logger ||${widget.totalStep} || ${widget.currentStep} || progressRatio $progressRatio');
    if (ratio.value != progressRatio) {
      /*
      Here, a condition is created for the values ​​that may come after the ratio value is defined.
      This condition sets the new incoming value equal to the ratio value.
      */
      Future.delayed(
          (widget.waitDelay != null) ? widget.waitDelay! : const Duration(),
          () {
        /*
                Duration() command is used to transfer the value later and
                display it as animated by the animated container.
                */
        ratio.value = progressRatio;
      });
    }
    return ValueListenableBuilder(
        //With ValueListener, the changed value is controlled and the new value is transferred to the widgets again.
        valueListenable: ratio,
        builder: (BuildContext context, double ratioValue, Widget? child) {
          return Container(
              //The container here creates the background of the progress bar, then returns the widget to be created with the direction variable.
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                border: widget.border,
                borderRadius: widget.borderRadius,
              ),
              child: _HorizontalBar(widget: widget));
        });
  }
}

class _HorizontalBar extends StatelessWidget {
  const _HorizontalBar({
    required this.widget,
  });

  final SimpleAnimationProgressBar widget;

  @override
  Widget build(BuildContext context) {
    final ratio = widget.currentStep / widget.totalStep;
    final width = ((ratio >= 1 ? 1 : ratio) * widget.width) / 1;
    return Align(
      //The Align widget is used for the direction of the AnimatedContainer. It reverses the direction of the progress bar according to the incoming direction.
      alignment: (widget.reverseAlignment == true)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Stack(
        children: [
          AnimatedContainer(
            //Animated Container Widget is used for animation.
            duration: widget.duration,
            curve: widget.curve,
            alignment: Alignment.centerLeft,
            height: widget.height,
            width: width,
            decoration: BoxDecoration(
              gradient:
                  (widget.gradientColor != null) ? widget.gradientColor : null,
              color: (widget.gradientColor != null)
                  ? null
                  : widget.foregroundColor,
              borderRadius: widget.borderRadius,
              boxShadow: (widget.boxShadow != null) ? widget.boxShadow : null,
            ),
          ),
          AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            width: width,
            height: widget.height,
            decoration: const BoxDecoration(color: Colors.transparent),
            padding: EdgeInsets.fromLTRB(
              widget.width / 20,
              widget.height / 6,
              widget.width / 20,
              widget.height / 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.glowColor,
                borderRadius: widget.borderRadius,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(widget.totalStep - 1, (index) {
              return Container(
                height: widget.height,
                width: widget.dividerWidth,
                color: widget.dividerColor,
              );
            }),
          ),
        ],
      ),
    );
  }
}
