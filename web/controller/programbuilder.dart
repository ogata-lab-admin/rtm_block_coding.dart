library programbuilder;

import '../scripts/application.dart';
import 'controller.dart';

class ProgramBuilder {


  ProgramBuilder() {}


  void build(String command) {
    Application app = globalController.selectedApp;

    Application onInit = globalController.onInitializeApp;
//  rtm_menu
    if(command == 'AddInPort') {
      app.statements.add(new Statement(new AddInPort.fromAppDefault(onInit)));
    }

    if(command == 'AddOutPort') {
      app.statements.add(new Statement(new AddOutPort.fromAppDefault(onInit)));
    }

    if (command == 'DeclareVariable') {
      app.statements.add(new Statement(new DeclareVariable.fromAppDefault(onInit)));
    }

    if (command == 'Assign') {
      Statement new_s = new Statement(new Assign.fromAppDefault(onInit));
      if (globalController.selectedBox == null) {
        app.statements.add(new_s);
      } else if (globalController.selectedBox.model.is_container()) {
        globalController.selectedBox.model.statements.add(new_s);
      } else {
        app.statements.add(new_s);
      }
    }

  }


}






