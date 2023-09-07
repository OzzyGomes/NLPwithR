#Segundo test - Fianancial Sentiment Dataset
library("dplyr")
library("tidytext")
library("wordcloud")
library("stringr")
library("SnowballC")
library("tibble")

# Vamos usar o Financial Sentiment Dataset
dados_totais <- read.csv("Financial Sentiment.csv")
dados_totais <- as_tibble(dados_totais)


# pegando só a primeira coluna pois essa não será uma analise de sentimentos
dados <- dados_totais[,1]

# trasformando meu df tibble em tokens
#                       nome da noca coluna,      nome da coluna antiga
dados_unnested <- dados %>% unnest_tokens(word, Sentence)

#Vamos retirar números - pode ser qualquer coisa
dados_unnested <- dados %>%  unnest_tokens(word, Sentence) %>% filter(!grepl('[0-9]', word))


