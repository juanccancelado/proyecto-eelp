module AST



data Program       = program(list[ModuleDecl] modules);
data ModuleDecl    = moduleFunc(FunctionDef functionDef)
                   | moduleData(DataDef dataDef);

data FunctionDef   = functionDef(str name, list[str] params, Block body);
data DataDef       = dataDef(str name, list[str] fields, list[FunctionDef] methods);

data Block         = block(list[Statement] statements);

data Statement     = assign(str name, Expr value)
                   | exprStmt(Expr expr)
                   | ifStmt(Expr cond, Block thenBlock, Block elseBlock)
                   | forRange(str var, Expr start, Expr end, Block body)
                   | forIn(str var, Expr iterable, Block body);

data Expr          = literal(Literal value)
                   | var(str name)
                   | call(str func, list[Expr] args)
                   | dollarCall(str func, list[Expr] args)
                   | dot(Expr left, str field)
                   | neg(Expr expr)
                   | binOp(Expr left, Op op, Expr right)
                   | tupleExpr(list[Expr] elems)
                   | listExpr(list[Expr] elems);

data Arg           = arg(Expr expr) | namedArg(str name, Expr expr);

data Literal       = number(str n)
                   | string(str s)
                   | boolTrue()
                   | boolFalse();

data Op            = add() | sub() | mul() | div() | mod() | pow()
                   | lt() | gt() | le() | ge() | eq() | ne()
                   | and() | or();
