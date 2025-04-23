make_photo_path <- function(species){

# Map selected species to corresponding image path
photo_file <- switch(species,
                     "Acropora cervicornis" = "www/Staghorn.png",
                     "Acropora palmata" = 'www/Elkhorn.png',
                     "Orbicella annularis" = 'www/Orbicella annularis.jpg',
                     "Orbicella franksi" = 'www/Orbicella franksi.png',
                     "Agaricia agaricites" = 'www/original-1.jpg',
                     "Orbicella faveolata" = 'www/orbfav.png',
                     "Meandrina meandrites" = 'www/maze.jpg',
                     "Dendrogyra cylindrus" = 'www/pillar.png',
                     "Pseudodiploria strigosa" = 'www/symbrain.jpg',
                     "Diploria labyrinthiformis" = 'www/groovebrain.jpg',
                     "Colpophyllia natans" = 'www/colpnat.jpg',
                     "Siderastrea siderea" = 'www/red.jpg',
                     "Porites astreoides" = 'www/coralsoftheworld.jpg',
                     "Montastraea cavernosa" = 'www/star.jpg',
                     "Stephanocoenia intersepta" = 'www/large.jpg',
                     "Tubastraea coccinea" = 'www/Suncoral1.jpg',
                     "Siderastrea radians" = 'www/222.jpg',
                     "Porites porites" = 'www/original.jpeg',
                     "Porites furcata" = 'www/branch.jpg',
                     "Porites divaricata" = 'www/thin.jpeg',
                     "Agaricia lamarcki" = 'www/plate.jpeg'
)

base_path <- "/Users/juliamateski/NCRMP_Shiny_App/"

image_path <- paste(base_path, photo_file, sep = "")

return(image_path)

}
