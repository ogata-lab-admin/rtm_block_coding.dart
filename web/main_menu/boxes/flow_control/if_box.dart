//library if_box;


part of boxes;


@PolymerRegister('if-box')
class IfBox extends BoxBase {

  static IfBox createBox(program.If m) {
    return new html.Element.tag('if-box') as IfBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition))
      ..attachStatements(m);
  }

  get consequent => $['consequent-content'];

  IfBox.created() : super.created();

  void attachCondition(var e) {
    $$('#condition-content').children.clear();
    $$('#condition-content').children.add(e);
    e.parentElement = this;
  }

  void attachStatements(program.If m) {
    for(program.Statement s in m.statements) {
      var e = BoxFactory.parseBlock(s.block);
      $$('#body-content').children.add(e);
      e.parentElement = this;
    }
  }
}

