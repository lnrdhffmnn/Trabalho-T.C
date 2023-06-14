grammar Gramatica;

program : statementList
        ;

modifier : 'float'
         | 'boolean'
         | 'integer'
         | 'param'
         | 'vector' '[' num ']'
         | 'TYPE' '(' id ')'
         ;

id : ID
   ;

num : INT
    | FLOAT
    ;

idList : id
       | id ',' idList
       ;

modifierList : modifier
             | modifierList modifier
             ;

nameDecl : modifierList idList
	 ;

codeFragment : 'FRAGMENT' id ';' statementList 'ENDFRAGMENT' 
	     | 'FRAGMENT' modifierList id ';' statementList 'ENDFRAGMENT'
	     | 'FRAGMENT' id ';' literal 'ENDFRAGMENT'
	     | 'FRAGMENT' modifierList id ';' num 'ENDFRAGMENT'
	     | 'FRAGMENT' statementList 'ENDFRAGMENT'
	     ;

statementList : statement statementList
              | statement
              ;

statement : nameDecl ';'
          | destiny '=' expression ';'
          | callFunc ';'
          | codeFragment
          | 'IF' '(' expression ')' statementList 'ELSE' statementList
          | 'IF' '(' expression ')' statementList
          | 'WHILE' '(' expression ')' statement
          | 'SELECT' '(' expression ')' 'FRAGMENT' caseBlock 'ENDFRAGMENT'
          | 'WRITE' '(' expressionList ')' ';'
          | 'READ' '(' expressionList ')' ';'
          | 'BREAK' ';'
          ;

destiny : id
        | id '[' expression ']'
        | name
        ;

caseBlock : 'CASE' expression ':' statementList caseBlock
	  | 'DEFAULT' ':' statementList caseBlock
	  ;

expressionList : expression
               | expressionList ',' expression
               ;

expression : primary
	   | unaryOp expression
	   | expression binOp expression
	   ;

primary : name 
        | callFunc
        | '(' expression ')'
        | id '(' expressionList ')'
        | 'TRUE'
        | 'FALSE'
        | literal
        ;

name : id
     | id '[' expression ']'
     | name '.' name
     ;

unaryOp : '-'
        | '!'
        | '+'
        ;

binOp : '=='
      | '<'
      | '<='
      | '>='
      | '>'
      | '!='
      | '+'
      | '-'
      | '*'
      | '='
      | '/'
      | '&&'
      | '||'
      ;

callFunc : id '(' expressionList ')' 
	 ;

literal : INT 
        | FLOAT
        | STRING 
        ;

AND:		'&&';
OR:             '||';
NOT:	    	'!';
EQ:             '=';
EQS: 	    	'==';
GREATER:	'<';
GREATER_EQ: 	'<=';
SMALLER:    	'>';
SMALLER_EQ: 	'>=';
DIFF: 	    	'!=';
COMMA: 	    	',';
SEMI: 	    	';';
OPEN_PAREN: 	'(';
CLOSE_PAREN: 	')';
OPEN_BRACKET: 	'[';
CLOSE_BRACKET:	']';
OPEN_CURLY: 	'{';
CLOSE_CURLY: 	'}';
DOT: 	    	'.';
COLON: 	    	':';

IF:	    	'IF';
ELSE:		'ELSE';
WHILE:		'WHILE';
SELECT:		'SELECT';
PRINT:		'WRITE';
READ:		'READ';
BREAK:		'BREAK';
CASE:		'CASE'; 
DEFAULT:	'DEFAULT';
PARAM:		'param';
VECTOR:		'VECTOR';
TYPE:		'TYPE';

M_FLOAT: 	'float';
M_BOOLEAN: 	'boolean';
M_INTEGER: 	'integer';

START_FRAGMENT:	'FRAGMENT';
END_FRAGMENT:	'ENDFRAGMENT';

PLUS: 		'+';
MINUS:		'-';
STAR:		'*';
SLASH:		'/';

TRUE:		'TRUE';
FALSE:		'FALSE';

INT:		[0-9]+;
FLOAT:		[0-9]+ '.' [0-9]*;
STRING:		'"' ('""' | ~'"')* '"';
BOOLEAN:	'true' | 'false';
ID:		[a-zA-Z_][a-zA-Z_0-9]*;
WS:		[ \t\n\r\f]+ -> skip;
COMMENT:	'//' ~ [\r\n]* -> skip;
