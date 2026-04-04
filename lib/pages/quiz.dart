import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/result.dart';
import 'package:flutter_application_2/pages/home.dart';

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
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

final Map<String, Map<String, List<Question>>> quizData = {
  "Grade 1-2": {
    "Numbers": [
      Question(
        text: "What is 2 + 3?",
        options: ["4", "5", "6", "7"],
        correctAnswer: "5",
      ),
      Question(
        text: "What is 5 - 2?",
        options: ["2", "3", "4", "5"],
        correctAnswer: "3",
      ),
      Question(
        text: "What is 4 + 4?",
        options: ["6", "7", "8", "9"],
        correctAnswer: "8",
      ),
      Question(
        text: "What is 6 - 3?",
        options: ["2", "3", "4", "5"],
        correctAnswer: "3",
      ),
      Question(
        text: "What is 7 + 2?",
        options: ["8", "9", "10", "11"],
        correctAnswer: "9",
      ),
    ],
    "Literature": [
      Question(
        text: "Mark has a red ball. What color is the ball?",
        options: ["Blue", "Red", "Green", "Yellow"],
        correctAnswer: "Red",
      ),

      Question(
        text:
            "Sara has a cat. The cat says 'meow'. What animal does Sara have?",
        options: ["Dog", "Cat", "Cow", "Bird"],
        correctAnswer: "Cat",
      ),

      Question(
        text: "The sun is very hot. When do we see the sun?",
        options: ["At night", "In the morning", "In the day", "In the evening"],
        correctAnswer: "In the day",
      ),

      Question(
        text: "Tom is eating an apple. What is Tom doing?",
        options: ["Running", "Sleeping", "Eating", "Jumping"],
        correctAnswer: "Eating",
      ),

      Question(
        text: "It is raining. What should you use?",
        options: ["Sunglasses", "Umbrella", "Shoes", "Hat"],
        correctAnswer: "Umbrella",
      ),
    ],
    "Colors": [
      Question(
        text: "What color is the sky?",
        options: ["Red", "Blue", "Green", "Yellow"],
        correctAnswer: "Blue",
      ),
      Question(
        text: "What color is grass?",
        options: ["Blue", "Green", "Red", "Purple"],
        correctAnswer: "Green",
      ),
      Question(
        text: "What color is the sun?",
        options: ["Yellow", "Blue", "Green", "White"],
        correctAnswer: "Yellow",
      ),
      Question(
        text: "What color is a banana?",
        options: ["Yellow", "Red", "Blue", "Black"],
        correctAnswer: "Yellow",
      ),
      Question(
        text: "What color is a fire truck?",
        options: ["Red", "Blue", "Green", "Yellow"],
        correctAnswer: "Red",
      ),
    ],
    "Shapes": [
      Question(
        text: "How many sides does a triangle have?",
        options: ["2", "3", "4", "5"],
        correctAnswer: "3",
      ),
      Question(
        text: "What shape is a ball?",
        options: ["Square", "Circle", "Triangle", "Rectangle"],
        correctAnswer: "Circle",
      ),
      Question(
        text: "How many sides does a square have?",
        options: ["3", "4", "5", "6"],
        correctAnswer: "4",
      ),
      Question(
        text: "Which shape has no corners?",
        options: ["Triangle", "Square", "Circle", "Rectangle"],
        correctAnswer: "Circle",
      ),
      Question(
        text: "How many points does a star have?",
        options: ["3", "4", "5", "6"],
        correctAnswer: "5",
      ),
    ],
  },
  "Grade 3-4": {
    "Math": [
      Question(
        text: "What is 12 + 8?",
        options: ["18", "20", "22", "24"],
        correctAnswer: "20",
      ),
      Question(
        text: "What is 5 × 4?",
        options: ["15", "20", "25", "30"],
        correctAnswer: "20",
      ),
      Question(
        text: "What is 100 - 35?",
        options: ["55", "65", "75", "85"],
        correctAnswer: "65",
      ),
      Question(
        text: "What is 7 × 6?",
        options: ["40", "42", "44", "48"],
        correctAnswer: "42",
      ),
      Question(
        text: "What is 48 ÷ 6?",
        options: ["6", "7", "8", "9"],
        correctAnswer: "8",
      ),
    ],
    "Science": [
      Question(
        text: "What do plants need to make food?",
        options: ["Sunlight", "Soil", "Water", "All of these"],
        correctAnswer: "All of these",
      ),
      Question(
        text: "Which planet do we live on?",
        options: ["Mars", "Earth", "Venus", "Jupiter"],
        correctAnswer: "Earth",
      ),
      Question(
        text: "What gas do humans breathe to live?",
        options: ["Oxygen", "Carbon", "Nitrogen", "Helium"],
        correctAnswer: "Oxygen",
      ),
      Question(
        text: "How many seasons are there?",
        options: ["2", "3", "4", "5"],
        correctAnswer: "4",
      ),
      Question(
        text: "What is H2O commonly known as?",
        options: ["Salt", "Water", "Sugar", "Milk"],
        correctAnswer: "Water",
      ),
    ],
    "Reading": [
      Question(
        text: "What is a noun?",
        options: [
          "Action word",
          "Naming word",
          "Describing word",
          "Feeling word",
        ],
        correctAnswer: "Naming word",
      ),
      Question(
        text: "What is the plural of 'child'?",
        options: ["Childs", "Children", "Childes", "Child"],
        correctAnswer: "Children",
      ),
      Question(
        text: "What is the past tense of 'run'?",
        options: ["Runed", "Running", "Ran", "Runs"],
        correctAnswer: "Ran",
      ),
      Question(
        text: "Which word is an adjective?",
        options: ["Quickly", "Happy", "Run", "Table"],
        correctAnswer: "Happy",
      ),
      Question(
        text: "What is a synonym for 'big'?",
        options: ["Tiny", "Small", "Large", "Thin"],
        correctAnswer: "Large",
      ),
    ],
    "Art": [
      Question(
        text: "Which is a primary color?",
        options: ["Green", "Orange", "Red", "Purple"],
        correctAnswer: "Red",
      ),
      Question(
        text: "What color do red and yellow make?",
        options: ["Green", "Orange", "Purple", "Brown"],
        correctAnswer: "Orange",
      ),
      Question(
        text: "What tool is used to mix paint?",
        options: ["Brush", "Palette", "Canvas", "Easel"],
        correctAnswer: "Palette",
      ),
      Question(
        text: "What is a color wheel used for?",
        options: [
          "Drawing",
          "Showing color relationships",
          "Painting",
          "Sculpting",
        ],
        correctAnswer: "Showing color relationships",
      ),
      Question(
        text: "Which famous artist painted the Mona Lisa?",
        options: ["Van Gogh", "Picasso", "Da Vinci", "Monet"],
        correctAnswer: "Da Vinci",
      ),
    ],
  },
  "Grade 5-6": {
    "Math": [
      Question(
        text: "What is 15% of 200?",
        options: ["25", "30", "35", "40"],
        correctAnswer: "30",
      ),
      Question(
        text: "Solve: 3x + 5 = 20",
        options: ["x=3", "x=5", "x=7", "x=10"],
        correctAnswer: "x=5",
      ),
      Question(
        text: "What is the area of a 4×5 rectangle?",
        options: ["9", "18", "20", "25"],
        correctAnswer: "20",
      ),
      Question(
        text: "What is 12 × 11?",
        options: ["121", "132", "144", "156"],
        correctAnswer: "132",
      ),
      Question(
        text: "What is 1/2 of 50?",
        options: ["20", "25", "30", "35"],
        correctAnswer: "25",
      ),
    ],
    "Science": [
      Question(
        text: "What is H₂O?",
        options: ["Salt", "Water", "Sugar", "Oxygen"],
        correctAnswer: "Water",
      ),
      Question(
        text: "What gas do plants release?",
        options: ["Oxygen", "Carbon dioxide", "Nitrogen", "Hydrogen"],
        correctAnswer: "Oxygen",
      ),
      Question(
        text: "What is the basic unit of life?",
        options: ["Atom", "Cell", "Molecule", "Tissue"],
        correctAnswer: "Cell",
      ),
      Question(
        text: "What process do plants use to make food?",
        options: ["Respiration", "Photosynthesis", "Digestion", "Fermentation"],
        correctAnswer: "Photosynthesis",
      ),
      Question(
        text: "What state of matter is ice?",
        options: ["Liquid", "Gas", "Solid", "Plasma"],
        correctAnswer: "Solid",
      ),
    ],
    "History": [
      Question(
        text: "When did Pakistan become independent?",
        options: ["1945", "1947", "1950", "1949"],
        correctAnswer: "1947",
      ),
      Question(
        text: "Who is called Quaid-e-Azam?",
        options: [
          "Allama Iqbal",
          "Liaquat Ali Khan",
          "Muhammad Ali Jinnah",
          "Ayub Khan",
        ],
        correctAnswer: "Muhammad Ali Jinnah",
      ),
      Question(
        text: "Who was Pakistan's first Prime Minister?",
        options: [
          "Liaquat Ali Khan",
          "Ayub Khan",
          "Zulfikar Ali Bhutto",
          "Iskander Mirza",
        ],
        correctAnswer: "Liaquat Ali Khan",
      ),
      Question(
        text: "What is Pakistan's national flower?",
        options: ["Rose", "Jasmine", "Sunflower", "Tulip"],
        correctAnswer: "Jasmine",
      ),
      Question(
        text: "What is Pakistan's national animal?",
        options: ["Lion", "Tiger", "Snow Leopard", "Markhor"],
        correctAnswer: "Markhor",
      ),
    ],
    "English": [
      Question(
        text: "What is the past tense of 'go'?",
        options: ["goed", "gone", "went", "going"],
        correctAnswer: "went",
      ),
      Question(
        text: "What is the plural of 'mouse'?",
        options: ["Mouses", "Mice", "Mouses", "Mices"],
        correctAnswer: "Mice",
      ),
      Question(
        text: "Which word is a synonym for 'huge'?",
        options: ["Tiny", "Small", "Massive", "Thin"],
        correctAnswer: "Massive",
      ),
      Question(
        text: "What is the antonym of 'hot'?",
        options: ["Warm", "Cold", "Boiling", "Spicy"],
        correctAnswer: "Cold",
      ),
      Question(
        text: "Which spelling is correct?",
        options: ["Recieve", "Receive", "Receve", "Recievee"],
        correctAnswer: "Receive",
      ),
    ],
  },
  "Grade 7-8": {
    "Algebra": [
      Question(
        text: "Solve: 2(x + 3) = 16",
        options: ["x=4", "x=5", "x=6", "x=7"],
        correctAnswer: "x=5",
      ),
      Question(
        text: "What is x if 3x - 7 = 14?",
        options: ["x=5", "x=6", "x=7", "x=8"],
        correctAnswer: "x=7",
      ),
      Question(
        text: "Solve for y: 4y = 20",
        options: ["y=4", "y=5", "y=6", "y=8"],
        correctAnswer: "y=5",
      ),
      Question(
        text: "Expand: 3(2x - 1)",
        options: ["6x - 3", "5x - 3", "6x - 1", "5x - 1"],
        correctAnswer: "6x - 3",
      ),
      Question(
        text: "Evaluate x² when x = 4",
        options: ["8", "12", "16", "24"],
        correctAnswer: "16",
      ),
    ],
    "Biology": [
      Question(
        text: "What is the powerhouse of the cell?",
        options: ["Nucleus", "Mitochondria", "Ribosome", "Cytoplasm"],
        correctAnswer: "Mitochondria",
      ),
      Question(
        text: "What does DNA stand for?",
        options: [
          "Deoxyribonucleic Acid",
          "Dynamic Nuclear Atom",
          "Double Nitrogen Atom",
          "Deoxyribose Nucleic Atom",
        ],
        correctAnswer: "Deoxyribonucleic Acid",
      ),
      Question(
        text: "Which blood type is the universal donor?",
        options: ["A", "B", "AB", "O"],
        correctAnswer: "O",
      ),
      Question(
        text: "What is the largest organ in the human body?",
        options: ["Heart", "Liver", "Skin", "Brain"],
        correctAnswer: "Skin",
      ),
      Question(
        text: "What gives plant cells their rigid shape?",
        options: ["Cell membrane", "Cell wall", "Nucleus", "Chloroplast"],
        correctAnswer: "Cell wall",
      ),
    ],
    "Geography": [
      Question(
        text: "What is the capital of Pakistan?",
        options: ["Lahore", "Karachi", "Islamabad", "Peshawar"],
        correctAnswer: "Islamabad",
      ),
      Question(
        text: "Which city is the largest in Pakistan?",
        options: ["Karachi", "Lahore", "Islamabad", "Multan"],
        correctAnswer: "Karachi",
      ),
      Question(
        text: "What is the highest mountain in Pakistan?",
        options: ["K2", "Nanga Parbat", "Rakaposhi", "Tirich Mir"],
        correctAnswer: "K2",
      ),
      Question(
        text: "Which is the longest river in Pakistan?",
        options: ["Indus", "Jhelum", "Chenab", "Ravi"],
        correctAnswer: "Indus",
      ),
      Question(
        text: "Which country shares the longest border with Pakistan?",
        options: ["China", "Afghanistan", "Iran", "India"],
        correctAnswer: "India",
      ),
    ],
    "Literature": [
      Question(
        text: "Who wrote 'Hamlet'?",
        options: ["Dickens", "Shakespeare", "Austen", "Hemingway"],
        correctAnswer: "Shakespeare",
      ),
      Question(
        text: "Who wrote 'Romeo and Juliet'?",
        options: ["Shakespeare", "Dickens", "Twain", "Orwell"],
        correctAnswer: "Shakespeare",
      ),
      Question(
        text: "What is a novel?",
        options: ["Short story", "Long fictional narrative", "Poem", "Play"],
        correctAnswer: "Long fictional narrative",
      ),
      Question(
        text: "What is poetry written in called?",
        options: ["Stanzas", "Paragraphs", "Chapters", "Verses"],
        correctAnswer: "Verses",
      ),
      Question(
        text: "What does 'protagonist' mean?",
        options: [
          "Villain",
          "Main character",
          "Supporting character",
          "Narrator",
        ],
        correctAnswer: "Main character",
      ),
    ],
  },
  "Grade 9-10": {
    "Physics": [
      Question(
        text: "What is the unit of force?",
        options: ["Joule", "Newton", "Watt", "Pascal"],
        correctAnswer: "Newton",
      ),
      Question(
        text: "What is the speed of light?",
        options: ["3×10⁶ m/s", "3×10⁸ m/s", "3×10¹⁰ m/s", "3×10¹² m/s"],
        correctAnswer: "3×10⁸ m/s",
      ),
      Question(
        text: "What law states F=ma?",
        options: ["1st Law", "2nd Law", "3rd Law", "Law of Gravity"],
        correctAnswer: "2nd Law",
      ),
      Question(
        text: "What is the acceleration due to gravity?",
        options: ["8.9 m/s²", "9.8 m/s²", "10.2 m/s²", "11.1 m/s²"],
        correctAnswer: "9.8 m/s²",
      ),
      Question(
        text: "In which medium does sound travel fastest?",
        options: ["Air", "Water", "Vacuum", "Steel"],
        correctAnswer: "Steel",
      ),
    ],
    "Chemistry": [
      Question(
        text: "What is the chemical symbol for gold?",
        options: ["Go", "Gd", "Au", "Ag"],
        correctAnswer: "Au",
      ),
      Question(
        text: "What is the chemical formula for water?",
        options: ["HO", "H2O", "H2O2", "OH"],
        correctAnswer: "H2O",
      ),
      Question(
        text: "What is the pH of a neutral solution?",
        options: ["0", "7", "14", "1"],
        correctAnswer: "7",
      ),
      Question(
        text: "What is the atomic number of Carbon?",
        options: ["4", "6", "8", "12"],
        correctAnswer: "6",
      ),
      Question(
        text: "Which element is a noble gas?",
        options: ["Oxygen", "Helium", "Nitrogen", "Chlorine"],
        correctAnswer: "Helium",
      ),
    ],
    "Geometry": [
      Question(
        text: "What is the sum of angles in a triangle?",
        options: ["90°", "180°", "270°", "360°"],
        correctAnswer: "180°",
      ),
      Question(
        text: "What is the area of a circle?",
        options: ["πr²", "2πr", "πd", "½bh"],
        correctAnswer: "πr²",
      ),
      Question(
        text: "What does the Pythagorean theorem state?",
        options: ["a+b=c", "a²+b²=c²", "a×b=c", "2a+2b=c"],
        correctAnswer: "a²+b²=c²",
      ),
      Question(
        text: "What do parallel lines never do?",
        options: ["Cross", "Stay apart", "Curve", "Intersect"],
        correctAnswer: "Intersect",
      ),
      Question(
        text: "How many faces does a cube have?",
        options: ["4", "5", "6", "8"],
        correctAnswer: "6",
      ),
    ],
    "Coding": [
      Question(
        text: "What does HTML stand for?",
        options: [
          "Hyper Text Markup Language",
          "High Tech Modern Language",
          "Hyper Transfer Markup Language",
          "Home Tool Markup Language",
        ],
        correctAnswer: "Hyper Text Markup Language",
      ),
      Question(
        text: "Who created Python?",
        options: [
          "Bill Gates",
          "Guido van Rossum",
          "Steve Jobs",
          "James Gosling",
        ],
        correctAnswer: "Guido van Rossum",
      ),
      Question(
        text: "Which loop checks condition first?",
        options: ["do-while", "for", "while", "repeat"],
        correctAnswer: "while",
      ),
      Question(
        text: "What is a variable?",
        options: ["Fixed value", "Storage location", "Function", "Error"],
        correctAnswer: "Storage location",
      ),
      Question(
        text: "What does CSS stand for?",
        options: [
          "Computer Style Sheets",
          "Cascading Style Sheets",
          "Creative Style System",
          "Colorful Style Sheets",
        ],
        correctAnswer: "Cascading Style Sheets",
      ),
    ],
  },
  "Grade 11-12": {
    "Calculus": [
      Question(
        text: "What is the derivative of x²?",
        options: ["x", "2x", "X x X", "2"],
        correctAnswer: "2x",
      ),
      Question(
        text: "What is ∫2x dx?",
        options: ["x²", "x² + C", "2x²", "2x + C"],
        correctAnswer: "x² + C",
      ),
      Question(
        text: "What is the limit of sin(x)/x as x→0?",
        options: ["0", "1", "∞", "undefined"],
        correctAnswer: "1",
      ),
      Question(
        text: "What rule is used for f(g(x)) derivative?",
        options: ["Product rule", "Quotient rule", "Chain rule", "Sum rule"],
        correctAnswer: "Chain rule",
      ),
      Question(
        text: "What does a negative second derivative indicate?",
        options: ["Minimum", "Maximum", "Inflection", "Constant"],
        correctAnswer: "Maximum",
      ),
    ],
    "Economics": [
      Question(
        text: "What does GDP stand for?",
        options: [
          "Gross Domestic Product",
          "General Demand Price",
          "Global Development Plan",
          "Government Debt Percentage",
        ],
        correctAnswer: "Gross Domestic Product",
      ),
      Question(
        text: "What law explains price and quantity relationship?",
        options: [
          "Law of Supply",
          "Law of Demand",
          "Law of Diminishing Returns",
          "Law of Comparative Advantage",
        ],
        correctAnswer: "Law of Demand",
      ),
      Question(
        text: "What is inflation?",
        options: [
          "Falling prices",
          "Rising prices",
          "Stable prices",
          "Negative interest",
        ],
        correctAnswer: "Rising prices",
      ),
      Question(
        text: "What is opportunity cost?",
        options: [
          "Direct cost",
          "Next best alternative forgone",
          "Fixed cost",
          "Variable cost",
        ],
        correctAnswer: "Next best alternative forgone",
      ),
      Question(
        text: "What is the role of a central bank?",
        options: [
          "Print money and control monetary policy",
          "Set taxes",
          "Regulate stock market",
          "Manage foreign trade",
        ],
        correctAnswer: "Print money and control monetary policy",
      ),
    ],
    "Statistics": [
      Question(
        text: "What is the mean of [2, 4, 6, 8]?",
        options: ["4", "5", "6", "7"],
        correctAnswer: "5",
      ),
      Question(
        text: "What is the median?",
        options: ["Average", "Middle value", "Most frequent", "Difference"],
        correctAnswer: "Middle value",
      ),
      Question(
        text: "What does standard deviation measure?",
        options: [
          "Central tendency",
          "Spread of data",
          "Maximum value",
          "Minimum value",
        ],
        correctAnswer: "Spread of data",
      ),
      Question(
        text: "What is the probability of heads in a fair coin?",
        options: ["0.25", "0.5", "0.75", "1.0"],
        correctAnswer: "0.5",
      ),
      Question(
        text: "What is the range of correlation coefficients?",
        options: ["0 to 1", "-1 to 1", "-100 to 100", "0 to 100"],
        correctAnswer: "-1 to 1",
      ),
    ],
    "SAT Prep": [
      Question(
        text: "If 2x + 3 = 11, what is x?",
        options: ["3", "4", "5", "6"],
        correctAnswer: "4",
      ),
      Question(
        text: "Book is to read as song is to:",
        options: ["Listen", "Sing", "Write", "Play"],
        correctAnswer: "Listen",
      ),
      Question(
        text: "Which sentence has correct grammar?",
        options: [
          "She don't like it",
          "She doesn't likes it",
          "She doesn't like it",
          "She not like it",
        ],
        correctAnswer: "She doesn't like it",
      ),
      Question(
        text: "What is 3⁴?",
        options: ["12", "27", "81", "64"],
        correctAnswer: "81",
      ),
      Question(
        text: "The word 'benevolent' means:",
        options: [
          "Kind and generous",
          "Evil and cruel",
          "Confused and lost",
          "Angry and loud",
        ],
        correctAnswer: "Kind and generous",
      ),
    ],
  },
};

class Quiz extends StatefulWidget {
  final String subject;
  final String grade;

  const Quiz({super.key, required this.subject, required this.grade});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  late List<Question> _questions;
  late List<String?> _selectedAnswers;
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int _score = 0;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadQuestions();
    _selectedAnswers = List<String?>.filled(_questions.length, null);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
  }

  void _loadQuestions() {
    final gradeQuestions = quizData[widget.grade];
    final subjectQuestions = gradeQuestions?[widget.subject];

    _questions =
        subjectQuestions ??
        [
          Question(
            text: "Sample question for ${widget.subject}?",
            options: ["Option A", "Option B", "Option C", "Option D"],
            correctAnswer: "Option A",
          ),
        ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _submitQuiz() {
    if (_selectedAnswers.contains(null)) {
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions'),
          backgroundColor: Color(0xFFef4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    HapticFeedback.mediumImpact();

    _score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctAnswer) {
        _score++;
      }
    }

    setState(() => _isSubmitted = true);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ResultPage(
          score: _score,
          totalQuestions: _questions.length,
          grade: widget.grade,
          subject: widget.subject,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildOption(int questionIndex, String option) {
    final isSelected = _selectedAnswers[questionIndex] == option;
    final isCorrect =
        _isSubmitted && option == _questions[questionIndex].correctAnswer;
    final isWrong = _isSubmitted && isSelected && !isCorrect;

    return GlassContainer(
      borderRadius: BorderRadius.circular(14),
      overlayColor: isCorrect
          ? const Color(0xFF22c55e)
          : isWrong
          ? const Color(0xFFef4444)
          : isSelected
          ? const Color(0xFF3b82f6)
          : null,
      borderOpacity: isSelected ? 0.4 : 0.12,
      child: RadioListTile<String>(
        title: Text(
          option,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected || isCorrect
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
        value: option,
        groupValue: _selectedAnswers[questionIndex],
        activeColor: const Color(0xFF3b82f6),
        onChanged: _isSubmitted
            ? null
            : (val) {
                HapticFeedback.selectionClick();
                setState(() => _selectedAnswers[questionIndex] = val);
              },
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      ),
    );
  }

  Widget _buildQuestion(int index) {
    final question = _questions[index];

    final anim = CurvedAnimation(
      parent: _fadeController,
      curve: Interval(index * 0.1, 1.0, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return Transform.translate(
            offset: Tween<Offset>(
              begin: const Offset(0, 20),
              end: Offset.zero,
            ).evaluate(anim),
            child: child,
          );
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF3b82f6).withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFF3b82f6),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      question.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...question.options.map(
                (opt) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildOption(index, opt),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: Text(
          widget.subject,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF22c55e),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$_score/${_questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value:
                (_selectedAnswers.where((a) => a != null).length) /
                _questions.length,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3b82f6)),
            minHeight: 4,
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.all(isSmallScreen ? 14 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school,
                          color: Color(0xFF3b82f6),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.grade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 14 : 20),

                  ...List.generate(_questions.length, _buildQuestion),

                  SizedBox(height: isSmallScreen ? 16 : 24),

                  Center(
                    child: ElevatedButton(
                      onPressed: _isSubmitted ? null : _submitQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSubmitted
                            ? Colors.grey
                            : const Color(0xFF3b82f6),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 32 : 48,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _isSubmitted ? 'Submitted ✓' : 'Submit Answers',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
