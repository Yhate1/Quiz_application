import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/quiz.dart';
import 'package:flutter_application_2/pages/home.dart';

class Subject extends StatefulWidget {
  final String grade;

  const Subject({super.key, required this.grade});

  @override
  State<Subject> createState() => _SubjectState();
}

final Map<String, GradeSubjectConfig> gradeSubjectConfigs = {
  "Grade 1-2": GradeSubjectConfig(
    subjects: ["Numbers", "Literature", "Colors", "Shapes"],
    icons: {
      "Numbers": Icons.confirmation_number,
      "Literature": Icons.font_download,
      "Colors": Icons.palette,
      "Shapes": Icons.category,
    },
    gradient: [const Color(0xFF4ade80), const Color(0xFF10b981)],
  ),
  "Grade 3-4": GradeSubjectConfig(
    subjects: ["Math", "Science", "Reading", "Art"],
    icons: {
      "Math": Icons.calculate,
      "Science": Icons.science,
      "Reading": Icons.menu_book,
      "Art": Icons.brush,
    },
    gradient: [const Color(0xFF60a5fa), const Color(0xFF06b6d4)],
  ),
  "Grade 5-6": GradeSubjectConfig(
    subjects: ["Math", "Science", "History", "English"],
    icons: {
      "Math": Icons.calculate,
      "Science": Icons.science,
      "History": Icons.history,
      "English": Icons.translate,
    },
    gradient: [const Color(0xFFc084fc), const Color(0xFFec4899)],
  ),
  "Grade 7-8": GradeSubjectConfig(
    subjects: ["Algebra", "Biology", "Geography", "Literature"],
    icons: {
      "Algebra": Icons.functions,
      "Biology": Icons.eco,
      "Geography": Icons.public,
      "Literature": Icons.library_books,
    },
    gradient: [const Color(0xFFfb923c), const Color(0xFFef4444)],
  ),
  "Grade 9-10": GradeSubjectConfig(
    subjects: ["Physics", "Chemistry", "Geometry", "Coding"],
    icons: {
      "Physics": Icons.flash_on,
      "Chemistry": Icons.water_drop,
      "Geometry": Icons.pentagon,
      "Coding": Icons.code,
    },
    gradient: [const Color(0xFF818cf8), const Color(0xFF9333ea)],
  ),
  "Grade 11-12": GradeSubjectConfig(
    subjects: ["Calculus", "Economics", "Statistics", "SAT Prep"],
    icons: {
      "Calculus": Icons.integration_instructions,
      "Economics": Icons.account_balance,
      "Statistics": Icons.bar_chart,
      "SAT Prep": Icons.school,
    },
    gradient: [const Color(0xFFfacc15), const Color(0xFFf97316)],
  ),
};

class GradeSubjectConfig {
  final List<String> subjects;
  final Map<String, IconData> icons;
  final List<Color> gradient;

  GradeSubjectConfig({
    required this.subjects,
    required this.icons,
    required this.gradient,
  });
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF141830).withOpacity(0.9),
            const Color(0xFF141830).withOpacity(0.5),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}

class _SubjectState extends State<Subject> with SingleTickerProviderStateMixin {
  late List<String> _availableSubjects;
  late GradeSubjectConfig _config;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadSubjectsForGrade();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  void _loadSubjectsForGrade() {
    _config =
        gradeSubjectConfigs[widget.grade] ??
        GradeSubjectConfig(
          subjects: ["General Knowledge", "Logic", "Puzzles"],
          icons: {
            "General Knowledge": Icons.quiz,
            "Logic": Icons.psychology,
            "Puzzles": Icons.extension,
          },
          gradient: [const Color(0xFF667eea), const Color(0xFF764ba2)],
        );
    _availableSubjects = _config.subjects;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return WillPopScope(
      onWillPop: () async {
        _goToHome();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0E21),
        appBar: AppBar(
          title: Text("Subjects for ${widget.grade}"),
          centerTitle: true,
          backgroundColor: const Color(0xFF0A0E21),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(isSmallScreen ? 12 : 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isSmallScreen ? 12 : 16),
                GlassContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: _config.gradient),
                          boxShadow: [
                            BoxShadow(
                              color: _config.gradient[0].withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.grade,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${_availableSubjects.length} subjects available",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmallScreen ? 14 : 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _availableSubjects.length,
                  itemBuilder: (context, index) {
                    final subject = _availableSubjects[index];
                    final icon = _config.icons[subject] ?? Icons.book;

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 250 + (index * 60)),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: _buildSubjectCard(
                            subject,
                            icon,
                            _config.gradient,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(
    String subject,
    IconData icon,
    List<Color> gradient,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                Quiz(subject: subject, grade: widget.grade),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      onTapDown: (_) => HapticFeedback.selectionClick(),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradient[0].withOpacity(0.12),
                gradient[1].withOpacity(0.04),
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: gradient),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 10),
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              const Text(
                "Start →",
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
