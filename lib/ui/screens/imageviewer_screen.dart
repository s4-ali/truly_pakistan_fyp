import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class ImageViewerScreen extends StatelessWidget {
  final List<String> images;

  const ImageViewerScreen(this.images,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: PageView(
                    children: images.map((imageUrl) =>
                        Center(
                          child: CachedNetworkImage(
                            imageUrl:imageUrl,
                            width: double.infinity,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        )
                    ).toList()
                )
            ),
          ),
          _getBackButton(context),
        ],
      ),
    );
  }


  Widget _getBackButton(BuildContext context){
    return Positioned(
      top: getTopPadding(context) + 16,
      left: 8.0,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
