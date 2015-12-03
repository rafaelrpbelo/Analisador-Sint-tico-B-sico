# Trabalho de compiladores FACID/Devry
### Prof. Igor Revoredo
### Alunos: Filipe Mendes e Rafael Belo

## ANALISADOR SINTÁTICO

O analisador receberá um texto com os tokens

Problema: Implementar um ASD preditivo recursivo sobre a gramática:
G = ({COMANDO, CONDICIONAL, ITERATIVO, ATRIBUIÇÃO, EXPRESSÃO},
     {if, then, while, do, repeat, until, id, :=, num},
     PROCESS, Comando)

PROCESS:
COMANDO     -> *CONDICIONAL* | *ITERATIVO* | *ATRIBUIÇÃO*
CONDICIONAL -> if *EXPRESSÃO* then *COMANDO*
ITERATIVO   -> while *EXPRESSÃO* do *COMANDO* | repeat *COMANDO* until *EXPRESSÃO*
ATRIBUIÇÃO  -> id := *EXPRESSÃO*
EXPRESSÃO   -> num | num + *EXPRESSÃO* | num – *EXPRESSÃO*
