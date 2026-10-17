import 'package:flutter/material.dart';
import 'package:pamyatka_for_mind/rule_model.dart';

class RuleWidg extends StatelessWidget {
  final rule Rule_model;
  final VoidCallback? onTap;

  const RuleWidg({super.key, required this.Rule_model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.003),
      width: size.width * 0.97,

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 49, 49),

        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromARGB(57, 255, 255, 255)),
        boxShadow: [],
      ),

      child: Padding(
        padding: EdgeInsetsGeometry.all(size.height / size.width * 5),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
          
                children: [ 

                  Text( 
                    // name
                    softWrap: true,
                    "${Rule_model.rule_name}",
                    style: TextStyle(
                      fontSize: size.width * 0.075,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),

                  SizedBox(width: size.width * 0.1),

                  Text( 
                    //subject
                    softWrap: true,
                    "${Rule_model.subject} ${Rule_model.class_int}",
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(160, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.01),
            Wrap(
              children: [
                Text(
                  //description
                  "${Rule_model.description}",
                  style: TextStyle(
                    
                    fontSize: size.width * 0.050,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(220, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
