# Trabalho de compiladores FACID/Devry
**Professor**: Igor Revoredo

**Alunos**: Filipe Mendes e Rafael Belo

**Problema**: Implementar um ASD preditivo recursivo sobre a gramática:

## Analisador sintático

### O analisador receberá um texto com os tokens e irá processá-lo, consumindo a cadeia. Caso encontre erros, o parser falhará, interrompendo a execução do parser.

**G = ({COMANDO, CONDICIONAL, ITERATIVO, ATRIBUIÇÃO, EXPRESSÃO}, {if, then, while, do, repeat, until, id, :=, num}, PROCESS, COMANDO)**

 * PROCESS:
 * COMANDO     -> *CONDICIONAL* | *ITERATIVO* | *ATRIBUIÇÃO*
 * CONDICIONAL -> if *EXPRESSÃO* then *COMANDO*
 * ITERATIVO   -> while *EXPRESSÃO* do *COMANDO* | repeat *COMANDO* until *EXPRESSÃO*
 * ATRIBUIÇÃO  -> id := *EXPRESSÃO*
 * EXPRESSÃO   -> num | num + *EXPRESSÃO* | num – *EXPRESSÃO*

## Uso
O arquivo **parser.rb** pode ser executado com o seguinte comando:

`ruby parser.rb`

A cadeia de tokens de entrada pode ser repassada de duas formas (em formato texto):

Instanciando o objeto:

```ruby
Parser.new('cadeia de tokens')
```

ou por argumentos na execução do arquivo:

    ruby parser.rb "id := 2"

Para executar o parser, basta chamar o função `#process`:


```ruby
p = Parser.new('cadeia de token')
p.process
```

Para executar no modo de debug:

```ruby
Parser.new('cadeia de tokens', debug: true)
```

Visualizar cadeira de tokens processada:

```ruby
p = Parser.new('cadeira de tokens')
p.tokens
```
