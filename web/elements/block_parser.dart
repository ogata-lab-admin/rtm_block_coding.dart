library block_parser;


import 'package:rtm_block_coding/application.dart' as program;
import 'block_parser_impl.dart';

abstract class BlockParser {


  static parseBlock(program.Block block) {
    return new BlockParserImpl().parseBlock(block);
  }

  static parseStatement(var children, program.Statement s) {
    return new BlockParserImpl().parseStatement(children, s);
  }

}