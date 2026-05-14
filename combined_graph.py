from PIL import Image

# Ouvrir les deux images
image1 = Image.open(
    "C:/Users/dedea/Dropbox/PC/Documents/Molecular_Dynamics/Molecular_Dynamics/Image_Tungsten/bcc_54_chauffe_graph.png"
)
image2 = Image.open(
    "C:/Users/dedea/Dropbox/PC/Documents/Molecular_Dynamics/Molecular_Dynamics/Image_Tungsten/bcc_54_chauffe_graph_0.png"
)

# Assurez-vous que les images ont la même taille
image1 = image1.resize((800, 600))
image2 = image2.resize((800, 600))

# Superposer les images avec une transparence
combined = Image.blend(image1, image2, alpha=0.5)

# Enregistrer l'image combinée
combined.save("combined_image.png")

# Afficher l'image combinée
combined.show()
