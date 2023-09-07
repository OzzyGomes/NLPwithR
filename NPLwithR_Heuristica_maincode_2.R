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

#anti Join para me livrar das stop_words, palavras que não me trazem informações relevantes 
dados_unnested <- dados_unnested %>% anti_join(stop_words)

#criando uma nova coluna com as palavras mais citadas no df
common <- dados_unnested %>% count(word, sort = TRUE)

#definindo paleta de cores para word cloud
pal <- brewer.pal(8, 'Dark2')

# word cloud
common %>% with(wordcloud(word, n, random.order = FALSE, max.words = 50, colors=pal))



#Stemming - vamos aplicar 
dados_unnested_stem <-  dados_unnested %>%  mutate(stem = wordStem(word)) 

dados_unnested_stem_count <- dados_unnested_stem %>%  mutate(stem = wordStem(word)) %>% count(stem, sort = TRUE)
