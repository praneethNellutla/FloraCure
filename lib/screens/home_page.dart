import 'package:flora_cure/screens/expert_dashboard.dart';
import 'package:flora_cure/screens/farmer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  final String userId;
  const HomePage({super.key, required this.userId});
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId) // Replace with the actual document ID or path
        .get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      // Handle the case where the user document doesn't exist.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
          future: getUserData(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              // Handle the case where the document doesn't exist.
              return const Center(child: Text('User data not found.'));
            } else {
              final userData = snapshot.data!;
              final userType = userData['userType'] as String?;

              if (userType == "Farmer") {
                return FarmerDashBoard(
                  user: userData,
                  index: 0,
                );
              } else {
                return ExpertDashBoard(user: userData);
              }
            }
          },
        ),
      ),
    );
  }
}
