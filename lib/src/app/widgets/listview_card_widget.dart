import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:flutter/material.dart';

class ListViewCard extends StatefulWidget {
  final Function onTap;
  final bool isShowTime;
  final int index;
  final Key key;
  final List<RouteBus> listItems;

  ListViewCard(this.listItems, this.index, this.key,{this.onTap,this.isShowTime});

  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        onTap: (){
          try{
            widget.onTap();
          }catch(e){}
        },
        splashColor: ThemePrimary.primaryColor,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 28,
                      color: (widget.listItems[widget.index].status)?Colors.grey: ThemePrimary.primaryColor,
                    ),
                    Container(
//                           color: Colors.yellow,
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      child: Text(
                        (widget.index+1).toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color:(widget.listItems[widget.index].status)?Colors.grey: ThemePrimary.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.listItems[widget.index].routeName}',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: (widget.listItems[widget.index].status)?Colors.grey:Colors.black),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
//                  Container(
//                    padding: const EdgeInsets.all(8.0),
//                    alignment: Alignment.topLeft,
//                    child: Text(
//                      'Description ${widget.listItems[widget.index].routeName}',
//                      style: TextStyle(
//                          fontWeight: FontWeight.normal, fontSize: 16),
//                      textAlign: TextAlign.left,
//                      maxLines: 5,
//                    ),
//                  ),
                  ],
                ),
              ),
              (widget.isShowTime!=null)?
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                 child: Row(
                   children: <Widget>[
                     Icon(Icons.access_time,color: Colors.grey,),
                     SizedBox(width: 5,),
                     Text('${Common.removeMiliSecond(widget.listItems[widget.index].time)}')
                   ],
                 ),
               )
              :Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  Icons.reorder,
                  color: Colors.grey,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}