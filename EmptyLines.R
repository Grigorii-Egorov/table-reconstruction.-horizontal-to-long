library("readxl")
library("dplyr")
library("openxlsx")

file_path <- "/Users/grigoriiegorov/Library/Mobile Documents/com~apple~CloudDocs/Work/Rysagro/Простои/resulthwga.xlsx"

process_excel <- function(file_path) {
  sheet_names <- excel_sheets(file_path)
  wb <- createWorkbook()
  
  for (sheet in sheet_names) {
    df <- read_excel(file_path, sheet = sheet)
    
    # Удаляем строки, где заполнены только столбцы B, C, D, E, а остальные пусты
    df <- df %>% filter(!(is.na(filename) | is.na(sheetname)) & rowSums(!is.na(df[, -c(2, 3, 4, 5)])) > 0)
    
    addWorksheet(wb, sheet)
    writeData(wb, sheet, df)
  }
  
  new_file_path <- file.path(dirname(file_path), paste0("cleaned_", basename(file_path)))
  saveWorkbook(wb, new_file_path, overwrite = TRUE)
}

process_excel(file_path)


