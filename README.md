# Trabalho de compiladores FACID/Devry
**Professor**: Igor Revoredo

**Alunos**: Filipe Mendes e Rafael Belo

**Problema**: Implementar um ASD preditivo recursivo sobre a gramática:

## ANALISADOR SINTÁTICO

### O analisador receberá um texto com os tokens e irá processá-lo, consumindo a cadeia. Caso encontre erros, o parser falhará, interrompendo a execução do parser.

**G = ({COMANDO, CONDICIONAL, ITERATIVO, ATRIBUIÇÃO, EXPRESSÃO}, {if, then, while, do, repeat, until, id, :=, num}, PROCESS, COMANDO)**

 * PROCESS:
 * COMANDO     -> *CONDICIONAL* | *ITERATIVO* | *ATRIBUIÇÃO*
 * CONDICIONAL -> if *EXPRESSÃO* then *COMANDO*
 * ITERATIVO   -> while *EXPRESSÃO* do *COMANDO* | repeat *COMANDO* until *EXPRESSÃO*
 * ATRIBUIÇÃO  -> id := *EXPRESSÃO*
 * EXPRESSÃO   -> num | num + *EXPRESSÃO* | num – *EXPRESSÃO*
