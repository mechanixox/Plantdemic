import 'package:plantdemic/textfield_utility/custom_animate_border.dart';
import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final Widget? suffix;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  const AnimatedTextField({
    Key? key,
    required this.label,
    required this.suffix,
    required this.controller,
    required this.keyboardType,
    required this.inputAction,
  }) : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    controller?.addListener(() {
      setState(() {});
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.black,
              ),
        ),
        child: CustomPaint(
          painter: CustomAnimateBorder(alpha.value),
          child: TextField(
            focusNode: focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.inputAction,
            decoration: InputDecoration(
              labelText: widget.label,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              suffixIcon: widget.suffix,
            ),
          ),
        ),
      ),
    );
  }
}
