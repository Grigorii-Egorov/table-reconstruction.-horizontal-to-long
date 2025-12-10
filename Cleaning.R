library(readxl)
library(openxlsx)


#Тут путь в папку с оригинальными файлами
folder_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rusagro/Простои/hwga"

#Тут путь в новую папку
new_folder_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rusagro/Простои/WorkR"

process_excel <- function(file_path) {
  sheet_names <- excel_sheets(file_path)
  wb <- createWorkbook()
  sheets_to_remove <- c("простои", "общ выработка", "Ф.И.О", "ОЕЕ", "выр ка")
  
  for (sheet in sheet_names) {
    if (!(sheet %in% sheets_to_remove)) {
      df <- read_excel(file_path, sheet = sheet)
      

# Найти строку с именем "Плановые простои"
      row_name1 <- "ПЛАНОВЫЕ ПРОСТОИ"
      row_number1 <- which(df[, 1] == row_name1)
      
      # Удалить все данные после найденной строки
      if (length(row_number1) > 0) {
        df <- df[(row_number1):nrow(df), ]
      }
      
      # Найти строку с именем "Ежемесячная инвентаризация"
      row_name <- "неучтенное время, мин"
      row_number <- which(df[, 1] == row_name)
      
      # Удалить все данные после найденной строки
      if (length(row_number) > 0) {
        df <- df[1:row_number, ]
      }
      
      addWorksheet(wb, sheet)
      writeData(wb, sheet, df)
    }
  }
  
  new_file_path <- file.path(new_folder_path, paste0("modified_", basename(file_path)))
  saveWorkbook(wb, new_file_path, overwrite = TRUE)
}

files <- list.files(folder_path, pattern = "*.xlsx", full.names = TRUE)
files <- files[!grepl("~\\$", files)]  # Исключаем временные файлы
lapply(files, process_excel)

