
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/pages/message/ContactsPage/contacts_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/listview_Animator.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  static const String routeName = "/message";
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  MessagePageViewModel viewModel = MessagePageViewModel();
  @override
  initState() {
    viewModel.listenData();
    super.initState();
  }

  Widget appBar() {
//    return SearchBar(
//      iconified: true,
//      controller: viewModel.searchBarController,
//      defaultBar: AppBar(
//        title: new Text("Message"),
//        leading: IconButton(icon: Icon(Icons.arrow_back),
//          onPressed: ()=>Navigator.pop(context),
//        ),
//      ),
//      searchHint: 'Tìm kiếm...',
//      loader: QuerySetLoader<Contacts>(
//        querySetCall: viewModel.onQueryChanged,
//        itemBuilder: buildContactsRow,
//        loadOnEachChange: true,
//        animateChanges: true,
//      ),
//    );
    return TS24AppBar(
      title: new Text("Tin nhắn"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pushNamed(context, ContactsPage.routeName).then((_) {
              viewModel.listenData();
            });
          },
        )
      ],
    );
  }

  Widget body() {
    Widget _buildMessageRow(Chatting chatting) {
      return Column(
        children: <Widget>[
          Divider(
            height: 12.0,
          ),
          ListTile(
            onTap: () {
              viewModel.onItemClick(chatting);
            },
            leading: InkWell(
              onTap: () {
                viewModel.onTapProfileMessageUser(int.parse(chatting.peerId));
              },
              child: Hero(
                tag: chatting.peerId.toString(),
                child: CachedNetworkImage(
                  imageUrl: chatting.avatarUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 24.0,
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                //     CircleAvatar(
                //   radius: 24.0,
                //   backgroundImage: MemoryImage(chatting.avatarUrl),
                //   backgroundColor: Colors.transparent,
                // ),
              ),
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(chatting.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                // SizedBox(
                //   width: 16.0,
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      chatting.datetime,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              chatting.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.0,
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.listenData();
      },
      child: (viewModel.loadingDataMessage)
          ? LoadingSpinner.loadingView(
              context: viewModel.context,
              loading: (viewModel.loadingDataMessage))
          : (viewModel.listChat.length > 0)? ListView.builder(
              //padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              itemCount: viewModel.listChat.length,
              itemBuilder: (context, index) {
                var _model = viewModel.listChat[index];
                return WidgetANimator(_buildMessageRow(_model));
              },
            ):Container(child: Center(child: Text('Không có tin nhắn.'),),),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return new TS24Scaffold(
              appBar: appBar(),
              body: body(),
            );
          }),
    );
  }
}
