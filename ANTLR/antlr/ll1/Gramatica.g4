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

idList : id idListCompound
       ;

idListCompound : ',' idListCompound 
               | epsilon
               ;

modifierList : modifier modifierListMultiple
             ;

modifierListMultiple : modifier modifierListMultiple
                     | epsilon
                     ;

nameDecl : modifierList idList
	 ;

codeFragment : 'FRAGMENT' codeFragmentBody
	     ;

codeFragmentBody : modifierList codeFragmentId
                 | id codeFragmentDestiny
                 | 'IF' '(' expression ')' statementList 
                 statementElse statementListOptional 
                 'ENDFRAGMENT'
                 | codeFragment statementListOptional 
                 'ENDFRAGMENT'
                 | 'READ' '(' expressionList ')' ';'
                 statementListOptional 'ENDFRAGMENT'
                 | 'WHILE' '(' expression ')' statementList
                 statementListOptional 'ENDFRAGMENT'
                 | 'SELECT' '(' expression ')' 'FRAGMENT'
                 caseBlock 'ENDFRAGMENT' statementListOptional
                 'ENDFRAGMENT'
                 | 'BREAK' ';' statementListOptional 
                 'ENDFRAGMENT'
                 | 'WRITE' '(' expressionList ')' ';'
                 statementListOptional 'ENDFRAGMENT'
                 ;

endFragmentLiteral : statementList 'ENDFRAGMENT'
                   | literal 'ENDFRAGMENT'
                   ;

endFragmentNum : statementList 'ENDFRAGMENT'
               | num 'ENDFRAGMENT'
               ;

codeFragmentId : id codeFragmentIdList
               ;

codeFragmentDestiny : statementDestiny statementListOptional
                    'ENDFRAGMENT'
                    | ';' endFragmentLiteral
                    ;

codeFragmentIdList : ';' endFragmentNum
                   | '.' name nameCompound ';' endFragmentNum
                   ;

statementList : statement statementListOptional
              ;

statementListOptional : statementList
                      | epsilon
                      ;

statement : id statementDestiny
          | 'IF' '(' expression ')' statementList 
          statementElse
          | nameDecl ';'
          | codeFragment
          | 'READ' '(' expressionList ')' ';'
          | 'WHILE' '(' expression ')' statementList
          | 'SELECT' '(' expression ')' 'FRAGMENT'
          caseBlock 'ENDFRAGMENT'
          | 'BREAK' ';'
          | 'WRITE' '(' expressionList ')' ';'
          ;

statementElse : 'ELSE' statementList
              | epsilon
              ;

statementDestiny : destinyName '=' expression ';'
                 | '(' expressionList ')' ';'
                 ;

destiny : id destinyName
        ;

destinyName : '[' expression ']' destinyNameCompound
            | epsilon
            | nameCompound
            ;

destinyNameCompound : nameCompound
                    | epsilon
                    ;

caseBlock : 'CASE' expression ':' statementList caseBlock
	  | 'DEFAULT' ':' statementList caseBlock
	  ;

expressionList : expression expressionListCompound
               ;

expressionListCompound : ',' expression
                       expressionListCompound
                       | epsilon
                       ;

expression : primary
	   | unaryOp expression
	   | expressionOr
	   ;

expressionOr : expressionAnd or;
or : '||' expressionAnd or | epsilon ;
expressionAnd : expressionLTEqual and;
and : '&&' expressionLTEqual and | epsilon ;
expressionLTEqual : expressionLT ltequal;
ltequal : '<=' expressionLT ltequal | epsilon ;
expressionLT : expressionGTEqual lt;
lt : '<' expressionGTEqual lt | epsilon ;
expressionGTEqual : expressionGT gtequal;
gtequal : '>=' expressionGT gtequal | epsilon ;
expressionGT : expressionDif gt;
gt : '>' expressionDif gt | epsilon ;
expressionDif : expressionEqual dif;
dif : '!=' expressionEqual dif | epsilon ;
expressionEqual : expressionSub equal;
equal : '==' expressionSub equal | epsilon ;
expressionSub : expressionSum sub;
sub : '-' expressionSum sub | epsilon ;
expressionSum : expressionDiv sum;
sum : '+' expressionDiv sum | epsilon ;
expressionDiv : expressionMult div;
div : '/' expressionMult div | epsilon ;
expressionMult : primary mult;
mult : '*' primary mult | epsilon ;

primary : id primaryExpression 
        | '(' expression ')'
        | 'TRUE'
        | 'FALSE'
        | literal
        ;

primaryExpression : '(' expressionList ')'
                  | nameExpression
                  ;

name : id nameExpression
     ;

nameExpression : nameCompound
               | '[' expression ']' nameCompound
               ;

nameCompound : '.' name nameCompound
             | epsilon
             ;

unaryOp : '-'
        | '!'
        | '+'
        ;

callFunc : id '(' expressionList ')' 
	 ;

literal : INT 
        | FLOAT
        | STRING 
        ;

epsilon : ;

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
