import matplotlib.pyplot as plt

duree_chauffe = [0.1, 1, 10, 100]
ord1 = [27.47, 82.65, 99.95, 100]
ord2 = [27.47, 91.11, 96.19, 100]

plt.suptitle(
    "Pourcentage de formation du cluster C8 en fonction de la duree de chauffage"
)
plt.plot(duree_chauffe, ord1, "rs-", label="Ubuntu 22.04.3 & LAMMPS 29 Sep 2021")
plt.plot(duree_chauffe, ord2, "go-", label="Ubuntu 24.04 & LAMMPS 7 Feb 2024")
plt.legend(loc="upper right")
plt.xlabel("Duree de chauffage (ns)")
plt.ylabel("Pourcentage de formation (%)")
plt.xscale("log")
plt.legend()
for i, txt in enumerate(ord1):
    plt.text(duree_chauffe[i], ord1[i], f"{txt}%", fontsize=9, ha="right")
for i, txt in enumerate(ord2):
    plt.text(duree_chauffe[i], ord2[i], f"{txt}%", fontsize=9, ha="right")
plt.show()
plt.close()
