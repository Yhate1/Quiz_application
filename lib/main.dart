// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ali',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Login(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   String? ans1;
//   String? ans2;
//   String? ans3;
//   String? ans4;

//   int score = 0;

//   late ScrollController _scrollController;
//   late AnimationController _animationController;
//   late Animation<double> _progressAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _scrollController = ScrollController();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _progressAnimation = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   double get progress =>
//       [ans1, ans2, ans3, ans4].where((a) => a != null).length / 4;

//   void updateProgress() {
//     if (!mounted) return;

//     final oldValue = _progressAnimation.value;
//     _progressAnimation = Tween<double>(begin: oldValue, end: progress).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _animationController.forward(from: 0);
//   }

//   void calculateScore() {
//     score = 0;
//     if (ans1 == 'Quaid-e-Azam') score++;
//     if (ans2 == 'Urdu') score++;
//     if (ans3 == 'Islamabad') score++;
//     if (ans4 == 'Karachi') score++;
//   }

//   Widget option(String value, String? groupValue, Function(String?) onChanged) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF162435),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Radio<String>(
//             value: value,
//             groupValue: groupValue,
//             activeColor: Colors.blue,
//             onChanged: (val) {
//               if (!mounted) return;
//               onChanged(val);
//               updateProgress();
//             },
//           ),
//           Expanded(
//             child: Text(value, style: const TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   void submitAndNavigate() {
//     if ([ans1, ans2, ans3, ans4].contains(null)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please answer all questions')),
//       );
//       return;
//     }

//     calculateScore();

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultPage(score: score, totalQuestions: 4),
//       ),
//     ).then((_) {
//       if (!mounted) return;

//       // Reset all answers
//       setState(() {
//         ans1 = null;
//         ans2 = null;
//         ans3 = null;
//         ans4 = null;
//         score = 0;
//       });

//       // Reset progress after rebuild
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         updateProgress();

//         // Scroll smoothly to top
//         if (_scrollController.hasClients) {
//           _scrollController.animateTo(
//             0,
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeInOut,
//           );
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0E21),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xFF0A0E21),
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         controller: _scrollController,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // QUESTION 1
//               const Text(
//                 'Founder Of Pakistan?',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               option('Quaid-e-Azam', ans1, (value) => setState(() => ans1 = value)),
//               option('Allama Iqbal', ans1, (value) => setState(() => ans1 = value)),
//               option('Liaquat Ali Khan', ans1, (value) => setState(() => ans1 = value)),
//               option('M Ali Jinnah', ans1, (value) => setState(() => ans1 = value)),
//               const SizedBox(height: 20),

//               // QUESTION 2
//               const Text(
//                 'National Language Of Pakistan?',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               option('Urdu', ans2, (value) => setState(() => ans2 = value)),
//               option('Punjabi', ans2, (value) => setState(() => ans2 = value)),
//               option('Sindhi', ans2, (value) => setState(() => ans2 = value)),
//               option('Pashto', ans2, (value) => setState(() => ans2 = value)),
//               const SizedBox(height: 20),

//               // QUESTION 3
//               const Text(
//                 'Capital Of Pakistan?',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               option('Lahore', ans3, (value) => setState(() => ans3 = value)),
//               option('Islamabad', ans3, (value) => setState(() => ans3 = value)),
//               option('Karachi', ans3, (value) => setState(() => ans3 = value)),
//               option('Peshawar', ans3, (value) => setState(() => ans3 = value)),
//               const SizedBox(height: 20),

//               // QUESTION 4
//               const Text(
//                 'Largest City Of Pakistan?',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               option('Karachi', ans4, (value) => setState(() => ans4 = value)),
//               option('Lahore', ans4, (value) => setState(() => ans4 = value)),
//               option('Islamabad', ans4, (value) => setState(() => ans4 = value)),
//               option('Multan', ans4, (value) => setState(() => ans4 = value)),
//               const SizedBox(height: 30),

//               // SUBMIT BUTTON
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   ),
//                   onPressed: submitAndNavigate,
//                   child: const Text("Submit"),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // ANIMATED PROGRESS BAR AT BOTTOM
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: AnimatedBuilder(
//                   animation: _progressAnimation,
//                   builder: (context, child) {
//                     return LinearProgressIndicator(
//                       value: _progressAnimation.value,
//                       minHeight: 8,
//                       backgroundColor: Colors.grey[800],
//                       valueColor: const AlwaysStoppedAnimation(Colors.blue),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }