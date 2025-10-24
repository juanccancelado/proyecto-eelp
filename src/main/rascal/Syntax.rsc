module Syntax

layout L = (" " | "\t" | "\r" | "\n")* ;
lexical NL = "\\n" ;

keyword KW = "cond" | "do" | "data" | "elseif" | "end"
           | "for" | "from" | "then" | "function" | "else" | "if" | "in"
           | "iterator" | "sequence" | "struct" | "to" | "tuple" | "type"
           | "with" | "yielding" | "true" | "false" ;

lexical ID     = [a-z] [a-z0-9]* !>> KW ;
lexical NUMBER = [0-9]+ ("." [0-9]+)? ;
lexical STRING = "\"" (!["\n\r" ] )* "\"" ;

start syntax Program = ModuleDecl+ ;


syntax FunctionDef = ID "=" "function" "(" ParamList? ")" "do" NL Block "end" ID ;
syntax DataDef     = ID "=" "data" "with" IDList NL RepDef NL MethodList "end" ID ;
syntax ModuleDecl  = FunctionDef | DataDef ;

syntax ParamList = ID ( "," ID )* ;
syntax IDList    = ID ( "," ID )* ;

syntax RepDef    = ID "=" "struct" "(" FieldList ")" ;
syntax FieldList = ID ( "," ID )* ;
syntax MethodList= FunctionDef ( NL FunctionDef )* ;


syntax Block = ( Statement NL )* ;

syntax Statement
  = ID ( "," ID )*
  | ID "=" Expr
  | IfExpr
  | CondExpr
  | ForStmt
  | Expr
  ;

syntax IfExpr  = "if" Expr "then" NL Block "else" NL Block "end" ;
syntax CondExpr= "cond" Expr "do" CondClause ( NL CondClause )* "end" ;
syntax CondClause = Expr "->" Expr ;

syntax ForStmt
  = "for" ID "from" Expr "to" Expr "do" NL Block "end"
  | "for" ID "in" Expr "do" NL Block "end"
  ;

syntax IteratorExpr = "iterator" "(" Expr ")" "yielding" "(" ID ")" ;


syntax Expr
  = Literal
  | ID
  | ID "(" ArgList? ")"
  | Expr "." ID
  | ID "$" "(" ArgList? ")"
  | "(" Expr ")"
  | ( "neg" | "-" ) Expr
  | Expr ( "+" | "-" | "*" | "/" | "%" | "**" | "<" | ">" | "<=" | ">=" | "<>" | "=" | "and" | "or" ) Expr
  | "(" Expr ( "," Expr )+ ")"
  | "[" ( Expr ( "," Expr )* )? "]"
  ;

syntax ArgList = Arg ( "," Arg )* ;
syntax Arg     = Expr | ID ":" Expr ;

syntax Literal = NUMBER | STRING | "true" | "false" ;

/* End of Syntax.rsc */
module Syntax

layout L = [\ \t\r\n]*;
lexical NL = "\n";

keyword KW = "cond" | "do" | "data" | "elseif" | "end"
           | "for" | "from" | "then" | "function" | "else" | "if" | "in"
           | "iterator" | "sequence" | "struct" | "to" | "tuple" | "type"
           | "with" | "yielding" | "true" | "false" ;

lexical ID = [a-z] [a-z0-9]* !>> KW ;
lexical NUMBER = [0-9]+ ("." [0-9]+)? ;
// CHAR literal removed to avoid lexical parse problems; use STRING for quoted text.
lexical STRING = "\"" (!["\n\r"])* "\"";

start syntax program = moduleDecl+ ;

syntax functionDef = ID "=" "function" "(" paramList? ")" "do" NL block "end" ID ;
syntax dataDef     = ID "=" "data" "with" idList NL repDef NL methodList "end" ID ;
syntax moduleDecl  = functionDef | dataDef ;

syntax paramList = ID ( "," ID )* ;
syntax idList = ID ( "," ID )* ;

syntax repDef = ID "=" "struct" "(" fieldList ")" ;
syntax fieldList = ID ( "," ID )* ;
syntax methodList = functionDef ( NL functionDef )* ;

syntax block = ( statement NL )* ;

syntax statement
  = ID ( "," ID )*
  | ID "=" expr
  | ifExpr
  | condExpr
  | forStmt
  | expr
  ;

syntax ifExpr = "if" expr "then" NL block "else" NL block "end" ;
syntax condExpr = "cond" expr "do" condClause ( NL condClause )* "end" ;
syntax condClause = expr "->" expr ;

syntax forStmt
  = "for" ID "from" expr "to" expr "do" NL block "end"
  | "for" ID "in" expr "do" NL block "end"
  ;

syntax iteratorExpr = "iterator" "(" expr ")" "yielding" "(" ID ")" ;

syntax expr
  = literal
  | ID
  | ID "(" argList? ")"
  | expr "." ID
  | ID "$" "(" argList? ")"
  | "(" expr ")"
  | ("neg" | "-") expr
  | expr ("+"|"-"|"*"|"/"|"%"|"**"|"<"|">"|"<="|">="|"<>"|"="|"and"|"or") expr
  | "(" expr ( "," expr )+ ")"
  | "[" ( expr ( "," expr )* )? "]"
  ;

syntax argList = arg ( "," arg )* ;
syntax arg = expr | ID ":" expr ;

syntax literal = NUMBER | STRING | "true" | "false" ;