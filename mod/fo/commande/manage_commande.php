<?php
    $page = new Page_FO(true, 'Commande : '.$n_commande);
    $page->build_content($html);
    $page->show();
?>