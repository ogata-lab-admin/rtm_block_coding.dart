library programbuilder;

import '../scripts/application.dart';
import 'controller.dart';

class ProgramBuilder {


  ProgramBuilder() {}


  void addToApp(Statement s) {
    Application app = globalController.selectedApp;
    if (globalController.selectedBox == null) {
      app.statements.add(s);
    } else if (globalController.selectedBox.model.is_container()) {
      globalController.selectedBox.model.statements.add(s);
    } else {
      app.statements.add(s);
    }

  }

  void build(String command) {

    Application onInit = globalController.onInitializeApp;
//  rtm_menu
    if(command == 'AddInPort') {
      addToApp(new Statement(new AddInPort.fromAppDefault(onInit)));
    }

    if(command == 'AddOutPort') {
      addToApp(new Statement(new AddOutPort.fromAppDefault(onInit)));
    }

    if (command == 'DeclareVariable') {
      addToApp(new Statement(new DeclareVariable.fromAppDefault(onInit)));
    }

    if (command == 'Assign') {
      addToApp(new Statement(new Assign.fromAppDefault(onInit)));

    }

    if (command == 'ReadInPort') {
      addToApp(new Statement(new ReadInPort.fromAppDefault(onInit)));
    }

    if (command == 'If') {
      addToApp(new Statement(new If.fromAppDefault(onInit)));
    }

  }


}






