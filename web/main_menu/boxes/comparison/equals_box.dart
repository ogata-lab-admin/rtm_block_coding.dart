part of boxes;

@PolymerRegister('equals-box')
class EqualsBox extends ComparisonBox {

  program.Equals _model;

  String leftLabel;
  String rightLabel;

  static EqualsBox createBox(program.Equals m) {
    return new html.Element.tag('equals-box') as EqualsBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  set model(program.Equals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  EqualsBox.created() : super.created();

}

