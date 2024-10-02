import 'package:flutter/material.dart';
import '../repository/image_repository.dart';

Row ContactFooter() {
  ImageRepository _imageRepository = ImageRepository();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'Need any help? Contact:',
        style: TextStyle(
          fontSize: 8.0,
          color: Colors.blueGrey[80],
        ),
      ),
      const SizedBox(width: 10.0,),
      InkWell(
        onTap: _imageRepository.launchEmail,
        child: Image.asset("assets/gmail.png", height: 15.0, width: 15.0,),
      ),
      const SizedBox(width: 10.0,),
      InkWell(
        onTap: _imageRepository.launchLinkedIn,
        child: Image.asset("assets/linkedin.png", height: 15.0, width: 15.0,),
      ),
      const SizedBox(width: 10.0,),
      InkWell(
        onTap: _imageRepository.launchFacebook,
        child: Image.asset("assets/facebook.png", height: 15.0, width: 15.0,),
      ),
    ],
  );
}