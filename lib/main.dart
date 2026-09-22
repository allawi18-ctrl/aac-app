import 'package:flutter/material.dart';

void main() {
  runApp(const AacApp());
}

class AacApp extends StatelessWidget {
  const AacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق التواصل',
      // تفعيل الاتجاه من اليمين لليسار للغة العربية
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const MainScreen(),
    );
  }
}

// نموذج بيانات مرن للكلمات
class WordItem {
  final String word;
  final Color color;
  final IconData icon;

  WordItem(this.word, this.color, this.icon);
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // شريط الجملة الذي تتجمع فيه الكلمات
  List<String> sentence = [];

  // قائمة الكلمات الأساسية والألوان (نظام Fitzgerald)
  final List<WordItem> words = [
    WordItem('أنا', Colors.yellow[300]!, Icons.person),
    WordItem('أريد', Colors.green[300]!, Icons.front_hand),
    WordItem('ماء', Colors.orange[300]!, Icons.water_drop),
    WordItem('أنت', Colors.yellow[300]!, Icons.person_outline),
    WordItem('أذهب', Colors.green[300]!, Icons.directions_run),
    WordItem('طعام', Colors.orange[300]!, Icons.restaurant),
    WordItem('هو', Colors.yellow[300]!, Icons.boy),
    WordItem('ألعب', Colors.green[300]!, Icons.sports_esports),
    WordItem('حمام', Colors.orange[300]!, Icons.wc),
    WordItem('سعيد', Colors.blue[300]!, Icons.sentiment_satisfied_alt),
    WordItem('حزين', Colors.blue[300]!, Icons.sentiment_dissatisfied),
    WordItem('كبير', Colors.blue[300]!, Icons.open_in_full),
  ];

  void addWord(String word) {
    setState(() {
      sentence.add(word);
    });
  }

  void removeLastWord() {
    if (sentence.isNotEmpty) {
      setState(() {
        sentence.removeLast();
      });
    }
  }

  void clearSentence() {
    setState(() {
      sentence.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      // شريط الجملة العلوي
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: clearSentence,
            ),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    sentence.join(' '), 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.backspace_outlined, color: Colors.black54),
              onPressed: removeLastWord,
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, color: Colors.blue, size: 32),
              onPressed: () {},
            ),
          ],
        ),
      ),

      // شبكة الأزرار الوسطى
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: words.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            childAspectRatio: 1.2, 
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final item = words[index];
            return InkWell(
              onTap: () => addWord(item.word),
              child: Container(
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: Colors.black87),
                    const SizedBox(height: 8),
                    Text(
                      item.word,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // شريط القوائم السفلي
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الأساسية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'عبارات'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'مواضيع'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'إعدادات'),
        ],
      ),
    );
  }
}
