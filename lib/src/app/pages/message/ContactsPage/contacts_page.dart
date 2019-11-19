
import 'package:b2s_driver/packages/loader_search_bar/loader_search_bar.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/pages/message/ContactsPage/contacts_page_viewmodel.dart';
import 'package:b2s_driver/src/app/widgets/listview_Animator.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  static const String routeName = "/contacts";
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactsPageViewModel viewModel = ContactsPageViewModel();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildContactsRow(Contacts contacts) {
      return Column(
        children: <Widget>[
          Divider(
            height: 12.0,
          ),
          ListTile(
            onTap: () {
              viewModel.onItemContactsClick(contacts);
            },
            leading: CachedNetworkImage(
              imageUrl: contacts.avatarUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 24.0,
                backgroundImage: imageProvider,
                backgroundColor: Colors.transparent,
              ),
            ),
            // CircleAvatar(
            //   radius: 24.0,
            //   backgroundImage: MemoryImage(contacts.avatarUrl),
            //   backgroundColor: Colors.transparent,
            // ),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(contacts.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                // SizedBox(
                //   width: 16.0,
                // ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14.0,
            ),
          ),
        ],
      );
    }

    Widget _body() {
      return RefreshIndicator(
        onRefresh: () async {
          viewModel.initListContacts();
        },
        child: (viewModel.contactsLoading)
            ? LoadingSpinner.loadingView(
                context: viewModel.context,
                loading: (viewModel.contactsLoading))
            : ListView.builder(
                //padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                itemCount: viewModel.listContactsSearchResult.length,
                itemBuilder: (context, index) {
                  var _model = viewModel.listContactsSearchResult[index];
                  return WidgetANimator(buildContactsRow(_model));
                },
              ),
      );
    }

    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: SearchBar(
              iconified: false,
              defaultBar: AppBar(
                title: new Text("Message"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              searchHint: 'Tìm kiếm...',
              onQueryChanged: (query) => viewModel.onQueryChanged(query),
              onQuerySubmitted: (query) => viewModel.onQuerySubmitted(query),
            ),
            body: _body(),
          );
        },
      ),
    );
  }
}
