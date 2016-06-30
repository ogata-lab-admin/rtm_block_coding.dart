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
    }

    else {
      if (globalController.selectedBox == null) {
        app.statements.add(s);
      } else if (globalController.selectedBox.model.is_container()) {
        globalController.selectedBox.model.statements.add(s);
      } else {
        app.statements.add(s);
      }
    }
  }

  void build(String command) {

    Application onInit = globalController.onInitializeApp;
//  rtm_menu
    if(command == 'AddInPort') {
      addToApp((new AddInPort.fromAppDefault(onInit)));
    }

    if(command == 'AddOutPort') {
      addToApp((new AddOutPort.fromAppDefault(onInit)));
    }

    if (command == 'DeclareVariable') {
      addToApp((new DeclareVariable.fromAppDefault(onInit)));
    }

    if (command == 'Assign') {
      addToApp((new Assign.fromAppDefault(onInit)));

    }

    if (command == 'ReadInPort') {
      addToApp((new ReadInPort.fromAppDefault(onInit)));
    }

    if (command == 'IsNewInPort') {
      addToApp((new IsNewInPort.fromAppDefault(onInit)));
    }

    if (command == 'If') {
      addToApp((new If.fromAppDefault(onInit)));
    }

  }


}






