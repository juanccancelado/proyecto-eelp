module Syntax;

/* Minimal placeholder module used to verify file-level parse errors.
  If this fixes the parse problem, re-introduce syntax rules incrementally. */

start syntax Program
  = program: Module ( NL Module )* ;

syntax Module
  = functionDef: FunctionDef
  | dataDef: DataDef
  ;

syntax FunctionDef
  = id:ID "=" "function" "(" ParamList? ")" "do" NL Block "end" ID
  ;

syntax ParamList = ID ( "," ID )* ;

syntax DataDef
  = id:ID "=" "data" "with" IdList NL RepDef NL MethodList "end" ID
  ;

syntax IdList = ID ( "," ID )* ;

syntax RepDef = id:ID "=" "struct" "(" FieldList ")" ;
syntax FieldList = ID ( "," ID )* ;

syntax MethodList = Method ( NL Method )* ;
syntax Method = FunctionDef ;

syntax Block = ( Statement NL )* ;

syntax Statement
  = declaration: Declaration
  | assignment: Assignment
  | control: Control
  | exprStmt: Expr
  ;

syntax Declaration = ID ( "," ID )* ;
syntax Assignment  = ID "=" Expr ;

syntax Control
  = IfExpr
  | CondExpr
  | ForStmt
  ;

syntax IfExpr
  = "if" Expr "then" NL Block "else" NL Block "end"
  ;

syntax CondExpr
  = "cond" Expr "do" CondClause ( NL CondClause )* "end"
  ;

syntax CondClause = Expr "->" Expr ;

syntax ForStmt
  = "for" ID "from" Expr "to" Expr "do" NL Block "end"
  | "for" ID "in" Expr "do" NL Block "end"
  ;

syntax IteratorExpr = "iterator" "(" Expr ")" "yielding" "(" ID ")" ;

syntax Expr
  = Literal
  | ID
  | CallExpr
  | MemberAccess
  | InternalCall
  | "(" Expr ")"
  | UnaryOp Expr
  | Expr BinaryOp Expr
  | Tuple
  | Sequence
  ;

syntax CallExpr = ID "(" ArgList? ")" ;
syntax MemberAccess = Expr "." ID ;
syntax InternalCall = ID "$" "(" ArgList? ")" ;

syntax ArgList = Arg ( "," Arg )* ;
syntax Arg = Expr | ID ":" Expr ;

syntax Tuple = "(" Expr ( "," Expr )+ ")" ;       // tuple: require comma to avoid ambiguity with grouping
syntax Sequence = "[" ( Expr ( "," Expr )* )? "]" ;

syntax Literal
  = number:NUMBER
  | string:STRING
  | char:CHAR
  | boolean:("true" | "false")
  ;

lexical UnaryOp = "neg" | "-" ;
lexical BinaryOp = "+" | "-" | "*" | "/" | "%" | "**"
                 | "<" | ">" | "<=" | ">=" | "<>" | "="
                 | "and" | "or" ;

