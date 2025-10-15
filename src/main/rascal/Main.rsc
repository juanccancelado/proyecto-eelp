module Main

import IO;

int main(int testArgument=0) {
    println("argument: <testArgument>");
    return testArgument;
}

module Syntax
layout Layout = WhitespaceAndComment* !>> [\ \t\n\r#];
lexical WhitespaceAndComment = [\ \t\n\r] | @category="Comment" "#" ![\n]* $;

start syntax Program
  = program: Module+ ;

syntax Module
  = functionDef: ID "=" "function" "(" ParamList? ")" "do" Block "end" ID
  | dataDef: ID "=" "data" "with" ID ("," ID)*  ;

