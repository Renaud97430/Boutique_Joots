<?php
    $link = array(
        array(
            'image'=>'add_photo.png',
            'text'=>'Ajout<br/>une Photo',
            'url'=>'index.php?page=manage_photo',
        )
    );
    $page = new Page(true, 'Gestion Utilisateur', $link);
    $page->build_content($html);
    $page->show();
?>