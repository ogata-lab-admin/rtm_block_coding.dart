part of boxes;

@PolymerRegister('notequals-box')
class NotEqualsBox extends ComparisonBox {


  static NotEqualsBox createBox(program.NotEquals m) {
    return new html.Element.tag('notequals-box') as NotEqualsBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  NotEqualsBox.created() : super.created();

}

