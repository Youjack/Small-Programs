import csv
import fitz

# read
path1 = input("path1: ")
path2 = input("path2: ")
if input("sure? (y/n): ") == "n": exit()
pdf1 = fitz.open(path1)
pdf2 = fitz.open(path2)

# join
pdf1.insertPDF(pdf2)
pdf1.save("joinedPDF.pdf", encryption=False)