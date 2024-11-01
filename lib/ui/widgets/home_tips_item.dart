import 'package:flutter/material.dart';
import 'package:wallet/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTipsItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String Url;
  const HomeTipsItem({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.Url, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        if(await canLaunch(Url)) {
          launch(Url);
        }
      },
      child: Container(
        width: 145,
        height: 176,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                imgUrl,
                width: 155,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                title,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
