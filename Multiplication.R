#Add essentia packages
library(readxl)
library(openxlsx)
library(writexl)
library(corrplot)
library(dplyr)
library(ggplot2)
library(EnvStats)
library(RColorBrewer)
library(reshape2)



#Import excel file
data <- read_excel(path = '/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/book1.xlsx')


data %>% select(6)
data %>% select(68)

dataset <- data %>% select(6:68)

class(dataset$`60`)
dataset$'50' <- as.numeric(dataset$'50')

dataset[is.na(dataset)] <- 0

# Умножение столбца x на каждый столбец в dataframe
ilt <- as.data.frame(lapply(dataset, function(col) col * dataset$time))
ilt <- ilt %>%
  select(-time)

ilt <- ilt %>%
  select('2', '7')


# Установка директории для сохранения файла
file_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/ilt.xlsx"
# Сохранение файла в указанную директорию
write_xlsx(ilt, file_path)




