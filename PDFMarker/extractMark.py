import csv
import fitz

# read
path = input("path: ")
if input("sure? (y/n): ") == "n": exit()
pdf = fitz.open(path)
toc = pdf.getToC()

# write
with open('toc.csv', mode='w', newline='', encoding='UTF-8') as f:
    f_writer = csv.writer(f)
    for i in range(len(toc)):
        f_writer.writerow(toc[i])