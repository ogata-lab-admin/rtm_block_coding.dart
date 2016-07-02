part of boxes;

class ComparisonBox extends BoxBase {

  ComparisonBox.created() : super.created();

  void attachLeft(var e) {
    $['left-content'].children.clear();
    $['left-content'].children.add(e);
    e.parentElement = this;
  }

  void attachRight(var e) {
    $['right-content'].children.clear();
    $['right-content'].children.add(e);
    e.parentElement = this;
  }
}

