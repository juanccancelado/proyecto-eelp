module Implode

import Syntax;
import Parser;
import AST;

import ParseTree;
import Node;

public Program implode(Tree pt) = implode(#Program, pt);
public Program load(loc l) = implode(#Program, parsePlanning(l));
