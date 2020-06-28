/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

import 'package:flutter/rendering.dart';
import 'package:kraken/rendering.dart';
import 'package:kraken/css.dart';

// CSS Box Alignment: https://drafts.csswg.org/css-align/

mixin CSSFlowMixin {
  void decorateRenderFlow(RenderFlowLayout renderFlowLayout, CSSStyleDeclaration style) {
    Axis axis = Axis.horizontal;
    TextDirection textDirection = TextDirection.ltr;
    VerticalDirection verticalDirection = VerticalDirection.down;

    renderFlowLayout.verticalDirection = verticalDirection;
    renderFlowLayout.direction = axis;
    renderFlowLayout.textDirection = textDirection;
    renderFlowLayout.mainAxisAlignment = _getJustifyContent(style, axis);
    renderFlowLayout.crossAxisAlignment = _getAlignItems(style, axis);
    renderFlowLayout.runAlignment = _getAlignContent(style, axis);
  }

  void decorateAlignment(RenderFlowLayout renderFlowLayout, CSSStyleDeclaration style) {
    renderFlowLayout.mainAxisAlignment = _getJustifyContent(style, Axis.horizontal);
  }

  MainAxisAlignment _getJustifyContent(CSSStyleDeclaration style, Axis axis) {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;

    if (style.contains(TEXT_ALIGN) && axis == Axis.horizontal) {
      String textAlign = style[TEXT_ALIGN];
      switch (textAlign) {
        case 'start':
        case 'left':
          // Use default value: start
          break;
        case 'end':
        case 'right':
          mainAxisAlignment = MainAxisAlignment.end;
          break;
        case 'center':
          mainAxisAlignment = MainAxisAlignment.center;
          break;
        case 'justify-all':
          mainAxisAlignment = MainAxisAlignment.spaceBetween;
          break;
        // Like inherit, which is the same with parent element.
        // Not impl it due to performance consideration.
        // case 'match-parent':
      }
    }

    if (style.contains(JUSTIFY_CONTENT)) {
      String justifyContent = style[JUSTIFY_CONTENT];
      switch (justifyContent) {
        case 'flex-end':
          mainAxisAlignment = MainAxisAlignment.end;
          break;
        case 'center':
          mainAxisAlignment = MainAxisAlignment.center;
          break;
        case 'space-between':
          mainAxisAlignment = MainAxisAlignment.spaceBetween;
          break;
        case 'space-around':
          mainAxisAlignment = MainAxisAlignment.spaceAround;
          break;
      }
    }
    return mainAxisAlignment;
  }

  CrossAxisAlignment _getAlignItems(CSSStyleDeclaration style, Axis axis) {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch;
    if (style.contains(TEXT_ALIGN) && axis == Axis.vertical) {
      String textAlign = style[TEXT_ALIGN];
      switch (textAlign) {
        case 'right':
          crossAxisAlignment = CrossAxisAlignment.end;
          break;
        case 'center':
          crossAxisAlignment = CrossAxisAlignment.center;
          break;
      }
    }
    return crossAxisAlignment;
  }

  MainAxisAlignment _getAlignContent(CSSStyleDeclaration style, Axis axis) {
    // @TODO: add flex-direction column support
    String flexProperty = style[ALIGN_CONTENT];
    MainAxisAlignment runAlignment = MainAxisAlignment.start;
    switch (flexProperty) {
      case 'flex-end':
      case 'end':
        runAlignment = MainAxisAlignment.end;
        break;
      case 'center':
        runAlignment = MainAxisAlignment.center;
        break;
      case 'space-around':
        runAlignment = MainAxisAlignment.spaceAround;
        break;
      case 'space-between':
        runAlignment = MainAxisAlignment.spaceBetween;
        break;
      case 'space-evenly':
        runAlignment = MainAxisAlignment.spaceEvenly;
        break;
    }
    return runAlignment;
  }
}