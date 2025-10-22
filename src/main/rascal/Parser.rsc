module Parser

import ParseTree;
import IO;
import Syntax;
import lang::rascal::syntax::Concrete; // utilidades de parsing

public Tree parseProgramFromString(str src, loc origin) {
  // parse devuelve un Tree (parse tree)
  return parse(#start[Program], src, origin);
}

public Tree parseProgramFromFile(loc file) {
  str src = readFile(file);
  return parseProgramFromString(src, file);
}

// función de prueba para imprimir el Tree en consola (estructura legible)
public void printParseTreeFromFile(loc file) {
  Tree t = parseProgramFromFile(file);
  println(t);
}
