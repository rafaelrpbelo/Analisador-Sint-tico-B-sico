# Trabalho de compiladores FACID/Devry
# Prof. Igor Revoredo
# Alunos: Filipe Mendes e Rafael Belo
#
# ANALISADOR SINTÁTICO
#
# O analisador receberá um texto com os tokens
#
# Problema: Implementar um ASD preditivo recursivo sobre a gramática:
# G = ({COMANDO, CONDICIONAL, ITERATIVO, ATRIBUIÇÃO, EXPRESSÃO},
#      {if, then, while, do, repeat, until, id, :=, num},
#      PROCESS, Comando)
#
# PROCESS:
# COMANDO     -> CONDICIONAL | ITERATIVO | ATRIBUIÇÃO
# CONDICIONAL -> if EXPRESSÃO then COMANDO
# ITERATIVO   -> while EXPRESSÃO do COMANDO | repeat COMANDO until EXPRESSÃO
# ATRIBUIÇÃO  -> id := EXPRESSÃO
# EXPRESSÃO   -> num | num + EXPRESSÃO | num – EXPRESSÃOESSÃO


  attr_reader :tokens
class Parser

  def initialize(tokens_params, options = {})
    if ARGV[0].nil? || ARGV[0].empty?
      @tokens = format_tokens(tokens_params)
    else
      @tokens = format_tokens(ARGV[0].chomp)
    end

    @token_position = 0
    @current_token = @tokens[@token_position]
    @debug = options[:debug]
  end

  # Main function
  def process
    std_message('Start process')
    comando
    std_message('End process')
    token_list
  end

  private

  attr_reader :token_position, :current_token, :debug

  # COMANDO
  def comando
    std_message('Begin comando')
    condicional
    iterativo
    atribuicao
    std_message('End comando')
  end

  # CONDICIONAL -> if EXPRESSÃO then COMANDO
  def condicional
    if current_token == 'if'
      in_no_terminals('condicional > if')
      prox_token
      expressao

      if current_token == 'then'
        in_no_terminals('condicional > then')
        prox_token
        comando
        out_no_terminals("condicional > then")
      else
        raise_error
      end
      out_no_terminals('condicional > if')
    end
  end

  # ITERATIVO -> while EXPRESSÃO do COMANDO | repeat COMANDO until EXPRESSÃO
  def iterativo
    if current_token == 'while'
      prox_token
      expressao

      if current_token == 'do'
        prox_token
        comando
      else
        raise_error
      end
    elsif current_token == 'repeat'
      prox_token
      comando

      if current_token == 'until'
        prox_token
        expressao
      else
        raise_error
      end
    end
  end

  # ATRIBUIÇÃO -> id := EXPRESSÃO
  def atribuicao
    if current_token == 'id'
      in_no_terminals('atribuicao > id')
      prox_token

      if current_token == ':='
        in_no_terminals('atribuicao > id > :=')
        prox_token
        expressao
        out_no_terminals('atribuicao > id > :=')
      else
        raise_error
      end
      out_no_terminals('atribuicao > id')
    end
  end

  # EXPRESSÃO -> num | num + EXPRESSÃO | num – EXPRESSÃO
  def expressao
    if number?(current_token)
      in_no_terminals('expressao > number')
      prox_token
      if current_token == '+' || current_token == '-'
        in_no_terminals('expressao > number > +-')
        prox_token
        expressao
        out_no_terminals('expressao > number > +-')
      end
      out_no_terminals('expressao > number')
    end
  end

  # HELPERS

  def format_tokens(tokens_params)
    tokens_params.
      strip.
      split(/\s{1,}/)
  end

  def prox_token
    increment_token_position
    @current_token = tokens[token_position]
  end

  def increment_token_position
    @token_position += 1
  end

  def raise_error
    fail 'An error ocorred! =O'
  end

  def number?(number)
    number =~ /^([[:digit:]]{1,})$/
  end

  def current_token
    tokens[token_position]
  end

  # Helper messages
  def std_message(msg = '')
    puts "== #{msg} ==" if @debug
  end

  def in_no_terminals(msg = '')
    puts "-> IN: #{msg}" if @debug
  end

  def out_no_terminals(msg = '')
    puts "-> OUT: #{msg}" if @debug
  end

  def token_list
    puts "\n== TOKENS =="
    puts tokens.inspect
    puts
  end
end

# PROCESS:
# COMANDO     -> CONDICIONAL | ITERATIVO | ATRIBUIÇÃO
# CONDICIONAL -> if EXPRESSÃO then COMANDO
# ITERATIVO   -> while EXPRESSÃO do COMANDO | repeat COMANDO until EXPRESSÃO
# ATRIBUIÇÃO  -> id := EXPRESSÃO
# EXPRESSÃO   -> num | num + EXPRESSÃO | num – EXPRESSÃO

exemplo_atribuicao = <<-TEXT
  id := 2
TEXT

exemplo_condicional = <<-TEXT
  if 1 + 1 then id := 4
TEXT

exemplo_iterativo = <<-TEXT
  while 2 do if 2 - 1 then repeat id := 9 + 1 - 2 until 1
TEXT

puts "\n>>> Init program <<<\n"
program = Main.new(exemplo_iterativo, debug: true)
program = Parser.new(exemplo_iterativo)
puts
program.process
puts "\n>>> End program <<<\n"

