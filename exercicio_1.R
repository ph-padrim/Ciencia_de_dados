
# Este script em R resolve as 9 primeiras questões da lista de exercícios de Ciência de Dados.

# Questão 1:
# Explique o que é uma linguagem de programação. Não deixe de explicitar
# o papel do compilador e do interpretador.
q1 <- function() {
  cat("Questão 1:\n")
  cat("Uma linguagem de programação é um conjunto de regras e símbolos usados para instruir um computador a realizar tarefas específicas. O compilador traduz o código-fonte inteiro para a linguagem de máquina de uma só vez, criando um arquivo executável. Já o interpretador traduz e executa o código linha por linha.\n")
}

# Questão 2:
# De forma esquemática, apresente como é a estrutura dos comandos IF e
# FOR e como se define uma função em R e Python.
q2 <- function() {
  cat("\nQuestão 2:\n")
  cat("Estrutura do IF em R: if (condicao) { ... } else if (outra_condicao) { ... } else { ... }\n")
  cat("Estrutura do FOR em R: for (item in iteravel) { ... }\n")
  cat("Definição de função em R: nome_da_funcao <- function(parametros) { ... }\n")
}

# Questão 3:
# Usando R e Python, defina sua própria função (portanto, não use alguma
# outra função que já esteja definida na linguagem para esse fim) na qual se
# passe como entrada uma lista com 10 números e ela retorne o valor médio
# da lista.
q3 <- function(lista) {
  cat("\nQuestão 3:\n")
  media <- sum(lista) / length(lista)
  cat(paste0("A média da lista é: ", media, "\n"))
  return(media)
}

# Questão 4:
# Usando R e Python, defina sua própria função (portanto, não use alguma
# outra função que já esteja definida na linguagem para esse fim) na qual se
# passe como entrada uma lista com 10 números e ela retorne o maior
# número da lista.
q4 <- function(lista) {
  cat("\nQuestão 4:\n")
  maior <- lista[1]
  for (numero in lista) {
    if (numero > maior) {
      maior <- numero
    }
  }
  cat(paste0("O maior número da lista é: ", maior, "\n"))
  return(maior)
}

# Questão 5:
# Usando R ou Python, defina sua própria função (portanto, não use alguma
# outra função que já esteja definida na linguagem para esse fim) que gere os
# 50 primeiros valores da sequência de Fibonacci.
q5 <- function() {
  cat("\nQuestão 5:\n")
  fibonacci <- c(0, 1)
  while (length(fibonacci) < 50) {
    proximo <- fibonacci[length(fibonacci)] + fibonacci[length(fibonacci) - 1]
    fibonacci <- c(fibonacci, proximo)
  }
  cat("Os 50 primeiros valores da sequência de Fibonacci são: ", paste(fibonacci, collapse = ", "), "\n")
  return(fibonacci)
}

# Questão 6:
# A partir da sequência de Fibonacci que você construiu no exercício
# anterior, calcule, usando R ou Python, a razão entre dois números
# consecutivos à medida que série vai crescendo. Essa razão parece convergir
# para um mesmo valor? Qual valor é esse?
q6 <- function() {
  cat("\nQuestão 6:\n")
  fibonacci <- q5()
  razoes <- c()
  for (i in 3:length(fibonacci)) {
    razoes <- c(razoes, fibonacci[i] / fibonacci[i-1])
  }
  cat("As razões entre os números consecutivos são: ", paste(razoes, collapse = ", "), "\n")
  cat(paste0("A razão parece convergir para o número de ouro: ", razoes[length(razoes)], "\n"))
}

# Questão 7:
# Explique os conceitos de classe e instância associados com uma linguagem
# de programação orientada a objeto.
q7 <- function() {
  cat("\nQuestão 7:\n")
  cat("Classe é um modelo para criar objetos, definindo seus atributos e métodos. Instância é um objeto específico criado a partir de uma classe.\n")
}

# Questão 8:
# Usando Python, crie uma classe (que não tenhamos visto em aula)
# explicando, também, que tipo de objeto ela irá instanciar. Explique quais
# serão seus atributos e, pelo menos, um dos seus métodos. Apresente o
# código fonte que você usou para criá-la.
# (Em R, o conceito de classe e instância é implementado de forma diferente, mas podemos simular um objeto)
MinhaClasseR <- setRefClass("MinhaClasseR",
                            fields = list(nome = "character", idade = "numeric"),
                            methods = list(
                              apresentar = function() {
                                return(paste0("Olá, meu nome é ", nome, " e tenho ", idade, " anos."))
                              }
                            )
)

q8 <- function() {
  cat("\nQuestão 8:\n")
  cat("Em R, podemos usar sistemas de classes como S3, S4 ou Reference Classes. Aqui, usamos Reference Classes para simular uma classe com atributos 'nome' e 'idade' e um método 'apresentar'.\n")
  pessoa <- MinhaClasseR$new(nome = "Maria", idade = 25)
  cat(pessoa$apresentar(), "\n")
}

# Questão 9:
# O DNA é composto por 4 bases: Guanina (‘G’), Citosina (‘C’), Adenina
# (‘A’), e Timina (‘T’). O RNA é composto por 4 bases, mas em vez de
# Timina (‘T’), tem Uralina (‘U’). Crie uma função para receber uma
# sequência de DNA de qualquer tamanho e converter para RNA. Por
# exemplo, pegar um texto na forma GCATATAC e retornar a conversão
# para RNA, que seria GCAUAUAC.
q9 <- function(dna) {
  cat("\nQuestão 9:\n")
  rna <- gsub("T", "U", dna)
  cat(paste0("A sequência de DNA ", dna, " convertida para RNA é: ", rna, "\n"))
  return(rna)
}

# Execução das funções
q1()
q2()
q3(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
q4(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
q5()
q6()
q7()
q8()
q9("GCATATAC")

