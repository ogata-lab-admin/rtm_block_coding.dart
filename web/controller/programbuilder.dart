library programbuilder;

import '../scripts/application.dart';
import 'controller.dart';

class ProgramBuilder {


  ProgramBuilder() {}


  void addToApp(Block b) {
    Application app = globalController.selectedApp;
    var s = new Statement(b);
    if (b is Condition) {
      if (globalController.selectedBox == null) {
        return;
      }

      if(globalController.selectedBox.model.parent is ConditionalFlowControl) {
        globalController.selectedBox.model.parent.condition = b;
      }
    } else {
      if (globalController.selectedBox == null) {
        app.statements.add(s);
      } else if (globalController.selectedBox.model is ContainerBlock) {
        globalController.selectedBox.model.statements.add(s);
      } else if (globalController.selectedBox.model.parent is BasicOperator) {
        if (globalController.selectedBox.model.parent.isLeft(globalController.selectedBox.model)) {
          globalController.selectedBox.model.parent.left = b;
        } else {
          globalController.selectedBox.model.parent.right = b;
        }
      } else {
        app.statements.add(s);
      }
    }
  }

  void build(String command) {
    print('ProgramBuilder.build($command)');
    Application onInit = globalController.onInitializeApp;
//  rtm_menu
    if(command == 'AddInPort') {
      addToApp((new AddInPort.fromAppDefault(onInit)));
    } else if(command == 'AddOutPort') {
      addToApp((new AddOutPort.fromAppDefault(onInit)));
    } else if (command == 'DeclareVariable') {
      addToApp((new DeclareVariable.fromAppDefault(onInit)));
    } else if (command == 'ReferVariable') {
      addToApp((new ReferVariable.fromAppDefault(onInit)));
    } else if (command == 'Assign') {
      addToApp((new Assign.fromAppDefault(onInit)));
    } else if (command == 'ReadInPort') {
      addToApp((new ReadInPort.fromAppDefault(onInit)));
    } else if (command == 'IsNewInPort') {
      addToApp((new IsNewInPort.fromAppDefault(onInit)));
    } else if (command == 'If') {
      addToApp((new If.fromAppDefault(onInit)));
    } else if (command == 'OutPortBuffer') {
      addToApp((new OutPortBuffer.fromAppDefault(onInit)));
    } else if (command == 'InPortBuffer') {
      addToApp((new InPortBuffer.fromAppDefault(onInit)));
    } else if (command == 'WriteOutPort') {
      addToApp((new WriteOutPort.fromAppDefault(onInit)));
    }


    else {
      print('Invalid Name $command');
    }
  }


}






