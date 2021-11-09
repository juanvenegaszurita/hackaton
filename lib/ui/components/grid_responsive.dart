import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: slash_for_doc_comments
/**
  desktop >= 1200
  tablet => 600 && <= 1199
  phone => 300 && <= 599
  whatch >= 0 && <= 299
*/
enum _GridTier { xs, sm, md, lg, xl }

class GridResponsive extends GetResponsiveView {
  GridResponsive({
    required this.children,
    this.xl = 4,
    this.lg = 3,
    this.md = 2,
    this.sm = 1,
    this.xs = 1,
    this.border = false,
    this.paddingBottom: 0,
    this.paddingLeft: 0,
    this.paddingRight: 0,
    this.paddingTop: 0,
  });

  final List<Widget> children;
  final int xl;
  final int lg;
  final int md;
  final int sm;
  final int xs;
  final bool border;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;

  @override
  Widget builder() {
    double screenWidth = screen.isDesktop ? 1200 : screen.width;
    _GridTier talla = _getGridTier(screenWidth);
    int rowSegments;
    switch (talla) {
      case _GridTier.xl:
        rowSegments = xl;
        break;
      case _GridTier.lg:
        rowSegments = lg;
        break;
      case _GridTier.md:
        rowSegments = md;
        break;
      case _GridTier.sm:
        rowSegments = sm;
        break;
      case _GridTier.xs:
        rowSegments = xs;
        break;
    }
    double width = (screenWidth - 25) / rowSegments;
    int cantColumn = (children.length ~/ rowSegments).toInt();
    int restoColumn = (children.length % rowSegments).toInt();
    cantColumn = (cantColumn < 1 ? 1 : cantColumn) + (restoColumn == 0 ? 0 : 1);
    return Column(
      children: List.generate(
        cantColumn,
        (indexC) => Row(
          children: List.generate(
            rowSegments,
            (indexR) => Container(
              decoration: border
                  ? BoxDecoration(border: Border.all(color: Colors.black))
                  : BoxDecoration(),
              padding: EdgeInsets.only(
                bottom: paddingBottom,
                left: paddingLeft,
                right: paddingRight,
                top: paddingTop,
              ),
              width: width,
              child: child(children, ((indexC * rowSegments) + indexR)),
            ),
          ),
        ),
      ),
    );
  }

  Widget child(List<Widget> child, int index) {
    bool existe = index < child.length;
    return existe ? child[index] : Container();
  }

  _GridTier _getGridTier(double width) {
    if (width < 300) {
      return _GridTier.xs;
    } else if (width < 600) {
      return _GridTier.sm;
    } else if (width < 900) {
      return _GridTier.md;
    } else if (width < 1200) {
      return _GridTier.lg;
    } else {
      // width >= 1200
      return _GridTier.xl;
    }
  }
}
