import 'package:avatar_view/avatar_view.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

class CameraWithMaskFilterScreen extends StatefulWidget {
  CameraWithMaskFilterScreen({Key key}) : super(key: key);

  @override
  _CameraWithMaskFilterScreenState createState() =>
      _CameraWithMaskFilterScreenState();
}

class _CameraWithMaskFilterScreenState
    extends State<CameraWithMaskFilterScreen> {
  String _platformVersion = 'Unknown';
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('DeepAR Camera Example'),
        ),
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  _platformVersion = "Camera status $isReady";
                  setState(() {});
                },
                androidLicenceKey:
                    "acc3fd88314893cf11da31ae1aab2b869f358a36869c41e8b18eda43f79ec9eee7cb48f1a229c742",
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(8, (page) {
                          bool active = currentPage == page;
                          return GestureDetector(
                            onTap: () {
                              currentPage = page;
                              cameraDeepArController.changeMask(page);
                              setState(() {});
                            },
                            child: AvatarView(
                              radius: active ? 45 : 25,
                              borderColor: Colors.yellow,
                              borderWidth: 2,
                              isOnlyText: false,
                              avatarType: AvatarType.CIRCLE,
                              backgroundColor: Colors.red,
                              imagePath: "assets/android/${page.toString()}",
                              placeHolder: Icon(Icons.person, size: 50),
                              errorWidget: Container(
                                child: Icon(
                                  Icons.error,
                                  size: 50,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
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
}
