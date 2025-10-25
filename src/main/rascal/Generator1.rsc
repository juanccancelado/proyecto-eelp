module Generator1

import IO;
import Set;
import List;
import AST;
import Syntax;
import String;

import Parser;
import Implode;

//data GenTask = genTask(str action = "", int prio = 0, str duration = "");
//list[str] allPersons = []; // normally do not do this
//list[GenTask] allPlans = [];

void main() {
    cast = parsePlanning(|project://rascaldsl/instance/spec1.tdsl|);
    rVal = generator1(cast);
    println(rVal);
    writeFile(|project://rascaldsl/instance/output/generator1.txt|, rVal);
}

list[str] allFunctions = [];
list[str] allData = [];

void main() {
    // Cambia la ruta según tu proyecto o archivo fuente TDSL
    loc src = |project://rascaldsl/instance/example.tdsl|;
    str code = readFile(src);

    tree = parse(#start[Program], code);
    ast = implode(tree);

    str output = generator(ast);

    println(output);
    writeFile(|project://rascaldsl/instance/output/output.txt|, output);
}

str generator(Program p) {
    allFunctions = [];
    allData = [];

    generateProgram(p);

    return "=== MODULE REPORT ===\n"
         + "Functions:\n"
         + (isEmpty(allFunctions) ? "  (none)" : intercalate("\n", allFunctions))
         + "\n\nData definitions:\n"
         + (isEmpty(allData) ? "  (none)" : intercalate("\n", allData))
         + "\n=====================\n";
}

void generateProgram(Program p) {
    for (m <- p.modules) {
        generateModule(m);
    }
}

void generateModule(ModuleDecl m) {
    if (m.moduleFunc?) {
        f = m.functionDef;
        allFunctions += "Function <f.name>(<intercalate(\", \", f.params)>)";
    }
    if (m.moduleData?) {
        d = m.dataDef;
        allData += "Data <d.name> with fields: <intercalate(\", \", d.fields)> "
                 + "and <size(d.methods)> methods";
    }
}

// ===== UTILIDADES =====

str showExpr(Expr e) {
    switch (e) {
        case literal(l): return showLiteral(l);
        case var(n): return n;
        case call(f, args): return "<f>(<intercalate(\", \", [showExpr(a) | a <- args])>)";
        case dollarCall(f, args): return "<f>$(<intercalate(\", \", [showExpr(a) | a <- args])>)";
        case dot(l, f): return "<showExpr(l)>.<f>";
        case binOp(l, op, r): return "<showExpr(l)> <showOp(op)> <showExpr(r)>";
        case neg(x): return "-<showExpr(x)>";
        case tupleExpr(es): return "(<intercalate(\", \", [showExpr(e) | e <- es])>)";
        case listExpr(es): return "[<intercalate(\", \", [showExpr(e) | e <- es])>]";
        default: return "<???>";
    }
}

str showLiteral(Literal l) {
    switch (l) {
        case number(n): return n;
        case string(s): return "\"<s>\"";
        case boolTrue(): return "true";
        case boolFalse(): return "false";
    }
}

str showOp(Op o) {
    switch (o) {
        case add(): return "+";
        case sub(): return "-";
        case mul(): return "*";
        case div(): return "/";
        case mod(): return "%";
        case pow(): return "**";
        case lt(): return "<";
        case gt(): return ">";
        case le(): return "<=";
        case ge(): return ">=";
        case eq(): return "=";
        case ne(): return "<>";
        case and(): return "and";
        case or(): return "or";
    }
}
