module Implode

import Parser;
import Syntax;
import AST;
import ParseTree;
import IO;

public data ParseResult = ok(AST::Program p) | err(str msg);

public ParseResult parseAndImplodeFile(loc file) {
  try {
    Tree t = Parser::parseProgramFromFile(file);
    // intenta implode automático: si las etiquetas concuerdan, esto produce AST.Program
    Program p = implode(#Program, t);
    return ok(p);
  } catch (ParseError pe) {
    return err("Parse error: <" + toString(pe) + ">");
  } catch (Exception e) {
    return err("Implode/error general: <" + toString(e) + ">");
  }
}

public void printASTFromFile(loc file) {
  switch(parseAndImplodeFile(file)) {
    case ok(p): println(p); break;
    case err(m): println("ERROR: " + m); break;
  }
}
