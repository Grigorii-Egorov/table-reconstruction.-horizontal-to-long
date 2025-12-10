# table-reconstruction.-horizontal-to-long
preparations for a transfer to SQL. horizontal table to long table

# Table Reconstruction & Transformation Pipeline (R)

This repository contains a set of modular R scripts that convert several complex horizontal tables into one clean, structured long-format dataset.  
The workflow consists of five sequential steps:

1. **Cleaning**  
2. **Merging into one file**  
3. **Removing empty lines**  
4. **Transforming into long data**  
5. **Multiplication / final calculations**

Each step is isolated into its own script for clarity and reproducibility.

---

## Project Structure

Cleaning.R         # Step 1: Initial cleanup of raw tables
One File.R         # Step 2: Combine all cleaned tables into a single dataset
EmptyLines.R       # Step 3: Detect and remove empty or corrupted rows
Long_data.R        # Step 4: Convert wide/horizontal tables into long format
Multiplication.R   # Step 5: Apply scaling, calculations, and final adjustments

---

## Workflow Overview

### **1. Cleaning**
- Import raw tables (multiple horizontal files).
- Standardize column names.
- Remove unnecessary characters, footnotes, spaces.
- Prepare consistent structure for merging.

### **2. One File**
- Bind all cleaned tables into a single dataset.
- Align rows and columns.
- Ensure that shared keys match across files.

### **3. EmptyLines**
- Identify rows that contain only `NA`, blanks, or artifacts.
- Remove technical empty lines created during import or merging.
- Produce a structurally clean dataset ready for reshaping.

### **4. Long Data**
- Reshape from horizontal (wide) to long format.
- Use `pivot_longer()` / `melt()` to stack values under shared variables.
- Create standardized variable, value, and identifier columns.

### **5. Multiplication**
- Apply scaling factors or multipliers to numeric columns.
- Compute derived variables.
- Export final processed dataset.

---

## How to Run

Run each script in the following order:

Cleaning.R
One File.R
EmptyLines.R
Long_data.R
Multiplication.R


## Note

Data and sources are not included due to the corporate restrictions :)



