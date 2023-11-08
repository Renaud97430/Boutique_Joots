<?php
    $bdd = new Data();

    if(isset($_GET['delete_id']) && !empty($_GET['delete_id'])) {
        // Supression images...
        $file = $bdd->squery("SELECT photographie FROM t_photo WHERE id=".$_GET['delete_id']);
        @unlink('images/galerie/'.$file);
        $bdd->sql_delete('t_photo',$_GET['delete_id']);
        header('location: index.php?page=listing_photo');
    }

    $sql = "SELECT ";
    $sql.= " p.id AS id_photo,";
    $sql.= " p.photographie AS photo,";
    $sql.= " pt.titre AS titre,";
    $sql.= " pt.description AS description,";
    $sql.= " CONCAT(u.prenom, ' ' , u.nom) AS utilisateur";
    $sql.= " FROM t_photo p";
    $sql.= " LEFT JOIN t_user u ON u.id=p.fk_user";
    $sql.= " LEFT JOIN t_photo_trad pt ON pt.fk_photo=p.id AND pt.fk_langue=".$_SESSION[SESSION_NAME]['id_langue'];

    // Verification si retour d'un formulaire
    if( isset($_POST) && !empty($_POST)){
        $sql.= " WHERE 1=1 ";

        if(!empty($_POST['titre'])){
            $sql.= " AND pt.titre LIKE '%".$_POST['titre']."%'";
        }
        if(!empty($_POST['description'])){
            $sql.= " AND pt.description LIKE '%".$_POST['description']."%'";
        }
        if(!empty($_POST['user'])){
            $sql.= " AND u.id =".$_POST['user'];
        }
        $titre = $_POST['titre'];
        $description = $_POST['description'];
        $user = $_POST['user'];
    } else {
        $titre = '';
        $description = '';
        $user = 0;
    }

    // Formulaire de recherche
    $html = '';
    $html.= '<form action="index.php?page=listing_photo" method="POST">';
    $html.= '   <label><input type="text" name="titre" placeholder="Titre..." '.((!empty($titre))?' value="'.$titre.'" ': ' value="" ').' /></label>';
    $html.= '   <label><input type="text" name="description" placeholder="Description..."  '.((!empty($description))?' value="'.$description.'" ': ' value="" ').'/></label>';
    $html.= '   <label>';
    $html.= '       <select name="user">';
    $html.= '           <option value="">-- Choisissez un utilisateur --</option>';
    $sql_user = "SELECT id, CONCAT(prenom, ' ', nom) AS nom FROM t_user ORDER by nom ASC;";
    $datas_user = $bdd->getData($sql_user);
    foreach($datas_user as $data_user) {
        $html.= '           <option value="'.$data_user['id'].'"';
        if($data_user['id'] == $user) {
            $html .= ' selected="selected" ';
        }
        $html.= '>'.$data_user['nom'].'</option>';
    }
    $html.= '       </select>';
    $html.= '   </label>';
    $html.= '   <label><input type="submit" value="Rechercher" /></label>';
    $html.= '</form>';

    $datas_photo = $bdd->getData($sql);
    $html.= '<div class="zone_photo">';

    // Si je suis ici => Tout va bien ! la requete est correcte et il y a au moins un enregistrement
    // Etape 3 : Je parcours les enregistrements de ma requete
    if($datas_photo) {
        foreach ($datas_photo as $data) {
            $html .= '<div class="one_image" onclick="window.location.href=\'index.php?page=manage_photo&id_photo='.$data['id_photo'].'\'">';
            $html .= '    <img src="images/galerie/' . $data['photo'] . '" />';
            $html .= '    <div class="titre">' . $data['titre'] ;
            $html .= '       <a onclick="if(window.confirm(\'Etes vous sur ?\')) return true; else return false;" href="index.php?page=listing_photo&delete_id='.$data['id_photo'].'"><img src="images/interface/suppr.png" style="width: 32px;vertical-align: text-bottom;"/></a>';
            $html .= '    </div>';
            $html .= '    <div class="description">' . $data['description'] . '</div>';
            $html .= '    <div class="auteur">' . $data['utilisateur'] . '</div>';
            $html .= '</div>';
        }
    }
    $html.= '</div>';

?>
