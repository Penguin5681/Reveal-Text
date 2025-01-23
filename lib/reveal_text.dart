/// A library for revealing text with animations.
library reveal_text;

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Enum to define the type of animation.
enum AnimationType { words, letters }

/// A widget that reveals text with animation.
class RevealText extends StatefulWidget {
  final String text;
  final AnimationType animateBy;
  final Duration delay;
  final Curve curve;
  final TextStyle textStyle;
  final double verticalOffset;
  final double opacityStart;
  final TextAlign textAlign;
  final double? letterSpacing;

  /// Creates a [RevealText] widget.
  ///
  /// * [text]: The text to be revealed.
  /// * [animateBy]: The type of animation (words or letters).
  /// * [delay]: The delay between each animation.
  /// * [curve]: The animation curve.
  /// * [textStyle]: The style of the text.
  /// * [verticalOffset]: The vertical offset for the animation.
  /// * [opacityStart]: The starting opacity of the text.
  /// * [textAlign]: The alignment of the text.
  /// * [letterSpacing]: The spacing between letters.
  const RevealText({
    super.key,
    required this.text,
    this.animateBy = AnimationType.words,
    this.delay = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutQuart,
    this.textStyle = const TextStyle(fontSize: 24, color: Colors.black),
    this.verticalOffset = 8.0,
    this.opacityStart = 0.0,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
  });

  @override
  State<RevealText> createState() => _RevealTextState();
}

class _RevealTextState extends State<RevealText> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<String> _textElements;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _textElements = _splitText();
    _controllers = List.generate(
      _textElements.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  /// Splits the text into words or letters based on the animation type.
  List<String> _splitText() {
    if (widget.animateBy == AnimationType.words) {
      return widget.text.split(' ').where((w) => w.isNotEmpty).toList();
    }
    return widget.text.split('');
  }

  /// Starts the animations for the text elements.
  void _startAnimations() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(widget.delay * i, () {
          if (mounted) _controllers[i].forward();
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal-text-${widget.text.hashCode}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.8) _startAnimations();
      },
      child: _buildTextContent(),
    );
  }

  /// Builds the content of the text with animations.
  Widget _buildTextContent() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(_textElements.length, (index) {
        return _AnimatedTextElement(
          text: _textElements[index],
          controller: _controllers[index],
          curve: widget.curve,
          style: widget.textStyle,
          verticalOffset: widget.verticalOffset,
          opacityStart: widget.opacityStart,
          letterSpacing: widget.letterSpacing,
        );
      }),
    );
  }
}

class _AnimatedTextElement extends StatelessWidget {
  final String text;
  final AnimationController controller;
  final Curve curve;
  final TextStyle style;
  final double verticalOffset;
  final double opacityStart;
  final double? letterSpacing;

  /// Creates an animated text element.
  ///
  /// * [text]: The text to be animated.
  /// * [controller]: The animation controller.
  /// * [curve]: The animation curve.
  /// * [style]: The style of the text.
  /// * [verticalOffset]: The vertical offset for the animation.
  /// * [opacityStart]: The starting opacity of the text.
  /// * [letterSpacing]: The spacing between letters.
  const _AnimatedTextElement({
    required this.text,
    required this.controller,
    required this.curve,
    required this.style,
    required this.verticalOffset,
    required this.opacityStart,
    required this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(parent: controller, curve: curve);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: opacityStart + (1 - opacityStart) * animation.value,
          child: Transform.translate(
            offset: Offset(0, verticalOffset * (1 - animation.value)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 2),
              child: Text(
                text,
                style: style.copyWith(letterSpacing: letterSpacing),
                textScaler: TextScaler.linear(1 + (0.05 * animation.value)),
              ),
            ),
          ),
        );
      },
    );
  }
}
