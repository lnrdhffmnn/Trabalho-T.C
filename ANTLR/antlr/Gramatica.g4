grammar Gramatica;

program
    : statementList
    ;

modifier : M_FLOAT
         | M_BOOLEAN
         | M_INTEGER
         | PARAM
         | VECTOR '[' INT ']'
         | TYPE '(' ID ')'
         ;

idList : ID
       | ID ',' idList
       ;

modifierList : modifier
             | modifierList modifier
             ;

nameDecl : modifierList idList;

codeFragment 
: START_FRAGMENT ID ';' statementList END_FRAGMENT 
| START_FRAGMENT statementList END_FRAGMENT
| START_FRAGMENT modifierList ID ';' statementList END_FRAGMENT
| START_FRAGMENT ID ';' literal END_FRAGMENT
| START_FRAGMENT modifierList ID ';' NUM END_FRAGMENT
;

statementList : statement statementList
              | statement
              ;

statement : nameDecl ';'
          | destiny '=' expr ';'
          | callFunc ';'
          | codeFragment
          | IF '(' expr ')' statementList ELSE
          statementList
          | IF '(' expr ')' statementList
          | WHILE '(' expr ')' statement
          | SELECT '(' expr ')' START_FRAGMENT
          caseBlock END_FRAGMENT
          | PRINT '(' expressionList ')' ';'
          | READ '(' expressionList ')' ';'
          | BREAK ';'
          ;

destiny : ID
        | ID '[' expr ']'
        | name
        ;

caseBlock 
: CASE expr ':' statementList caseBlock
| DEFAULT ':' statementList caseBlock
;

expressionList : expr
               | expressionList ',' expr
               ;

expr: primary
    | unaryOp expr
    | expr binOp expr
    ;

literal : INT 
        | STRING 
        ;

primary : name 
        | callFunc
        | '(' expr ')'
        | ID '(' expressionList ')'
        | TRUE
        | FALSE
        | literal
        ;

unaryOp : SUB
        | NOT
        | SUM
        ;

binOp : EQS
      | GREATER
      | GREATER_EQ
      | SMALLER
      | SMALLER_EQ
      | DIFF
      | SUM
      | SUB
      | MUL
      | EQ
      | DIV
      | AND
      | OR
      ;

name : ID
     | ID '[' expr ']'
     | name '.' name
     ;

callFunc : ID '(' expressionList ')' ;

AND : '&&' ;
OR : '||' ;
NOT : '!' ;
EQ : '=' ;
EQS : '==' ;
GREATER : '<' ;
GREATER_EQ : '<=' ;
SMALLER : '>' ;
SMALLER_EQ : '>=';
DIFF : '!=' ;
COMMA : ',' ;
SEMI : ';' ;
OPEN_PAREN : '(' ;
CLOSE_PAREN : ')' ;
OPEN_BRACKET : '[' ;
CLOSE_BRACKET : ']' ;
OPEN_CURLY : '{' ;
CLOSE_CURLY : '}' ;
DOT : '.' ;
COLON : ':' ;

IF : 'IF' ;
ELSE : 'ELSE' ;
WHILE : 'WHILE' ;
SELECT : 'SELECT' ;
PRINT : 'WRITE' ;
READ : 'READ' ;
BREAK : 'BREAK' ;
CASE : 'CASE' ; 
DEFAULT : 'DEFAULT' ;
PARAM : 'param' ;
VECTOR : 'VECTOR' ;
TYPE : 'TYPE' ;

M_FLOAT : 'float' ;
M_BOOLEAN : 'boolean' ;
M_INTEGER : 'integer' ;

START_FRAGMENT : 'FRAGMENT' ;
END_FRAGMENT : 'ENDFRAGMENT' ;

SUM : '+';
SUB : '-';
MUL : '*';
DIV : '/';

TRUE: 'TRUE';
FALSE: 'FALSE';

INT : [0-9]+ ;
NUM : INT ;
STRING : '"' ('""' | ~'"')* '"' ;
BOOLEAN : 'true' | 'false' ;
ID: [a-zA-Z_][a-zA-Z_0-9]* ;
WS: [ \t\n\r\f]+ -> skip ;

