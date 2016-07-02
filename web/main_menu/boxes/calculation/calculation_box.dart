part of boxes;


class CalculationBox extends BoxBase {

  CalculationBox.created() : super.created();

  void attachLeft(var e) {
    $$('#value-left-content').children.clear();
    $$('#value-left-content').children.add(e);
    e.parentElement = this;
  }

  void attachRight(var e) {
    $$('#value-right-content').children.clear();
    $$('#value-right-content').children.add(e);
    e.parentElement = this;
  }
}