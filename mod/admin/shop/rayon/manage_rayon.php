<?php
$link = array(
    array(
        'image' => 'shop.png',
        'text' => 'Apercu<br/>Boutique',
        'url' => 'index.php?page=fo_home',
    ),
    array(
        'image' => 'produit.png',
        'text' => 'Listing<br/>Produit',
        'url' => 'index.php?page=listing_produit',
    ),
    array(
        'image' => 'promotion.png',
        'text' => 'Listing<br/>Promotion',
        'url' => 'index.php?page=listing_promotion',
    ),
    array(
        'image' => 'rayon.png',
        'text' => 'Listing<br/>Rayon',
        'url' => 'index.php?page=listing_rayon',
    ),
    array(
        'image' => 'stock.png',
        'text' => 'Listing<br/>Stock',
        'url' => 'index.php?page=listing_stock',
    ),
    array(
        'image' => 'tva.png',
        'text' => 'Listing<br/>TVA',
        'url' => 'index.php?page=listing_tva',
    ),
    array(
        'image' => 'commande.png',
        'text' => 'Listing<br/>Commandes',
        'url' => 'index.php?page=listing_commande',
    ),
    array(
        'image' => 'statut_commande.png',
        'text' => 'Listing<br/>Statut Cmd.',
        'url' => 'index.php?page=listing_statut_cmd',
    )
);
$page = new Page(true, 'Gestion Rayon', $link);
$page->build_content($html);
$page->show();
