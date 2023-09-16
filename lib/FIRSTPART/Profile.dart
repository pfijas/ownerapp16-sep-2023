// import 'package:flutter/material.dart';
// class UserProfile {
//   final String name;
//   final String email;
//   final String imageUrl;
//
//   UserProfile({
//     required this.name,
//     required this.email,
//     required this.imageUrl,
//   });
// }
// class ProfilePage extends StatelessWidget {
//   final UserProfile user = UserProfile(
//     name: 'John Doe',
//     email: 'john.doe@example.com',
//     imageUrl: 'https://www.example.com/profile.jpg',
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           CircleAvatar(
//             radius: 60,
//             backgroundImage: NetworkImage(user.imageUrl),
//           ),
//           SizedBox(height: 16),
//           Text(
//             user.name,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 8),
//           Text(
//             user.email,
//             style: TextStyle(fontSize: 18, color: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Edit Profile'),
//             onTap: () {
//               // Navigate to edit profile page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               // Navigate to settings page
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: Text('Log Out'),
//             onTap: () {
//               // Implement log out functionality
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
