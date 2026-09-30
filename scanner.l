%option noyywrap yylineno

%{
#include <stdio.h>
#include "scanner.h"

static int linea_comentario = 0;

/* Reporte explícito del error léxico; el token ERROR se imprime en scanner.c */
static void reportar_error(const char *motivo)
{
	fflush(stdout);
	fprintf(stderr, "Error léxico en la línea %d: %s '%s'\n", yylineno, motivo, yytext);
}
%}

%x COMMENT

ID          [a-zA-Z_][a-zA-Z0-9_]*
INT         [0-9]+
FLOAT       ({INT}\.[0-9]*([eE][+-]?{INT})?|{INT}[eE][+-]?{INT})
WS          [ \t\r\n]+
UTF8        [\xC2-\xDF][\x80-\xBF]|[\xE0-\xEF][\x80-\xBF]{2}|[\xF0-\xF4][\x80-\xBF]{3}

%%

"---"                   { linea_comentario = yylineno; BEGIN(COMMENT); }
<COMMENT>"---"          { BEGIN(INITIAL); }
<COMMENT>\n             { /* yylineno se actualiza automáticamente */ }
<COMMENT>.              { /* descartar contenido de comentario */ }
<COMMENT><<EOF>>        {
                            fflush(stdout);
                            fprintf(stderr, "Error léxico: comentario --- sin cerrar (se abrió en la línea %d)\n", linea_comentario);
                            BEGIN(INITIAL);
                            return TOK_ERROR;
                        }

{WS}                    { /* ignorar espacios */ }

"tortilla"              { return TOK_KW_INT; }
"salsa"                 { return TOK_KW_FLOAT; }
"chile"                 { return TOK_KW_CHAR; }
"tamal"                 { return TOK_KW_STRING; }
"picante"               { return TOK_KW_BOOL; }
"ayuno"                 { return TOK_KW_VOID; }
"si_hay"                { return TOK_KW_IF; }
"ni_modo"               { return TOK_KW_ELSE; }
"sazonando"             { return TOK_KW_WHILE; }
"por_orden"             { return TOK_KW_FOR; }
"cada_taco"             { return TOK_KW_FOREACH; }
"en"                    { return TOK_KW_IN; }
"servir"                { return TOK_KW_RETURN; }
"me_llene"              { return TOK_KW_BREAK; }
"otro_taco"             { return TOK_KW_CONTINUE; }
"de_la_abuela"          { return TOK_KW_CONST; }
"receta"                { return TOK_KW_DEF; }
"gritar"                { return TOK_KW_PRINT; }
"pedir"                 { return TOK_KW_INPUT; }
"con_todo"|"sin_nada"   { return TOK_BOOL_LITERAL; }

"<<="                   { return TOK_SHL_ASSIGN; }
">>="                   { return TOK_SHR_ASSIGN; }
"++"                    { return TOK_INC; }
"--"                    { return TOK_DEC; }
"+="                    { return TOK_PLUS_ASSIGN; }
"-="                    { return TOK_MINUS_ASSIGN; }
"*="                    { return TOK_MUL_ASSIGN; }
"/="                    { return TOK_DIV_ASSIGN; }
"%="                    { return TOK_MOD_ASSIGN; }
"&="                    { return TOK_BITAND_ASSIGN; }
"|="                    { return TOK_BITOR_ASSIGN; }
"^="                    { return TOK_BITXOR_ASSIGN; }
"=="                    { return TOK_EQ; }
"!="                    { return TOK_NEQ; }
"<="                    { return TOK_LE; }
">="                    { return TOK_GE; }
"&&"                    { return TOK_AND; }
"||"                    { return TOK_OR; }
"<<"                    { return TOK_SHL; }
">>"                    { return TOK_SHR; }

"="                     { return TOK_ASSIGN; }
"<"                     { return TOK_LT; }
">"                     { return TOK_GT; }
"!"                     { return TOK_NOT; }
"+"                     { return TOK_PLUS; }
"-"                     { return TOK_MINUS; }
"*"                     { return TOK_MUL; }
"/"                     { return TOK_DIV; }
"%"                     { return TOK_MOD; }
"&"                     { return TOK_BITAND; }
"|"                     { return TOK_BITOR; }
"^"                     { return TOK_BITXOR; }
"~"                     { return TOK_BITNOT; }

"("                     { return TOK_LPAREN; }
")"                     { return TOK_RPAREN; }
"{"                     { return TOK_LBRACE; }
"}"                     { return TOK_RBRACE; }
"["                     { return TOK_LBRACKET; }
"]"                     { return TOK_RBRACKET; }
","                     { return TOK_COMMA; }
";"                     { return TOK_SEMICOLON; }

{FLOAT}                 { return TOK_FLOAT_LITERAL; }
{INT}                   { return TOK_INT_LITERAL; }
\'([^\\\n]|\\.)\'       { return TOK_CHAR_LITERAL; }
\"([^\\\"\n]|\\.)*\"    { return TOK_STRING_LITERAL; }
{ID}                    { return TOK_IDENTIFIER; }

<<EOF>>                 { return TOK_EOF; }

{UTF8}                  { reportar_error("carácter fuera de ASCII"); return TOK_ERROR; }
.                       { reportar_error("ingrediente desconocido"); return TOK_ERROR; }

%%
