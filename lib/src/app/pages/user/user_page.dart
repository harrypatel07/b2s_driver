import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/user/user_page_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserPage extends StatefulWidget {
  static const String routeName = "/user";
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserPageViewModel viewModel = UserPageViewModel();
  GlobalKey _key = GlobalKey();
  Size _size = Size(0,0);
  _getSize() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    _size = renderBox.size;
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      _getSize();
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
//    TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
//    viewModel = tabsPageViewModel.userPageViewModel;
    viewModel.context = context;
    final hr = new Container(
      height: 1,
      color: Colors.grey.shade200,
    );
//    Widget _buildChatTitle(IconData icon, Color color, String title) {
//      return new Column(
//        children: <Widget>[
//          new ListTile(
//              title: Text(
//                title,
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              leading: Container(
//                height: 30.0,
//                width: 30.0,
//                decoration: BoxDecoration(
//                  color: color,
//                  borderRadius: BorderRadius.circular(10.0),
//                ),
//                child: Center(
//                  child: Icon(
//                    icon,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//              trailing: Icon(LineIcons.chevron_circle_right),
//              onTap: () {
//                viewModel.onTapMessage();
//              }),
//        ],
//      );
//    }

    Widget _builtUserTitle({IconData icon, Color color, String title, Function onTap}) {
      return new Column(
        children: <Widget>[
          new ListTile(
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
              trailing: Icon(LineIcons.chevron_circle_right),
              onTap: onTap),
        ],
      );
    }
    Widget secondCard() {
      return Padding(
        padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(8.0),
          shadowColor: Colors.white,
          child: Container(
            //height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                _builtUserTitle(icon:Icons.person_pin,color:ThemePrimary.primaryColor,title:"Tin nhắn",onTap:()=>viewModel.onTapMessage()),
                hr,
                _builtUserTitle(icon:Icons.history, color:ThemePrimary.primaryColor, title:'Lịch sử',onTap: ()=>viewModel.onTapHistoryTrip()),
                hr,
                _builtUserTitle(icon:Icons.exit_to_app,color:ThemePrimary.primaryColor,title:"Đăng xuất",onTap: ()=>viewModel.onTapLogout()),
              ],
            ),
          ),
        ),
      );
    }

    final userImage = CachedNetworkImage(
      imageUrl: viewModel.driver.photo,
      imageBuilder: (context, imageProvider) => Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(
              image: imageProvider,
              // MemoryImage(viewModel.parent.photo)
              fit: BoxFit.cover),
          shape: BoxShape.circle,
        ),
      ),
    );

    final userName = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Text(
              viewModel.driver.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    final userInfo = Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8.0),
            shadowColor: Colors.white,
            child: InkWell(
              onTap: () {
                viewModel.onTapDriver();
              },
              child: Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 20.0, top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: userImage,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 180,
                          child: userName,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      key: _key,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 250.0,
                              ),
                              Container(
                                height: 150.0,
                                decoration: BoxDecoration(
                                    gradient: ThemePrimary.primaryGradient),
                              ),
                              Positioned(
                                  top: 50, right: 0, left: 0, child: userInfo)
                            ],
                          ),
                          secondCard(),
                        ],
                      ),
                    ),
                    if(_size.height >= MediaQuery.of(context).size.height)
                      Container(
                        height: 50,
                        child: Center(
                          child: Text("version $version"),
                        ),
                      )
                    else Column(
                      children: <Widget>[
                        SizedBox( height:  MediaQuery.of(context).size.height - _size.height - 120,),
                        Container(
                          height: 50,
                          child: Center(
                            child: Text("version $version"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
