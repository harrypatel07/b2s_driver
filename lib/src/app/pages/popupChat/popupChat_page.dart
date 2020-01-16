import 'package:animator/animator.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/popupChat/popupChat_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopupChatPage extends StatefulWidget {
  static const String routeName = '/popupChat';
  final bool isShowPopupChat;

  const PopupChatPage({Key key, this.isShowPopupChat}) : super(key: key);
  @override
  _PopupChatPageState createState() => _PopupChatPageState();
}

class _PopupChatPageState extends State<PopupChatPage> {
  @override
  Widget build(BuildContext context) {
    return PopupChatHomePage();
  }
}

class PopupChatHomePage extends StatefulWidget {
  @override
  _PopupChatHomePageState createState() => _PopupChatHomePageState();
}

class _PopupChatHomePageState extends State<PopupChatHomePage>
    with SingleTickerProviderStateMixin {
  PopupChatViewModel viewModel = PopupChatViewModel();

  @override
  void initState() {
//    viewModel.listenData();
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      pos = initPosition();
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    if (viewModel.listChat.length == 0)
//      viewModel.listenData();
    Widget _circleAvatar(ModelChatPopup modelChatPopup) {
      return (modelChatPopup.chatting.avatarUrl != null)
          ? Stack(
              children: <Widget>[
                (modelChatPopup.chatting.avatarUrl == null ||
                        modelChatPopup.chatting.avatarUrl is bool)
                    ? Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      )
                    : CachedNetworkImage(
                        imageUrl: modelChatPopup.chatting.avatarUrl,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 32.5,
                          backgroundImage: imageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                if (modelChatPopup.countMessage > 0)
                  Positioned(
                    top: 5,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Text(
                        modelChatPopup.countMessage.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            )
          : Container(
              color: Colors.transparent,
            );
    }

    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Stack(
              children: <Widget>[
                if (viewModel.listChat.length > 0 &&
                    viewModel.showPopup &&
                    viewModel.showPopupBaseScreen &&
                    viewModel.flowDrag)
                  Positioned(
                    top: viewModel.positionDraggable.dy,
                    left: viewModel.positionDraggable.dx,
                    child: Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10.0,
                        ),
                      ], color: Colors.white, shape: BoxShape.circle),
                      child: _circleAvatar(viewModel.modelChatPopupShow),
                    ),
                  ),
                if (viewModel.listChat.length > 0 &&
                    viewModel.showPopup &&
                    viewModel.showPopupBaseScreen &&
                    !viewModel.flowDrag &&
                    (viewModel.inTargetRemove || viewModel.isRemoveCancel))
                  Animator(
                    statusListener: ((_, __) {
                      if (_.index == 3)
                        viewModel.positionItemShow = Offset(
                            viewModel.positionDraggable.dx,
                            viewModel.positionDraggable.dy);
                    }),
                    curve: Curves.easeInOutBack,
                    tween: Tween<Offset>(
                        begin: (viewModel.isRemoveCancel)
                            ? viewModel.positionItemShow
                            : viewModel.positionDraggable,
                        end: (viewModel.isRemoveCancel)
                            ? viewModel.positionDraggable
                            : Offset(
                                MediaQuery.of(context).size.width / 2 - 65 / 2,
                                MediaQuery.of(context).size.height - 50 - 89)),
                    duration: Duration(milliseconds: 300),
                    cycles: 1,
                    builder: (anim) {
                      return Transform.translate(
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle),
                            child: _circleAvatar(viewModel.modelChatPopupShow),
                          ),
                          offset: anim.value);
                    },
                  ),
                if (viewModel.listChat.length > 0 &&
                    viewModel.showPopup &&
                    viewModel.showPopupBaseScreen)
                  Positioned(
                    top: viewModel.positionDraggable.dy,
                    left: viewModel.positionDraggable.dx,
                    child: Draggable(
                        onDragCompleted: () {
                          print('complete');
                        },
                        onDragStarted: () {
                          viewModel.onDragStarted();
                        },
                        onDragEnd: (_) {
                          print('End');
                        },
                        feedback: Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                        ),
                        childWhenDragging: Container(),
                        onDraggableCanceled: (view, offset) {
                          viewModel.onDraggableCanceled();
                        },
                        child: Listener(
                          onPointerDown: (PointerDownEvent event) {
                            viewModel.onPointerDown(event);
                          },
                          onPointerMove: (PointerMoveEvent event) {
                            viewModel.onPointerMove(event);
                          },
                          child: GestureDetector(
                            onTap: () {
                              viewModel.onTapFloatButton();
                            },
                            child: viewModel.showCircleRemove
                                ? Container()
                                : Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                  ),
                          ),
                        )),
                  ),
                if (viewModel.showCircleRemove)
                  Animator(
                    curve: Curves.easeInOutBack,
                    tween: Tween<Offset>(
                        begin: Offset(
                            MediaQuery.of(context).size.width * 0.5 - 40,
                            MediaQuery.of(context).size.height),
                        end: Offset(
                            MediaQuery.of(context).size.width * 0.5 - 40,
                            MediaQuery.of(context).size.height - 146)),
                    duration: Duration(milliseconds: 700),
                    cycles: 1,
                    builder: (anim) {
                      return Transform.translate(
                          child: Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black54, width: 3),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black54,
                            ),
                          ),
                          offset: anim.value);
                    },
                  ),
              ],
            ));
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return SafeArea(
            child: Overlay(
              initialEntries: [overlayEntry],
            ),
          );
        },
      ),
    );
  }
}
