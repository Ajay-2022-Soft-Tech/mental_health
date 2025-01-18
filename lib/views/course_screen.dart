import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  // Dynamic data for the course steps
  final List<Map<String, String>> steps = [
    {
      "title": "Welcome",
      "subtitle": "Find your inner peace",
      "duration": "2 min",
      "type": "Play",
      "image": "assets/images/welcome.jpg",
      "color": "0xFF76C7C5", // Light Teal
    },
    {
      "title": "Harmony",
      "subtitle": "Balance mind and body",
      "duration": "3 min",
      "type": "Play",
      "image": "assets/images/welcome_1.png",
      "color": "0xFF8A56AC", // Purple
    },
    {
      "title": "Serenity",
      "subtitle": "Find peace in nature",
      "duration": "2 min",
      "type": "Play",
      "image": "assets/images/welcome_2.png",
      "color": "0xFF6CC551", // Green
    },
    {
      "title": "Stillness",
      "subtitle": "Quiet your thoughts",
      "duration": "1 min",
      "type": "Read",
      "image": "assets/images/welcome_3.png",
      "color": "0xFFFFC073", // Orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Course",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What is meditation",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Meditation is a practice in which an individual uses a technique to train attention and awareness, and achieve a mentally clear and emotionally calm and stable state.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/floating_character.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(color: Colors.grey[300]),

              // Steps Section
              ListView.builder(
                shrinkWrap: true, // Ensures ListView takes minimal space
                physics: NeverScrollableScrollPhysics(), // Prevents conflicts with SingleChildScrollView
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return _buildCourseStep(
                    step["title"]!,
                    step["subtitle"]!,
                    step["duration"]!,
                    step["type"]!,
                    step["image"]!,
                    Color(int.parse(step["color"]!)),
                    isFirst: index == 0,
                    isLast: index == steps.length - 1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for a Course Step
  Widget _buildCourseStep(
      String title,
      String subtitle,
      String duration,
      String type,
      String image,
      Color color, {
        bool isFirst = false,
        bool isLast = false,
      }) {
    return Stack(
      children: [
        // Timeline Indicator
        Positioned(
          left: 20,
          top: 0,
          bottom: 0,
          child: Column(
            children: [
              if (!isFirst)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.green, // Active marker color
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
        ),

        // Step Card
        Container(
          margin: const EdgeInsets.only(left: 40, bottom: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Step Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),

                // Step Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            type == "Play" ? Icons.play_circle : Icons.book,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            duration,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
