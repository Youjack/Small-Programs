import csv
import fitz

# read
toc = []
with open('toc.csv', mode='r', encoding='UTF-8') as f:
    f_reader = csv.reader(f)
    for row in f_reader:
        row[0] = int(row[0])
        row[2] = int(row[2])
        toc.append(row)

# write
path = input("path: ")
if input("sure? (y/n): ") != "y": exit()
pdf = fitz.open(path)
pdf.setToC(toc)
pdf.save(path, incremental=True, encryption=False)