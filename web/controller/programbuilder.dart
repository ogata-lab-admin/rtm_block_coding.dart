library programbuilder;

import '../scripts/application.dart';
import 'controller.dart';
import 'dart:mirrors';


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


    MirrorSystem mirrors = currentMirrorSystem();
    mirrors.libraries.forEach((var uri, var lib) {
      print ('$uri, $lib');
    });
    LibraryMirror appMirror = mirrors.findLibrary(new Symbol('application'));
    ClassMirror cm = appMirror.declarations[new Symbol(command)];
    addToApp(cm.newInstance(new Symbol('fromAppDefault'), [onInit]).reflectee);

  }


}






