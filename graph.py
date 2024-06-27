import pandas as pd
import matplotlib.pyplot as plt
import chardet
import openpyxl

# from git.RandomPrograms.li_dokiman import li_csv

# import numpy


def read_data(filepath: str):
    "..."
    coord = pd.read_csv(filepath, delimiter="\s+", header=0)
    return coord["Step"], coord["PotEng"], coord["Temp"]


def graph(abscisse, ordonnee1, ordonnee2):
    "..."
    # plt.title(
    #  "Avancement de la formation du Cluster et de la temperature en fonction du temps"
    # )
    plt.subplot(121)
    plt.plot(abscisse, ordonnee1, "*")
    plt.xlabel("Time (10^-16 s)")
    plt.ylabel("Potential Energy")
    plt.subplot(122)
    plt.plot(abscisse, ordonnee2, "*")
    plt.xlabel("Time (10^-16 s)")
    plt.ylabel("Temperature (K)")
    plt.show()


PATH = "data.txt"
# lecture du fichier
with open(PATH, "rb") as file:
    raw_data = file.read()
    # dialect = csv.Sniffer().sniff(file.read(1024))
    # separator = dialect.delimiter
    # print(f"Detected separator: {separator}")
    # for string in csv_string:
    #    print(string)

# Detect the encoding of the file
result = chardet.detect(raw_data)
encoding = result["encoding"]
print(encoding)

# csv_file = StringIO(csv_string)
# Creation du Pandas Dataframe
df = pd.read_csv(
    PATH, sep=None, encoding=encoding, error_bad_lines=False, warn_bad_lines=True
)
# print(df.sep)

# Écrire les données dans un fichier Excel
df.to_excel("./Mol_dyna.xlsx")


# if __name__ == "__main__":
# abscisse, ordonnee1, ordonnee2 = read_data("data0.txt")
# graph(abscisse, ordonnee1, ordonnee2)
