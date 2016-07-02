part of boxes;

// @PolymerRegister('box-base')
class BoxBase extends PolymerElement {
  PolymerElement parentElement;

  program.Block _model;
//とりあえずvar型にしてあるけどあまりよくない

  set model(program.Block m) {
    _model = m;
  }

  program.Block get model => _model;

  BoxBase.created() : super.created();

  @reflectable
  void onClicked(var e, var d) {
    print('AddPortBox.onClicked($e, $d)');
    globalController.setSelectedBox(this);
    e.stopPropagation();
  }

  void select() {
    $$('#container').style.border = 'ridge';
    $$('#container').style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $$('#container').style.border = '1px solid #B6B6B6';
  }
}