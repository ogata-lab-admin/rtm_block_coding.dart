part of boxes;

@PolymerRegister('box-container')
class BoxContainer extends PolymerElement {
  BoxContainer.created() : super.created();

  @reflectable
  void onClicked(var e, var d) {
    (parent as BoxBase).onClicked(e, d);
  }

  void select() {
    $$('#container').style.border = 'ridge';
    $$('#container').style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $$('#container').style.border = '1px solid #B6B6B6';
  }

}

@PolymerRegister('container-box-container')
class ContainerBoxContainer extends PolymerElement {
  ContainerBoxContainer.created() : super.created();

  @reflectable
  void onClicked(var e, var d) {
    (parent as BoxBase).onClicked(e, d);
  }

  void select() {
    $$('#container').style.border = 'ridge';
    $$('#container').style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $$('#container').style.border = '1px solid #B6B6B6';
  }

}