import matplotlib.pyplot as plt

duree_chauffe = [0.1, 1, 10]
ord1 = [23, 332, 3973]

plt.suptitle("Evolution du temps de calcul en fonction de la duree de chauffage")
plt.plot(duree_chauffe, ord1, "rs-", label="Ubuntu 22.04.3 & LAMMPS 29 Sep 2021")
plt.legend(loc="upper right")
plt.xlabel("Duree de chauffage (ns)")
plt.ylabel("Duree du calcul (s)")
plt.xscale("log")
plt.legend()
plt.text(duree_chauffe[0], ord1[0], s="23 s", fontsize=9, ha="right")
plt.text(duree_chauffe[1], ord1[1], s="5 min 32 s", fontsize=9, ha="right")
plt.text(duree_chauffe[2], ord1[2], s="1 h 6 min 16 s", fontsize=9, ha="right")
plt.show()
plt.close()
