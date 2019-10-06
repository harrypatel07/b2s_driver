
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BusHomeContainer extends StatelessWidget {
  const BusHomeContainer({
    Key key,
    @required this.children,
    this.height,
    this.decoration,
    this.appBar = false,
  }) : super(key: key);

  final bool appBar;
  final List<Widget> children;
  final Decoration decoration;
  final double height;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final pokeSize = screenSize.width * 1;
    final pokeTop = -(screenSize.width * 0.154);
    // final pokeRight = -(screenSize.width * .1);
    final appBarTop = pokeSize / 2 + pokeTop - IconTheme.of(context).size / 2;

    return Container(
      width: screenSize.width,
      decoration: decoration,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BoxShadowPainter(),
            child: ClipPath(
              clipper: BusHomeContainerClipPath(),
              child: Container(
                height: 340,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xfffffad9), Color(0xfffffce3)],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 30,
          //   left: 10,
          //   child: Image.asset(
          //     "assets/images/bus_bg.gif",
          //     // width: pokeSize,
          //     width: 200,
          //     // color: Color(0xFF303943).withOpacity(0.05),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (appBar)
                  Padding(
                    padding:
                        EdgeInsets.only(left: 26, right: 26, top: appBarTop),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.arrow_back),
                          onTap: Navigator.of(context).pop,
                        ),
                        Icon(Icons.menu),
                      ],
                    ),
                  ),
                if (children != null) ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusHomeContainerClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // final Path path = Path();
    // path.lineTo(0.0, size.height);

    // path.lineTo(size.width, 0);
    // path.lineTo(0.0, size.height);
    // var firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    // var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);
    // path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);

    // var secondEndPoint = Offset(size.width, size.height - 80.0);
    // var secondControlPoint = Offset(size.width * .75, size.height - 10);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);
    // path.lineTo(size.width, 0.0);
    // path.close();
    // return path;

    final Path path = Path();
    path.lineTo(0.0, size.height / 1.5);

    var firstEndPoint = Offset(size.width, size.height / 1.5);
    var firstControlPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = BusHomeContainerClipPath().getClip(size);
    canvas.drawShadow(path, Color(0xfffffad9), 10.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
