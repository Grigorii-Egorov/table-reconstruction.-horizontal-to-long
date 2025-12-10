library("readxl")
library("dplyr")
library("purrr")
library("openxlsx")

folder_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/WorkR"

file_list <- list.files(path = folder_path, pattern = "*.xlsx", full.names = TRUE)
file_list <- file_list[!grepl("~\\$", file_list)]  # Исключаем временные файлы

# Функция для преобразования всех столбцов в текстовый формат
convert_to_character <- function(df) {
  df <- df %>% mutate(across(everything(), as.character))
  return(df)
}

# Функция для добавления недостающих столбцов и строк
add_missing_columns_and_rows <- function(df, max_cols) {
  current_cols <- ncol(df)
  
  if (current_cols < max_cols) {
    for (i in (current_cols + 1):max_cols) {
      df[[paste0("V", i)]] <- NA
    }
  }
  
  return(df)
}

# Определяем максимальное количество столбцов
max_cols <- file_list %>%
  map_dbl(function(file) {
    sheets <- excel_sheets(file)
    max(map_dbl(sheets, function(sheet) {
      ncol(read_excel(file, sheet = sheet))
    }))
  }) %>%
  max()

all_data <- file_list %>%
  map_df(function(file) {
    sheets <- excel_sheets(file)
    map_df(sheets, function(sheet) {
      df <- read_excel(file, sheet = sheet) %>%
        mutate(filename = file, sheetname = sheet)
      df <- convert_to_character(df)
      df <- add_missing_columns_and_rows(df, max_cols)
      return(df)
    })
  })

print(all_data)

pivot_data <- all_data %>%
  group_by(sheetname)

write.xlsx(pivot_data, "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/resulthwga.xlsx")

