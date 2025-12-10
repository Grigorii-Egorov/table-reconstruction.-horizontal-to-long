#Add essentia packages
library(readxl)
library(openxlsx)
library(writexl)
library(corrplot)
library(dplyr)
library(tidyr)
library(ggplot2)
library(EnvStats)
library(RColorBrewer)
library(reshape2)
library(readr)


# Load the data
file_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/resulthwga.xlsx"
data <- read_excel(file_path, sheet = "Sheet 1")

# Clean column names to remove any extra spaces
colnames(data) <- trimws(colnames(data))

# Print column names to confirm
print(colnames(data))

# Identify the range of columns manually based on the printed names
# Assuming columns 7 to 68 (or adjust based on what `print(colnames(data))` shows)
data_long <- data %>%
  pivot_longer(
    cols = 7:68,  # Update these numbers if necessary
    names_to = "Day_Period",
    values_to = "Value"
  )

# View the transformed data to confirm
head(data_long)

data_long_short <- data_long %>%
  drop_na(Value)
head(data_long_short)

# Установка директории для сохранения файла
file_path_long <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/data_long.csv"
file_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/data_long_short.xlsx"
# Сохранение файла в указанную директорию
write_xlsx(data_long_short, file_path)
write.csv(data_long, file_path_long)

write_xlsx(data_long, file_path)

# Сначала сохранить без BOM
write.csv(data_long, file_path_long, row.names = FALSE, fileEncoding = "UTF-8")

# Потом добавить BOM вручную
lines <- readLines(file_path_long, encoding = "UTF-8")
writeLines(c("\ufeff", lines), file_path_long, useBytes = TRUE)
