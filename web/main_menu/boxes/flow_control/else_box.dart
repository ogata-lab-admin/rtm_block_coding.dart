part of boxes;

@PolymerRegister('else-box')
class ElseBox extends BoxBase {

  static ElseBox createBox(program.Else m) {
    return new html.Element.tag('else-box') as ElseBox
      ..model = m
        ..attachStatements(m);
  }

  get alternative => $['alternative-content'];

  ElseBox.created() : super.created();

  void attachStatements(program.Else m) {
    for(program.Statement s in m.statements) {
      var e = BoxFactory.parseBlock(s.block);
      $$('#body-content').children.add(e);
      e.parentElement = this;
    }
  }

}

