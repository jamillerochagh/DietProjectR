library(ggplot2)
library(readxl)

# Defina uma semente para geração de números aleatórios
set.seed(432)

# Importe os dados do Excel (substitua "seuarquivo.xlsx" pelo nome do seu arquivo Excel)
dados <- Taco_4a_edicao_2011  # Substitua "seuarquivo.xlsx" pelo nome do seu arquivo Excel

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

# Embaralhe as linhas do conjunto de dados
dados_aleatorios <- dados[sample(nrow(dados)), ]

# Crie um subconjunto dos dados com 7 pontos (por exemplo, os 7 primeiros pontos)
subset_dados <- head(dados_aleatorios, 7)

# Adicione a coluna "preço" com valores de 1 a 7
subset_dados$preço <- c(3.5, 0.62, 0.27, 2, 1.44, 0.78, 1.5)  # Coloque os valores em um vetor

# Ordene os dados pelo preço em ordem crescente
subset_dados <- subset_dados[order(subset_dados$preço),]


# Crie o gráfico de dispersão com a linha de regressão linear
ggplot(data = subset_dados, aes(x = preço, y = Proteínas, label = Alimentos)) +
  geom_point(size = 3) +  # Adiciona pontos de dispersão
  geom_smooth(method = "lm", se = FALSE) +  # Adiciona uma linha de regressão linear
  geom_text(hjust = -0.2, vjust = 0.2, size = 3) +  # Adiciona rótulos dos pontos
  labs(x = "Preço", y = "Proteínas") +  # Rótulos dos eixos
  ggtitle("Regressão Linear: Proteínas vs. Preço") +  # Título do gráfico
  scale_x_continuous(name = "Preço", breaks = seq(0, 3.5, by = 0.5), limits = c(0, 4)) + # Define os valores do vetor "preço" no eixo x e limita a faixa
  theme_minimal()
  
