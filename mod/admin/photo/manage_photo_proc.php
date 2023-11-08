<?php
$bdd = new Data();

if(isset($_POST) && !empty($_POST)){
    // On revient d'un formulaire

    // Préparation des informations récuperées du formulaire
    $h = array();
    $h['ordre'] = $_POST['form_ordre'];

    // Gestion de l'avatar
    if(isset($_FILES) && !empty($_FILES) && !empty($_FILES['my_file']['name'])){
        // Generation d'un nom unique
        $tab_name = explode('.',$_FILES['my_file']['name']);
        $unique_name = uniqid('img_').'.'.$tab_name[count($tab_name)-1];

        // Préparation de l'upload
        $uploaddir = 'images/galerie/';
        $uploadfile = $uploaddir . $unique_name;
        if (move_uploaded_file($_FILES['my_file']['tmp_name'], $uploadfile)) {
            require 'class/image.class.php';
            $img = new Image($uploadfile);

            // On force image carrée de 512 par 512
            $img->resizeByMin(512);
            $img->cropSquare();
            $img->store($uploadfile);

            $h['photographie'] = $unique_name;
        }
    }

    // Test pour savoir si on ajoute ou on modifie
    if($_POST['id_photo'] > 0){
        // Update de BDD
        $id_photo = $_POST['id_photo'];
        $bdd->sql_update('t_photo',$id_photo, $h);
    }else{
        // Ajout en BDD
        $h['fk_user'] = $_SESSION[SESSION_NAME]['id_user'];
        $id_photo = $bdd->sql_insert('t_photo',$h);
    }

    // Traduction
    $sql = "DELETE FROM t_photo_trad WHERE fk_photo=".$id_photo;
    $bdd->query($sql);

    $sql = "SELECT * FROM t_langue";
    $datas_langue = $bdd->getData($sql);
    foreach($datas_langue as $data_langue) {
        $h = array();
        $h['fk_photo'] = $id_photo;
        $h['fk_langue'] = $data_langue['id'];
        $h['titre'] = $_POST['form_titre_'.$data_langue['id']];
        $h['description'] = $_POST['form_description_'.$data_langue['id']];
        $bdd->sql_insert('t_photo_trad',$h);
    }

    // Redirection
    header('Location: index.php?page=manage_photo&id_photo='.$id_photo);
}

// Vérification pour Ajout / Modification
if (isset($_GET['id_photo']) && !empty($_GET['id_photo'])) {
    // Modification
    $id_photo = $_GET['id_photo'];
    $data_photo = $bdd->build_r_from_id('t_photo',$id_photo);
}else{
    // On est en Creation
    $id_photo = 0;
    $data_photo = array();
    $data_photo['photographie'] = '';
    $data_photo['ordre'] = $bdd->squery("SELECT IFNULL( (MAX(ordre) + 1), 1) FROM t_photo");
}


// Mise en forme du formulaire
$html = '   <div class="form-style">';

// Gestion du Titre de la page (Modification ou Ajout)
if($id_photo > 0){
    $html .= '       <h1>Modification Photographie<span>Modifier une photo...</span></h1>';
}else{
    $html .= '       <h1>Ajout Photographie<span>Ajouter une photo...</span></h1>';
}

// Debut du Formulaire HTML
$html.= '       <form method="POST" action="index.php?page=manage_photo" enctype="multipart/form-data">';

// Image
$html.= '           <div class="section"><span>1</span>Photographie</div>';
$html.= '           <div class="inner-wrap">';
$html.= '               <label>Photographie <input type="file" name="my_file"/>';
if(is_file('images/galerie/'.$data_photo['photographie'])){
    $html.= '               <div class="apercu_photo"><img src="images/galerie/'.$data_photo['photographie'].'" /></div>';
    $html.= '               <div style="clear:both;"></div>';
}
$html.= '               </label>';
$html.= '           </div>';

// Titre et description
$html.= '           <div class="section"><span>2</span>Titre et Description</div>';
$html.= '           <div class="inner-wrap">';
$sql = "SELECT * FROM t_langue";
$datas_langue = $bdd->getData($sql);
foreach($datas_langue as $data_langue) {
    $sql = "SELECT titre FROM t_photo_trad WHERE fk_photo=".$id_photo." AND fk_langue=".$data_langue['id'];
    $trad = $bdd->squery($sql);
    $html.= '               <label>Titre ('.$data_langue['nom'].') <input type="text" name="form_titre_'.$data_langue['id'].'" value="'.$trad.'"/></label>';
    $sql = "SELECT description FROM t_photo_trad WHERE fk_photo=".$id_photo." AND fk_langue=".$data_langue['id'];
    $trad = $bdd->squery($sql);
    $html.= '               <label>Description ('.$data_langue['nom'].') <textarea name="form_description_'.$data_langue['id'].'">'.$trad.'</textarea></label>';
}
$html.= '           </div>';

// Ordre
$html.= '           <div class="section"><span>3</span>Ordre</div>';
$html.= '           <div class="inner-wrap">';
$html.= '               <label>Ordre <input type="number" name="form_ordre" value="'.$data_photo['ordre'].'"/></label>';
$html.= '           </div>';

// Bouton Enregistrer
$html.= '           <div class="button-section">';
$html.= '               <input type="submit" value="Enregistrer" />';
$html.= '           </div>';

// Champs caché...
$html.= '           <input type="hidden" name="id_photo" id="id_photo" value="'.$id_photo.'" />';

$html.= '       </form>';
$html.= '   </div>';
?>