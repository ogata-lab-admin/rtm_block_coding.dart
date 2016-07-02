library programbuilder;

import '../scripts/application.dart';

class ProgramBuilder {


  ProgramBuilder() {}


  void addToApp(Application selectedApp, Block selectedBlock, Block b) {
    var s = new Statement(b);


    if (selectedBlock == null) {
      if (!(b is BasicLiteral) && !(b is VariableBlock)) {
        selectedApp.statements.add(s);
      }
      return;
    } else if (selectedBlock.parent is ConditionalFlowControl) {
      if (selectedBlock.parent.isCondition(selectedBlock)) {
        selectedBlock.parent.condition = b;
        return;
      }
    }

    if (selectedBlock is ContainerBlock) {
      selectedBlock.statements.add(s);
    } else if (selectedBlock.parent is BasicOperator) {
      if (selectedBlock.parent.isLeft(selectedBlock)) {
        selectedBlock.parent.left = b;
      } else {
        selectedBlock.parent.right = b;
      }
    } else {
      selectedApp.statements.add(s);
    }
  }

  void build(Model model, Application selectedApp, Block selectedBlock, String command) {
    print('ProgramBuilder.build($command)');

    addToApp(selectedApp, selectedBlock, model.createBlock(command));
  }


}






