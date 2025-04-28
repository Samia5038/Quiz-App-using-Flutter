// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/quiz_screen.dart';
// import 'package:flutter_application_1/screens/welcome_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Quiz App',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF1D1E33),
//         primaryColor: Colors.white,
//       ),
//       home: const WelcomeScreen(),
//     );
//   }
// }




import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E2A38),
      ),
      home: StartScreen(),
    );
  }
}

// ------------------ Start Screen ------------------
class StartScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
     "Let's Play\nকুইজ",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),

              SizedBox(height: 40),
              Text("Enter your information below", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Start", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Quiz Screen ------------------
class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Question> questions = [
  Question("Which animal is known as the 'King of the Jungle'?", ["Tiger", "Elephant", "Lion", "Cheetah"], 2),
  Question("How many hours are there in a day?", ["24", "12", "48", "36"], 0),
  Question("What is the boiling point of water in Celsius?", ["90°C", "100°C", "80°C", "120°C"], 1),
  Question("Who invented the lightbulb?", ["Edison", "Newton", "Tesla", "Einstein"], 0),
  Question("Which ocean is the largest?", ["Atlantic", "Indian", "Pacific", "Arctic"], 2),
  Question("What is the smallest prime number?", ["0", "1", "2", "3"], 2),
  Question("Which planet is closest to the sun?", ["Mars", "Earth", "Mercury", "Venus"], 2),
  Question("What is the capital of Bangladesh?", ["Chittagong", "Dhaka", "Khulna", "Sylhet"], 1),
  Question("How many sides does a triangle have?", ["3", "4", "5", "6"], 0),
  Question("Which color is made by mixing red and blue?", ["Green", "Purple", "Orange", "Yellow"], 1),
];


  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctIndex) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FinalScoreScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1}/${questions.length}",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            SizedBox(height: 20),
            Text(
              question.question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ...List.generate(question.options.length, (index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(question.options[index], style: TextStyle(fontSize: 16)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ------------------ Final Score Screen ------------------
class FinalScoreScreen extends StatelessWidget {
  final int score;
  final int total;

  const FinalScoreScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    double percent = score / total;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Final Score", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 12,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  ),
                  Text("$score/$total",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Text("Correct Answers", style: TextStyle(color: Colors.white70, fontSize: 18)),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Try Again", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Question Model ------------------
class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question(this.question, this.options, this.correctIndex);
}