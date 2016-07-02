part of boxes;

@PolymerRegister('while-box')
class WhileBox extends BoxBase {

  static WhileBox createBox(program.While m) {
    return new html.Element.tag('while-box') as WhileBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition))
      ..attachStatements(m);;
  }

  WhileBox.created() : super.created();

  void attachCondition(var e) {
    $$('#condition-content').children.clear();
    $$('#condition-content').children.add(e);
    e.parentElement = this;
  }

  void attachStatements(program.While m) {
    for(program.Statement s in m.statements) {
      var e = BoxFactory.parseBlock(s.block);
      $$('#body-content').children.add(e);
      e.parentElement = this;
    }
  }

}

