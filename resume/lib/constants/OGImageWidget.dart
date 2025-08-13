import 'package:flutter/material.dart';

class OGImageWidget extends StatelessWidget {
  const OGImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1200, // OG standard width
      height: 630, // OG standard height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.indigo.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.asset(
              'assets/images/nagasoftlogo.png',
              width: 200,
              height: 200,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Venunath M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Full Stack Developer | Freelancer & Full-time',
                    style: TextStyle(color: Colors.white70, fontSize: 36),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Flutter | React | .NET Core | Firebase | SQL',
                    style: TextStyle(color: Colors.white60, fontSize: 28),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
