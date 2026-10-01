CC      = gcc
PRUEBAS = pruebas/prueba_programa.txt pruebas/prueba_casos_limite.txt pruebas/prueba_errores.txt

# Desactiva las reglas implícitas de make. Sin esto, la regla %.c: %.l
# "regenera" scanner.c a partir de scanner.l y borra nuestro main.
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

all: scanner

lex.yy.c: scanner.l scanner.h
	flex scanner.l

scanner: lex.yy.c scanner.c scanner.h
	$(CC) -o scanner lex.yy.c scanner.c

# Corre cada archivo de prueba y muestra su salida
test: scanner
	@for f in $(PRUEBAS); do \
		echo "===== $$f"; \
		./scanner < $$f; \
		echo ""; \
	done

clean:
	rm -f scanner lex.yy.c

.PHONY: all test clean
