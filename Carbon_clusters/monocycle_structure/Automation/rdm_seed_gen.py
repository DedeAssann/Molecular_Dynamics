"Ce fichier python a pour but de generer un ensemble de nombre a 8 chiffres aleatoires"
from random import choice, randint

def random_gen():
    "..."
    generated_number = str(randint(1, 9)) + str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9))
    return generated_number

def sample_gen(N : int):
    "..."
    with open("./seed.txt", "a", encoding="utf-8") as file:
        for i in range(N+1):
            file.write(random_gen()+"\n")
        file.close()


if __name__ == "__main__":
    N = int(input( "Veuillez entre le nombre de valeur aleatoires que vous voulez ecrire dans le fichier : " ))
    sample_gen(N)

