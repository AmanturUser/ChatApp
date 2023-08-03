import 'package:flutter/material.dart';
import 'package:whatsapp_ui/constants.dart';
import 'package:whatsapp_ui/screens/chat_screen.dart';
import 'package:whatsapp_ui/widgets/chat_list.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: CustomColors.kGreyColor.withOpacity(0.5),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                  height: screenHeight * 0.2,
                  width: screenWidth,
                  color: CustomColors.kPrimaryColor),
            ),
            Positioned(
              top: screenHeight * 0.05,
              bottom: screenHeight * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              child: Container(
                height: screenHeight * 0.9,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: CustomColors.kLightColor,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 10.0),
                  ],
                ),
                child: Row(
                  children: [
                    _buildLeftSide(screenWidth),
                    Container(
                      width: screenWidth * 0.65,
                      height: screenHeight*0.9,
                      child: ChatScreen(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSide(double screenWidth) {
    return Container(
      width: screenWidth * 0.25,
      child: Column(
        children: [
          Expanded(
            child: ChatList(),
          ),
        ],
      ),
    );
  }
}
