import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:flutter/material.dart';

typedef CallbackSendMessageEmergency = void Function(String mgs);

class PopupEmergencyWidget extends StatefulWidget {
  final CallbackSendMessageEmergency onTap;

  const PopupEmergencyWidget({Key key, this.onTap}) : super(key: key);
  @override
  _PopupEmergencyWidgetState createState() => _PopupEmergencyWidgetState();
}

class _PopupEmergencyWidgetState extends State<PopupEmergencyWidget> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ThemePrimary.primaryColor,
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                height: 350,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'MÔ TẢ SỰ CỐ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
//                          scrollPhysics: NeverScrollableScrollPhysics(),
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập nội dung...',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines:
                                      null //viewModel.listAttachmentModel.length > 0 ? 3 : 7,
                                  ),
                            ),
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius:
                                          2.0, // has the effect of softening the shadow
                                      spreadRadius:
                                          1.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        2.0, // horizontal, move right 10
                                        2.0, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                  color: textEditingController.text != ''
                                      ? ThemePrimary.primaryColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          25.0) //         <--- border radius here
                                      ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    onTap: () {
                                      widget.onTap(textEditingController.text);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                25.0) //         <--- border radius here
                                            ),
                                      ),
                                      child: Text(
                                        'Gửi thông tin cấp cứu',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
//                    Container(height: 10,color: Colors.white,)
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
