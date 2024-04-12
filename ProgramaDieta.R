library(ggplot2)
library(ggrepel)

# Declarando a variável dados
dados <- Taco_4a_edicao_2011

# Renomeando as colunas
colnames(dados)[2] <- "Alimentos"
colnames(dados)[6] <- "Proteínas"
colnames(dados)[7] <- "Gorduras"
colnames(dados)[9] <- "Carboidratos"
colnames(dados)[4] <- "Energia"

# Substitua todas as strings nas colunas 6, 7 e 9 por NA
dados$Proteínas <- as.numeric(gsub("[^0-9.]", "", dados$Proteínas))
dados$Gorduras <- as.numeric(gsub("[^0-9.]", "", dados$Gorduras))
dados$Carboidratos <- as.numeric(gsub("[^0-9.]", "", dados$Carboidratos))
dados$Energia <- as.numeric(gsub("[^0-9.]", "", dados$Energia))

# Arredondar os valores
dados$Proteínas <- round(dados$Proteínas)
dados$Gorduras <- round(dados$Gorduras)
dados$Carboidratos <- round(dados$Carboidratos)
dados$Energia <- round(dados$Energia)

# Solicitar ao usuário as metas de carboidratos, proteínas e gorduras
meta_carboidratos <- 8
meta_proteinas <- 2
meta_gorduras <- 1

# Filtrar os alimentos que atendem às metas
alimentos_filtrados <- dados[dados$Carboidratos <= meta_carboidratos &
                               dados$Proteínas <= meta_proteinas &
                               dados$Gorduras <= meta_gorduras, ]

# Selecionar apenas as colunas desejadas
resultado <- alimentos_filtrados[, c("Alimentos", "Energia", "Proteínas", "Carboidratos", "Gorduras")]

# Remover linhas com NA
resultado <- na.omit(resultado)

# Ordenar o dataframe com base na proximidade das metas
resultado$Compatibilidade <- abs(resultado$Carboidratos - meta_carboidratos) +
  abs(resultado$Proteínas - meta_proteinas) + abs(resultado$Gorduras - meta_gorduras)
resultado <- resultado[order(resultado$Compatibilidade), ]

# Exibir os resultados
print(resultado)
