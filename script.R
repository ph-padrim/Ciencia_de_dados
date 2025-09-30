#--------------------------------------#
#                                      #
#      Introdução ao R (tidyverse)     #
#                                      #
#             12/09/2025               #
#--------------------------------------#

# Instalando os pacotes necessários ---------------------------------------

'se já instalou, não precisa instalar novamente'

# install.packages(c("tidyverse", "readxl", "janitor"))

# Carregando os pacotes que serão utilizados ------------------------------

library(tidyverse)
library(readxl) # para ler excel
library(janitor)

# Importando as bases de dados --------------------------------------------

?read_csv
?read_csv2
?read_excel
?read_rds

read_excel("/home/ph-padrim/Área de trabalho/Curso de Ciência dos Dados/ciencia-de-dados/percen_terra_agro.xls")

'vejam que ele só soltou o resultado da minha base de dados na janela de baixo'
'a gente precisa salvar nossa base em um objeto para trabalhar com ela'

agro <- read_excel("/home/ph-padrim/Área de trabalho/Curso de Ciência dos Dados/ciencia-de-dados/percen_terra_agro.xls")
'ele já leu a base e salvou no objeto agro'
'lembrem-se, nomes legíveis, nada de nomes bizarros'

rais <- read_rds("/home/ph-padrim/Área de trabalho/Curso de Ciência dos Dados/ciencia-de-dados/rais.RDS")

'Cuidado com o csv para ver se é americano ou latino'
'americano usa o csv, latino usa o csv2'
'csv: separador de vírgula'
'csv2: separador de ponto e vírgula'

leitos <- read_csv2("/home/ph-padrim/Downloads/leitos.csv")

casos_dengue <- read_csv2("/home/ph-padrim/Downloads/casos_dengue.csv")

mortes_dengue <- read_csv2("/home/ph-padrim/Downloads/mortes_dengue.csv")

# Organizando e dando um talento na base de dados -------------------------

'Primeira coisa: dê uma olhada na base de dados'

View(agro) # mais que 50 colunas ele coloca páginas
View(leitos)
View(rais)

'ou clica no nome dela lá no enviroment'

## select (seleciona ou joga fora colunas) ---------------------------------

'vamos brincar com a base de agro primeiro'
'tenho muitos anos, não vou usar isso tudo, como eu jogo fora?'

?select

select(agro, "Country Name", "2020", "2021", "2022")

'novamente, ele só soltou o resultado pra mim, caso eu queria salvar essa base em algum lugar'
'salva em um objeto'

agro_subbase <- select(agro, "Country Name", "2010", "2020", "2021", "2022")

'posso falar quem eu quero jogar fora com um - ou ! na frente'

agro_subbase <- select(agro_subbase, -"2010")

'posso mudar a ordem das minhas colunas também!'

agro_subbase <- select(agro_subbase,"Country Name", "2022", "2021", "2020")

'Não sei se vocês perceberam, mas eu salver um objeto por cima dele mesmo'
'muito cuidado! o R não vai te avisar e você pode fazer caca'

## filter (seleciona linhas) -----------------------------------------------

'Agora, vamos filtrar a base de dados'

'estamos com muitos paises, quero só alguns para o meu trabalho'

filter(agro_subbase, `Country Name` == "Brazil")

filter(agro_subbase, `2022` >= 50)

agro_subbase <- filter(agro_subbase, `Country Name` %in% c("Brazil", "Argentina", "Chile", "Colombia", "Paraguay"))

'o filter é similar ao select'
'select trabalha com colunas'
'filter com linhas'

## arrange (ordena a base) -------------------------------------------------

agro_subbase

'e se eu quiser mudar a ordem das minhas linhas?'

arrange(agro_subbase, `2022`)

arrange(agro_subbase, desc(`2022`)) # decrescente

'e se eu quiser ordenar minha tabela por ordem alfabética?'

agro_subbase <- arrange(agro_subbase, `Country Name`)

## rename (renomeando colunas) ---------------------------------------------

'não se se vocês repararam, quase sempre o nome das variáveis a gente escapou'
'entre aspas duplas ou acentos agudos, certo?'
'esses nomes da base agro não são legais para o R'
'tem espaço ou é só número'

agro_subbase <- rename(agro_subbase, "pais" = "Country Name",
                                     "ano_2022" = "2022")

'mas lucas, e se minha base tiver 200 variáveis?'
'vou ficar igual um bobo fazendo isso na mão?'

agro <- clean_names(agro)

'show até aqui?'

'chega da base agro, vamos brincar com outras coisas'

## distinct (ver valores únicos) -------------------------------------------

'vamos pegar a base da RAIS'
'ela tem muitas variáveis, mas eu quero saber quais são os município'
'ela tá na lógica do indivíduo'

distinct(rais, municipio)

nrow(distinct(rais, municipio)) # quantos municípios tem na base?)

distinct(rais, sexo)

# A MAGIA DO TIDYVERSE ----------------------------------------------------

'ele já faz tudo isso de uma vez só'
'ao contrário do R base, no tidyverse existe o pipe ou conector'

'CTRL + SHIFT + M' # Windows
'COMMAND + SHIFT + M'

# %>%

'qual é a lógica do pipe: ele me permite conectar comandos sem salvar bases temporárias'
'ele vai pegando o resultado do comando anterior e jogando no próximo'

rais1 <- select(rais, municipio, sexo, vl_remuneracao)

rais2 <- filter(rais1, sexo == "feminino")

rais3 <- arrange(rais2, desc(vl_remuneracao))

rais4 <- rename(rais3, salario = vl_remuneracao)

rais5 <- select(rais4, -sexo)

'OLHA A TRABALHEIRA!'
'veja a mágia acontecer'

rais %>%
  select(municipio, sexo, vl_remuneracao)

rais %>%
  select(municipio, sexo, vl_remuneracao) %>%
  filter(sexo == "feminino")

rais %>%
  select(municipio, sexo, vl_remuneracao) %>%
  filter(sexo == "feminino") %>%
  arrange(desc(vl_remuneracao)) %>%
  rename(salario = vl_remuneracao) %>%
  select(-sexo)

'ele vai pegando o resultado do comando anterior e jogando no próximo'
'essa cadeia de comandos todas: seleciono coluna, filtro linha, ordeno, renomeio coluna e jogo uma coluna fora'
'ai sim eu salvo!!!'

'exemplo 1'

rais_final <- rais %>%
  select(municipio, sexo, vl_remuneracao) %>%
  filter(sexo == "feminino") %>%
  arrange(desc(vl_remuneracao)) %>%
  rename(salario = vl_remuneracao) %>%
  select(-sexo)

'exemplo 2'

agro %>%
  clean_names() %>%
  select(country_name, contains("x202")) %>%
  filter(country_name %in% c("Brazil", "Argentina", "Chile", "Colombia", "Paraguay")) %>%
  arrange(desc(x2022))

'exemplo 3'

agro_final <- agro %>%
  clean_names() %>%
  select(country_name, contains("x202")) %>%
  filter(country_name %in% c("Brazil", "Argentina", "Chile", "Colombia", "Paraguay")) %>%
  arrange(desc(x2022))

'%>% é o operador pipe do tidyverse'
'existe o operador nativo do R |> (se >4.1)'

## mutate: criando novas variáveis -----------------------------------------

leitos

# Criando uma nova variável com o número de leitos por 1000 habitantes

mutate(leitos,leitos_1000 = leitos_total/pop*1000)

'jeito mais tidyverse'

leitos %>%
  mutate(leitos_1000 = leitos_total/pop*1000)

leitos %>%
  mutate(leitos_1000 = leitos_total/pop*1000,
         leitos_cirurgicos_1000 = leitos_cirurgicos/pop*1000,
         leitos_clinicos_1000 = leitos_clinicos/pop*1000)

'se eu quiser salvar isso em algum lugar'

leitos_pc <- leitos %>%
  mutate(leitos_1000 = leitos_total/pop*1000,
         leitos_cirurgicos_1000 = leitos_cirurgicos/pop*1000,
         leitos_clinicos_1000 = leitos_clinicos/pop*1000)

'e se eu me interessar só pelas variáveis novas que eu criei? quero jogar as originais fora'

leitos_pc <- leitos %>%
  mutate(leitos_1000 = leitos_total/pop*1000,
         leitos_cirurgicos_1000 = leitos_cirurgicos/pop*1000,
         leitos_clinicos_1000 = leitos_clinicos/pop*1000) %>%
  select(cod, leitos_1000, leitos_cirurgicos_1000, leitos_clinicos_1000) # forma burra

leitos_pc <- leitos %>%
  transmute(cod = cod, #pegando o código pra saber qual município é cada um
            leitos_1000 = leitos_total/pop*1000,
            leitos_cirurgicos_1000 = leitos_cirurgicos/pop*1000,
            leitos_clinicos_1000 = leitos_clinicos/pop*1000)

'transmute faz a mesma coisa que o mutate mas ele só traz as variáveis que você criou'

'mutate e transmute são dois comandos muito poderosos e que vocês vão usar muito
e eles podem ser combinados com outros comandos. dois super legais: ifelse e case_when'

leitos %>%
  mutate(pequeno_porte = ifelse(pop < 20000, "pequeno", "grande"))
'ifelse é uma função que faz teste lógico. se a condição for verdadeira, ele retorna o primeiro valor

se for falso, ele retorna o segundo valor. no caso, se a população for menor que 20 mil, ele retorna "pequeno", senão "grande"'

leitos %>%
  mutate(hpp = ifelse(leitos_total < 50, "hpp", "não é hpp"))
'se o número de leitos for menor que 50, ele retorna "hpp", senão "não é hpp"'

'o case_when é parecido com o ifelse mas me permite multiplas categorias'

leitos %>%
  mutate(porte = case_when(pop < 20000 ~ "pequeno",
                           pop >= 20000 & pop < 50000 ~ "médio",
                           pop >= 50000 & pop < 100000 ~ "grande",
                           pop >= 100000 ~ "grande pra cacete"))

'case_when é mais legível e mais fácil de usar quando você tem várias condições'
'e eu posso colocar dentro do mesmo mutate várias condições'

leitos_final <- leitos %>%
  mutate(pequeno_porte = ifelse(pop < 20000, "pequeno", "grande"),
         hpp = ifelse(leitos_total < 50, "hpp", "não é hpp"),
         porte = case_when(pop < 20000 ~ "pequeno",
                           pop >= 20000 & pop < 50000 ~ "médio",
                           pop >= 50000 & pop < 100000 ~ "grande",
                           pop >= 100000 ~ "grande demaisss"),
         leitos_1000 = leitos_total/pop*1000,
         leitos_cirurgicos_1000 = leitos_cirurgicos/pop*1000,
         leitos_clinicos_1000 = leitos_clinicos/pop*1000)

table(leitos_final$porte)
table(leitos_final$hpp)
table(leitos_final$pequeno_porte)

'show até aqui?'

## pivot_longer e pivot_wider: pivotando a nossa base ----------------------

leitos

'lembrem-se que o tidyverse tem uma forma diferente de organizar os dados
ele organiza os dados em long e wide. o long é mais fácil de trabalhar, mas o wide é mais fácil de ler'

'no wide, cada variável é uma coluna e cada observação é uma linha. no long, cada variável 
é uma linha e cada observação é uma coluna'

'no wide, a gente tem várias colunas com o mesmo tipo de informação. 
no long, a gente tem uma coluna com o tipo de informação e outra com o valor'

'fazer figuras é mais fácil com a base em long, rodar modelos é mais fácil com a base em wide, por exemplo'

leitos

'nossa base de leitos tá no formato wide!'

leitos %>%
  pivot_longer(cols = c(leitos_total, leitos_cirurgicos, leitos_clinicos),
               names_to = "tipo_leito",
               values_to = "n_leitos")


leitos_long <- leitos %>%
  pivot_longer(cols = !c(cod, pop),
               names_to = "tipo_leito",
               values_to = "n_leitos")

leitos
leitos_long
'ele pegou todas as colunas menos o cod e a pop e transformou em duas colunas: tipo_leito e n_leitos
é a mesma base, são as mesmas informações. só está organizado de forma diferente!'

'se eu quiser fazer o contrário, ou seja, transformar a base em wide, eu uso o pivot_wider'

leitos_long %>%
  pivot_wider(names_from = tipo_leito,
              values_from = n_leitos)
'ele pegou a coluna tipo_leito e transformou em várias colunas, uma para cada tipo de leito
e colocou os valores na coluna n_leitos'

leitos_wide <- leitos_long %>%
  pivot_wider(names_from = tipo_leito,
              values_from = n_leitos)


'ele fez o contrário do que a gente fez antes! voltamos pra nossa base original'

leitos == leitos_wide
'ele é igual! a gente só mudou a forma de organizar os dados, mas as informações são as mesmas'

# A gente pode usar o pivot_longer e o pivot_wider pra organizar os dados da forma que a gente quiser

## joins: juntando duas ou mais bases de dados! ----------------------------

'estamos com 3 bases que precisamos juntar: leitos + casos_dengue + mortes_dengue'
'essas bases são de fontes diferentes e, portanto, vieram em arquivos diferentes'
'leitos: cadastro nacional de estabelecimentos de saúde (CNES)'
'casos de dengue: sistema de informação de agravos de notificação (SINAN)'
'mortes de dengue: sistema de informação de mortalidade (SIM)'

'vamos juntar todo mundo!'

'left_join()'
'right_join()'
'full_join()'
'inner_join()'

'a sintaxe é a mesma _join(base_esquerda, base_direita, by = "variável_de_junção ou chave")'

left_join(leitos, casos_dengue, by = join_by("cod"))
'ele pegou a base da esquerda (leitos) e juntou com a base da direita (casos_dengue)'
'sempre preste atenção no número de linha resultante!'

nrow(leitos)
nrow(casos_dengue)
nrow(left_join(leitos, casos_dengue, by = join_by("cod")))

'em situações assim, tanto faz eu usar left, right, full ou inner join'

base_final <- left_join(leitos, casos_dengue, by = join_by("cod"))

'vamos dar uma olhada na mortes_dengue agora!'

nrow(mortes_dengue)

'agora vai fazer diferença'
'e agora o nome das colunas não é o mesmo! (fui maldoso!)'

inner_join(leitos, mortes_dengue, by = join_by("cod"=="codmun")) # 104 linhas

full_join(leitos, mortes_dengue, by = join_by("cod"=="codmun")) # 853 linhas

left_join(leitos, mortes_dengue, by = join_by("cod"=="codmun")) # 853 linhas

right_join(leitos, mortes_dengue, by = join_by("cod"=="codmun")) # 104 linhas

'viram?'

'como juntamos as tres bases? temos que fazer par a par!'

base_final <- left_join(leitos, casos_dengue, by = join_by("cod")) %>%
  left_join(mortes_dengue, by = join_by("cod"=="codmun"))

'ficou cheio de missing (NA) na nossa base né. são os municípios onde não morreu ninguém por dengue!'

'IMPORTANTE: missing x dados faltantes'

'no nosso caso nossa informação é zero. não é faltante'

base_final <- left_join(leitos, casos_dengue, by = join_by("cod")) %>%
  left_join(mortes_dengue, by = join_by("cod"=="codmun")) %>%
  mutate(mortes_dengue = ifelse(is.na(mortes_dengue), 0, mortes_dengue))

## group_by e summarise ----------------------------------------------------

'group_by e summarise são dois comandos que trabalham juntos'
'eles me permitem agrupar os dados por uma ou mais variáveis e calcular estatísticas resumidas'

rais

rais %>%
  group_by(municipio) 
'aparentemente não mudou nada'

rais %>%
  group_by(municipio) %>%
  summarise(media_salario = mean(vl_remuneracao, na.rm = TRUE))

'o summarise tem a lógica parecida com o mutate! a diferença é que ele muda a unidade de observaçã'
'o mutate não'

rais %>%
  group_by(municipio) %>%
  mutate(media_salario = mean(vl_remuneracao, na.rm = TRUE))

'posso fazer várias descritivas também!'

rais %>%
  group_by(municipio) %>%
  summarise(media_salario = mean(vl_remuneracao, na.rm = TRUE),
            mediana_salario = median(vl_remuneracao, na.rm = TRUE),
            desvio_padrao_salario = sd(vl_remuneracao, na.rm = TRUE),
            n_trabalhadores = n()) # número de observações

'importante 1, sempre use o na.rm = TRUE'
'importante 2, sempre desagrupe!!!!'

rais %>%
  group_by(municipio) %>%
  summarise(media_salario = mean(vl_remuneracao, na.rm = TRUE),
            mediana_salario = median(vl_remuneracao, na.rm = TRUE),
            desvio_padrao_salario = sd(vl_remuneracao, na.rm = TRUE),
            n_trabalhadores = n()) %>% # número de observações
  ungroup() # desagrupa a base

"OUUU"

rais %>%
  group_by(municipio) %>%
  summarise(media_salario = mean(vl_remuneracao, na.rm = TRUE),
            mediana_salario = median(vl_remuneracao, na.rm = TRUE),
            desvio_padrao_salario = sd(vl_remuneracao, na.rm = TRUE),
            n_trabalhadores = n(), .groups = 'drop')

"OUUU"

rais %>%
  group_by(municipio) %>%
  reframe(media_salario = mean(vl_remuneracao, na.rm = TRUE),
            mediana_salario = median(vl_remuneracao, na.rm = TRUE),
            desvio_padrao_salario = sd(vl_remuneracao, na.rm = TRUE),
            n_trabalhadores = n())

'reframe = summarise + ungroup'

## write_: salvando o resultado ----------------------------------------------------

'dica bonus pra gente preguiçosa'

'lembram quando a gente leu as bases que era read_ alguma coisa?'
'existe o write_ alguma coisa também'
'vamos supor que to com minha tabelinha pronta pra colocar no meu trabalho'
'como eu salvo esse treco?'

agro %>%
  clean_names() %>%
  select(country_name, contains("x202")) %>%
  filter(country_name %in% c("Brazil", "Argentina", "Chile", "Colombia", "Paraguay")) %>%
  arrange(desc(x2022)) %>%
  write_excel_csv2("agro_final.csv")

'agora eu tenho um arquivo chamado agro_final.csv na minha pasta de trabalho'
'e essa tabela não ficou salva na minha memória RAM'
