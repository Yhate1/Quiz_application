import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter_application_2/pages/subjects.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? overlayColor;
  final double borderOpacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.overlayColor,
    this.borderOpacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (overlayColor ?? const Color(0xFF141830)).withOpacity(0.8),
            (overlayColor ?? const Color(0xFF141830)).withOpacity(0.4),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(borderOpacity),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}

class ProgressRing extends StatefulWidget {
  final double progress;
  final double size;
  final Color? color;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.color,
  });

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ProgressRingPainter(
              progress: _animation.value,
              color: widget.color ?? const Color(0xFF3b82f6),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_animation.value.toInt()}%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Score',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ProgressRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, bgPaint);
    
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = 2 * math.pi * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ✅ Lightweight Confetti for celebration
class ConfettiEffect extends StatefulWidget {
  final VoidCallback onComplete;

  const ConfettiEffect({super.key, required this.onComplete});

  @override
  State<ConfettiEffect> createState() => _ConfettiEffectState();
}

class _ConfettiEffectState extends State<ConfettiEffect>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final List<ConfettiParticle> _particles = [];
  final int particleCount = 15;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      particleCount,
      (index) => AnimationController(
        duration: Duration(milliseconds: 1500 + math.Random().nextInt(500)),
        vsync: this,
      ),
    );
    
    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    final colors = [
      const Color(0xFF4ade80),
      const Color(0xFF60a5fa),
      const Color(0xFFc084fc),
      const Color(0xFFfb923c),
      const Color(0xFFfacc15),
    ];

    for (int i = 0; i < particleCount; i++) {
      _particles.add(ConfettiParticle(
        color: colors[math.Random().nextInt(colors.length)],
        startX: 0.5 + (math.Random().nextDouble() - 0.5) * 0.5,
        endX: 0.5 + (math.Random().nextDouble() - 0.5) * 0.9,
        rotation: math.Random().nextDouble() * 2 * math.pi,
        size: 4 + math.Random().nextDouble() * 4,
        shape: math.Random().nextBool() ? BoxShape.circle : BoxShape.rectangle,
      ));
    }

    for (int i = 0; i < particleCount; i++) {
      Future.delayed(Duration(milliseconds: i * 40), () {
        if (mounted) _controllers[i].forward();
      });
    }

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: List.generate(particleCount, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              final animation = _animations[index];
              final particle = _particles[index];
              
              return Positioned(
                left: MediaQuery.of(context).size.width * 
                  (particle.startX + (particle.endX - particle.startX) * animation.value),
                top: -30 + animation.value * (MediaQuery.of(context).size.height + 60),
                child: Transform.rotate(
                  angle: particle.rotation * animation.value,
                  child: Opacity(
                    opacity: 1 - animation.value,
                    child: Container(
                      width: particle.size,
                      height: particle.size,
                      decoration: BoxDecoration(
                        color: particle.color,
                        shape: particle.shape,
                        borderRadius: particle.shape == BoxShape.rectangle
                            ? BorderRadius.circular(2)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class ConfettiParticle {
  final Color color;
  final double startX, endX, rotation, size;
  final BoxShape shape;

  ConfettiParticle({
    required this.color,
    required this.startX,
    required this.endX,
    required this.rotation,
    required this.size,
    required this.shape,
  });
}

// ==================== RESULT PAGE ====================

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String grade;
  final String subject;

  const ResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.grade,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = totalQuestions > 0 
        ? (score / totalQuestions) * 100 
        : 0;
    final bool isPassed = percent >= 50;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text("Quiz Result"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: isSmallScreen ? 20 : 40),
                
                // Result header
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    children: [
                      Text(
                        isPassed ? '🎉 Great Job!' : '💪 Keep Practicing!',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: isPassed ? const Color(0xFF22c55e) : const Color(0xFFfb923c),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$subject • $grade',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: isSmallScreen ? 24 : 32),
                
                // Progress ring + stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProgressRing(
                      progress: percent,
                      color: isPassed 
                          ? const Color(0xFF22c55e) 
                          : const Color(0xFFfb923c),
                      size: isSmallScreen ? 110 : 140,
                    ),
                    SizedBox(width: isSmallScreen ? 20 : 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatRow('Correct', '$score', const Color(0xFF22c55e)),
                        const SizedBox(height: 12),
                        _buildStatRow('Total', '$totalQuestions', Colors.white),
                        const SizedBox(height: 12),
                        _buildStatRow('Score', '${percent.toStringAsFixed(0)}%', 
                            percent >= 80 ? const Color(0xFF22c55e) : 
                            percent >= 50 ? const Color(0xFFfb923c) : const Color(0xFFef4444)),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: isSmallScreen ? 24 : 40),
                
                // Action buttons
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.refresh,
                        label: 'Retry Quiz',
                        color: const Color(0xFF3b82f6),
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        context,
                        icon: Icons.list,
                        label: 'Choose Subject',
                        color: const Color(0xFF8b5cf6),
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Subject(grade: grade),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        context,
                        icon: Icons.home,
                        label: 'Back to Home',
                        color: const Color(0xFF06b6d4),
                        onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: isSmallScreen ? 24 : 40),
                
                // Motivational message
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        isPassed ? Icons.emoji_events : Icons.lightbulb,
                        color: isPassed ? const Color(0xFFfacc15) : const Color(0xFF60a5fa),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isPassed 
                              ? 'You\'re on fire! Keep up the great work and aim for 100% next time! 🚀'
                              : 'Every expert was once a beginner. Review and try again – you\'ve got this! 💪',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: isSmallScreen ? 32 : 48),
              ],
            ),
          ),
          
          // Confetti celebration for passing
          if (isPassed)
            ConfettiEffect(
              onComplete: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}