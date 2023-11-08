<?php
    $bdd = new Data();
    $result = '';

    if(isset($_POST) && !empty($_POST)){
        $start_time = microtime(true);

        // On revient d'un formulaire
        $largeur = $_POST['form_x'];
        $hauteur = $_POST['form_y'];
        $case = $_POST['form_case'];

        require 'class/maze.class.php';
        $maze = new Maze($largeur,$hauteur , $case);

        if(isset($_FILES) && !empty($_FILES) && !empty($_FILES['my_file']['name'])) {
            // Generation d'un nom unique
            $tab_name = explode('.',$_FILES['my_file']['name']);
            $unique_name = uniqid('img_').'.'.$tab_name[count($tab_name)-1];

            // Préparation de l'upload
            $uploaddir = 'images/mask/';
            $uploadfile = $uploaddir . $unique_name;
            if (move_uploaded_file($_FILES['my_file']['tmp_name'], $uploadfile)) {
                $maze->addMask($uploadfile);
                @unlink($uploadfile);
            }
        } else {
            if (!empty($_POST['form_mask'])) {
                $maze->addMask('images/mask/' . $_POST['form_mask']);
            }
        }
        $maze->generateMaze();
        $image_labyrinthe = $maze->drawMazePic();

        $end_time = microtime(true);
        $elapsed_time = ($end_time - $start_time) * 1000;

        // Mise en forme du resultat
        $result.= '<div class="zone_maze">';
        $result.= '     '.$image_labyrinthe;
        $result.= '     <br/><small><i>Génération du Labyrinthe en '.ceil($elapsed_time).' ms</i></small>';

        $result.= '</div>';
    }

    // Mise en forme du formulaire
    $html = '   <div class="form-style">';

    // Gestion du Titre de la page
    $html .= '       <h1>Labyrinthe<span>Génération d\'un labyrinthe...</span></h1>';


    // Debut du Formulaire HTML
    $html.= '       <form method="POST" action="index.php?page=maze" enctype="multipart/form-data">';

    // Nom et Prénom
    $html.= '           <div class="section"><span>1</span>Taille de l\'image et largeur du chemin</div>';
    $html.= '           <div class="inner-wrap-l">';
    $html.= '               <label>Largeur (en pixel) <input type="text" name="form_x" value="500"/></label>';
    $html.= '               <label>hauteur (en pixel) <input type="text" name="form_y" value="500"/></label>';
    $html.= '               <label>Largeur du Chemin (en pixel)<input type="text" name="form_case" value="10"/></label>';
    $html.= '           </div>';
    $html.= '           <div class="inner-wrap-r">';
    $html.= '               <label>Masque (PNG en noir et blanc, sera redimensionné à la taille du labyrinthe)<br/><br/> <input type="file" name="my_file" /></label>';
    $html.= '           </div>';
    $html.= '           <div class="inner-wrap-r">';
    $html.= '               <label>Selection masque pré - existant ';
    $html.= '                   <select name="form_mask">';
    $html.= '                       <option value=""> - Sélection Masque - </option>';
    $html.= '                       <option value="smiley.png"> Smiley </option>';
    $html.= '                       <option value="minecraft.png"> Minecraft </option>';
    $html.= '                       <option value="etoile.png"> Etoile </option>';
    $html.= '                       <option value="pikachu.png"> Pikachu </option>';
    $html.= '                   </select>';
    $html.= '               </label>';
    $html.= '           </div>';
    $html.= '           <div style="clear:both;"></div>';


    // Bouton Enregistrer
    $html.= '           <div class="button-section">';
    $html.= '               <input type="submit" value="Générer" />';
    $html.= '           </div>';

    $html.= '       </form>';

    // Affichage du resultat
    $html.= $result;

    $html.= '   </div>';
?>