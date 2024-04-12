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

# Criar categorias com base nas quantidades de proteínas
dados$CategoriaProteinas <- cut(dados$Proteínas,
                                breaks = c(0, 10, 20, 40),
                                labels = c("Baixa (0-10g)", "Média (10-20g)", "Alta (20-40g)"))

# Selecionar 9 valores aleatórios
set.seed(345)  # Define uma semente para garantir reprodutibilidade
dados_amostra <- dados[sample(nrow(dados), 9), ]

# Criar uma nova variável com os primeiros três nomes de cada alimento
dados_amostra$PrimeirosDoisNomes <- sapply(strsplit(dados_amostra$Alimentos, " "), function(x) paste(x[1:3], collapse = " "))

# Criar um gráfico de dispersão com energia no eixo x e os primeiros dois nomes dos alimentos acima dos pontos sem sobreposição
ggplot(dados_amostra) +
  aes(x = Energia, y = Proteínas, color = CategoriaProteinas, label = PrimeirosDoisNomes) +
  geom_point() +
  geom_text_repel(vjust = -0.5) + # Coloca os primeiros dois nomes acima dos pontos 
  ggtitle("Dispersão: Proteínas vs. Energia") +  # Título do gráfico
  theme_minimal()



