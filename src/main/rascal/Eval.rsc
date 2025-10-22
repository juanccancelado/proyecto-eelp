module Eval

import AST;
import IO;
import Implode;

public void runFile(loc file) {
  switch(Implode::parseAndImplodeFile(file)) {
    case ok(prog):
      println("AST obtenido (ejecutar aquí el intérprete):");
      println(prog);
      // Aquí llamarías a evalProgram(prog) cuando implementes el intérprete
      break;
    case err(m):
      println("ERROR parsing/implode: " + m);
      break;
  }
}

// Esqueleto: evaluador básico (irás completando según tipos de Expr)
public value evalExpr(Expr e, map[str, value] env) {
  // value es placeholder: define tus valores concretos (int,bool,tuple,object,...)
  println("evalExpr: implementar lógica para: " + toString(e));
  return null;
}

