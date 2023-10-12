import 'package:flutter/material.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent)
      ),
      margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 4,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: primary)
              ),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("This is Task one",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primary,


                ),),
                Text("Task one description",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,

                ),),

              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 2),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(12),

              ),
              child:Icon(Icons.done,color: Colors.white,size: 30,),
            ),
          ],
        ),
      ),);
  }
}
