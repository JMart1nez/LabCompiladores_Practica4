#include <stdio.h>

#include "scanner.h"

extern int yylex(void);
extern char *yytext;

int main(void)
{
	int token;

	while ((token = yylex()) != TOK_EOF) {
		printf("[%s:%s]\n", scanner_token_name(token), yytext);
	}

	return 0;
}

const char *scanner_token_name(int token)
{
	switch (token) {
		case TOK_EOF: return "EOF";
		case TOK_ERROR: return "ERROR";

		case TOK_KW_INT: return "KW_INT";
		case TOK_KW_FLOAT: return "KW_FLOAT";
		case TOK_KW_CHAR: return "KW_CHAR";
		case TOK_KW_STRING: return "KW_STRING";
		case TOK_KW_BOOL: return "KW_BOOL";
		case TOK_KW_VOID: return "KW_VOID";
		case TOK_KW_IF: return "KW_IF";
		case TOK_KW_ELSE: return "KW_ELSE";
		case TOK_KW_WHILE: return "KW_WHILE";
		case TOK_KW_FOR: return "KW_FOR";
		case TOK_KW_FOREACH: return "KW_FOREACH";
		case TOK_KW_IN: return "KW_IN";
		case TOK_KW_RETURN: return "KW_RETURN";
		case TOK_KW_BREAK: return "KW_BREAK";
		case TOK_KW_CONTINUE: return "KW_CONTINUE";
		case TOK_KW_CONST: return "KW_CONST";
		case TOK_KW_DEF: return "KW_DEF";
		case TOK_KW_PRINT: return "KW_PRINT";
		case TOK_KW_INPUT: return "KW_INPUT";

		case TOK_VARIABLE: return "VARIABLE";
		case TOK_IDENTIFIER: return "IDENTIFIER";
		case TOK_INT_LITERAL: return "INT_LITERAL";
		case TOK_FLOAT_LITERAL: return "FLOAT_LITERAL";
		case TOK_STRING_LITERAL: return "STRING_LITERAL";
		case TOK_CHAR_LITERAL: return "CHAR_LITERAL";
		case TOK_BOOL_LITERAL: return "BOOL_LITERAL";

		case TOK_INC: return "INC";
		case TOK_DEC: return "DEC";
		case TOK_PLUS_ASSIGN: return "PLUS_ASSIGN";
		case TOK_MINUS_ASSIGN: return "MINUS_ASSIGN";
		case TOK_MUL_ASSIGN: return "MUL_ASSIGN";
		case TOK_DIV_ASSIGN: return "DIV_ASSIGN";
		case TOK_MOD_ASSIGN: return "MOD_ASSIGN";
		case TOK_SHL_ASSIGN: return "SHL_ASSIGN";
		case TOK_SHR_ASSIGN: return "SHR_ASSIGN";
		case TOK_BITAND_ASSIGN: return "BITAND_ASSIGN";
		case TOK_BITOR_ASSIGN: return "BITOR_ASSIGN";
		case TOK_BITXOR_ASSIGN: return "BITXOR_ASSIGN";
		case TOK_ASSIGN: return "ASSIGN";

		case TOK_EQ: return "EQ";
		case TOK_NEQ: return "NEQ";
		case TOK_LT: return "LT";
		case TOK_LE: return "LE";
		case TOK_GT: return "GT";
		case TOK_GE: return "GE";

		case TOK_AND: return "AND";
		case TOK_OR: return "OR";
		case TOK_NOT: return "NOT";

		case TOK_PLUS: return "PLUS";
		case TOK_MINUS: return "MINUS";
		case TOK_MUL: return "MUL";
		case TOK_DIV: return "DIV";
		case TOK_MOD: return "MOD";

		case TOK_SHL: return "SHL";
		case TOK_SHR: return "SHR";
		case TOK_BITAND: return "BITAND";
		case TOK_BITOR: return "BITOR";
		case TOK_BITXOR: return "BITXOR";
		case TOK_BITNOT: return "BITNOT";

		case TOK_LPAREN: return "LPAREN";
		case TOK_RPAREN: return "RPAREN";
		case TOK_LBRACE: return "LBRACE";
		case TOK_RBRACE: return "RBRACE";
		case TOK_LBRACKET: return "LBRACKET";
		case TOK_RBRACKET: return "RBRACKET";
		case TOK_COMMA: return "COMMA";
		case TOK_SEMICOLON: return "SEMICOLON";
		default: return "UNKNOWN";
	}
}
