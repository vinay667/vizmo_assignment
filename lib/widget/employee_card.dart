import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final String imageUrl, empName, empPhone, empEmail;

    EmployeeCard(
      {required this.imageUrl,
      required this.empEmail,
      required this.empName,
      required this.empPhone});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.tealAccent,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 4,
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [

            CircleAvatar(
              radius: 28, // Image radius
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  empName,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(height: 2),
                Text(
                  empPhone,
                  style:
                      TextStyle(fontSize: 16, color: Colors.deepPurpleAccent),
                ),
                const SizedBox(height: 2),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Text(
                    empEmail,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
