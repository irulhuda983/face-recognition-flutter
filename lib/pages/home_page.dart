import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                      Text(
                        'Orlando Diggs.',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                    radius: 24,
                  ),
                ],
              ),
              // end header
              SizedBox(height: 25),
              // margin
              // kotak CTA
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1C0D84),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '50% off',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('take any courses', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                            child: Text("Join Now"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset('assets/images/mentorship.png', height: 100),
                  ],
                ),
              ),
              // end kotak cta
              SizedBox(height: 25),
              Text('Find Your Job', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
