part of boxes;

// @PolymerRegister('box-base')
class BoxBase extends PolymerElement {
  PolymerElement parentElement;

  program.Block _model;

  set model(program.Block m) {
    _model = m;
  }

  program.Block get model => _model;

  BoxBase.created() : super.created();

  @reflectable
  void onClicked(var e, var d) {
    print('BoxBase.onClicked($e, $d)');
    globalController.setSelectedBox(this);
    e.stopPropagation();
  }

  void select() {
    if ($$('box-container') != null) {
      ($$('box-container') as BoxContainer).select();
    } else {
      ($$('container-box-container') as ContainerBoxContainer).select();
    }

  }

  void deselect() {
    if ($$('box-container') != null) {
      ($$('box-container') as BoxContainer).deselect();
    } else {
      ($$('container-box-container') as ContainerBoxContainer).deselect();
    }
  }
}