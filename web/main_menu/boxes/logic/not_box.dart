part of boxes;

@PolymerRegister('not-box')
class NotBox extends BoxBase {

  static NotBox createBox(program.Not m) {
    return new html.Element.tag('not-box') as NotBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition));
  }

  NotBox.created() : super.created();

  void attachCondition(var e) {
    $$("#condition-content").children.clear();
    $$("#condition-content").children.add(e);
    e.parentElement = this;
  }
}

