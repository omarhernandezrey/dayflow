import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

/// Reusable confetti widget that plays a celebration animation.
/// Place it at the top of the screen (Stack) and call play() when needed.
class DFConfetti extends StatefulWidget {
  const DFConfetti({super.key, this.child, this.onComplete});
  final Widget? child;
  final VoidCallback? onComplete;

  @override
  State<DFConfetti> createState() => DFConfettiState();
}

class DFConfettiState extends State<DFConfetti> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    _controller.addListener(_onStatusChanged);
  }

  void _onStatusChanged() {
    if (_controller.state == ConfettiControllerState.stopped &&
        widget.onComplete != null) {
      widget.onComplete!();
    }
  }

  void play() {
    if (mounted) _controller.play();
  }

  @override
  void dispose() {
    _controller.removeListener(_onStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        Color(0xFF3D7BFF),
        Color(0xFF22C55E),
        Color(0xFFF59E0B),
        Color(0xFFA78BFA),
        Color(0xFF38BDF8),
        Color(0xFFF472B6),
      ],
      createParticlePath: _drawStar,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }

  static Path _drawStar(Size size) {
    final path = Path();
    final r = size.width / 2;
    path.moveTo(r, 0);
    path.lineTo(r * 1.2, r * 0.6);
    path.lineTo(r * 2, r * 0.7);
    path.lineTo(r * 1.4, r * 1.1);
    path.lineTo(r * 1.6, r * 1.9);
    path.lineTo(r, r * 1.5);
    path.lineTo(r * 0.4, r * 1.9);
    path.lineTo(r * 0.6, r * 1.1);
    path.lineTo(0, r * 0.7);
    path.lineTo(r * 0.8, r * 0.6);
    path.close();
    return path;
  }
}
