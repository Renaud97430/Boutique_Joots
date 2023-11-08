<?php
class Maze{
    private $width;
    private $height;
    private $size_case;
    private $nb_case_width;
    private $nb_case_height;
    private $gotMask = false;
    private $startX = 0;
    private $startY = 0;
    private $endX = 0;
    private $endY = 0;

    private $mask = array();            // Gestion du masqu epour la forme du labyrinthe
    private $maze = array();
    private $visited = array();
    private $direction = array(
        array('x' => 0, 'y' => -1),     // Haut
        array('x' => 1, 'y' => 0),      // Droite
        array('x' => 0, 'y' => 1),      // Bas
        array('x' => -1, 'y' => 0)      // Gauche
    );

    public function __construct($width, $height, $size_case) {
        $this->nb_case_width = round($width / $size_case);
        $this->nb_case_height = round($height / $size_case);
        $this->width = $this->nb_case_width * $size_case;
        $this->height = $this->nb_case_height * $size_case;;
        $this->size_case = $size_case;
    }

    public function addMask($pic) {
        $img = imagecreatefrompng($pic);
        $o_wd = imagesx($img);
        $o_ht = imagesy($img);
        if(!$img) return false;
        $tmp = imageCreateTrueColor($this->nb_case_width,$this->nb_case_height);
        imageCopyResampled($tmp, $img, 0, 0, 0, 0, $this->nb_case_width, $this->nb_case_height, $o_wd, $o_ht);

        for($i=0; $i<$this->nb_case_width; $i++) {
            for($j=0; $j<$this->nb_case_height; $j++) {
                $color = imagecolorat($tmp, $i, $j);
                if($color === 0) {
                    // Noir
                    $this->mask[$i][$j] = 0;
                } else {
                    $this->mask[$i][$j] = 1;
                }
            }
        }
        $this->gotMask = true;
    }

    public function generateMaze() {
        // initialisation matrices
        $first = true;
        $this->startX = 0;
        $this->startY = 0;

        if($this->gotMask) {
            for ($x = 0; $x < $this->nb_case_width; $x++) {
                $this->maze[$x] = array();
                $this->visited[$x] = array();
                for ($y = 0; $y < $this->nb_case_height; $y++) {
                    if ($this->mask[$x][$y] == 1) {
                        $this->maze[$x][$y] = 0;
                        $this->visited[$x][$y] = 1;
                    } else {
                        if ($first) {
                            $first = false;
                            $this->startX = $x;
                            $this->startY = $y;
                        }
                        $this->maze[$x][$y] = 0;
                        $this->visited[$x][$y] = 0;
                        $this->endX = $x;
                        $this->endY = $y;
                    }
                }
            }
        } else {
            for ($x = 0; $x < $this->nb_case_width; $x++) {
                $this->maze[$x] = array();
                $this->visited[$x] = array();
                for ($y = 0; $y < $this->nb_case_height; $y++) {
                    $this->maze[$x][$y] = 0;
                    $this->visited[$x][$y] = 0;
                    $this->mask[$x][$y] = 0;
                }
            }
        }
        $this->walk($this->startX, $this->startY);
    }

    public function drawMazePic($name_save='') {
        // Création de l'image et gestion des couleurs
        $im = imagecreate($this->width+1, $this->height+1);
        $black = imagecolorallocate($im, 0, 0, 0);
        $white = imagecolorallocate($im, 255, 255, 255);
        $red = imagecolorallocate($im, 255, 0, 0);

        // Fond blanc
        imagefill($im, 0, 0, $white);

        // On parcourt toutes les cases et on affiche le symbole correspondant
        for($x = 0; $x < $this->nb_case_width; $x++) {
            for ($y = 0; $y < $this->nb_case_height; $y++) {
                if($this->mask[$x][$y] == 0) {
                    // Ajout cas particulier si masque en bordure d'image
                    if($this->gotMask) {
                        if($x == 0) {
                            // On force la bordure a gauche
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                        }
                        if( ($y + 1) == $this->nb_case_height) {
                            // On force la bordure a inférieure
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                        }
                    }
                    switch ($this->maze[$x][$y]) {
                        case 0 :
                            // ----+
                            //     |
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case,
                                $black
                            );
                            imageline(
                                $im,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                            break;
                        case 1 :
                            //     +
                            //     |
                            imageline(
                                $im,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                            break;
                        case 2 :
                            // ----+
                            //
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case,
                                $black
                            );
                            break;
                        case 3 :
                            //
                            //
                            break;
                    }
                } else {
                    // Gestion du contour du labyrinthe
                    imagefilledrectangle(
                        $im,
                        $x * $this->size_case,
                        $y * $this->size_case,
                        $x * $this->size_case + $this->size_case,
                        $y * $this->size_case + $this->size_case,
                        $white
                    );

                    // Juste a droite
                    $nextX = $x + 1;
                    if($nextX < $this->nb_case_width) {
                        if($this->mask[$nextX][$y] == 0) {
                            //     +
                            //     |
                            imageline(
                                $im,
                                $x * $this->size_case +
                                $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                        }
                    }

                    // Juste en dessous
                    $nextY = $y + 1;
                    if($nextY < $this->nb_case_height) {
                        if($this->mask[$x][$nextY] == 0) {
                            //
                            // ----+
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                        }
                    }

                    // Juste à Gauche
                    $prevX = $x - 1;
                    if($prevX > 0) {
                        if($this->mask[$prevX][$y] == 0) {
                            // +
                            // |
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case,
                                $y * $this->size_case + $this->size_case,
                                $black
                            );
                        }
                    }

                    // Au dessus
                    $prevY = $y - 1;
                    if($prevY > 0) {
                        if($this->mask[$x][$prevY] == 0) {
                            // ----+
                            //
                            imageline(
                                $im,
                                $x * $this->size_case,
                                $y * $this->size_case,
                                $x * $this->size_case + $this->size_case,
                                $y * $this->size_case,
                                $black
                            );
                        }
                    }
                }
            }
        }

        // Entrée et Sortie
        if(!$this->gotMask) {
            imagerectangle($im, 0, 0, $this->width, $this->height, $black);
            imageline($im, $this->startX, $this->startY, $this->size_case-1, 0, $white);
            imageline($im, $this->width-$this->size_case+1, $this->height, $this->width, $this->height, $white);
        } else {
            imageline(
                $im,
                $this->startX * $this->size_case,
                $this->startY * $this->size_case,
                $this->startX * $this->size_case ,
                $this->startY * $this->size_case + $this->size_case,
                $white
            );
            imageline(
                $im,
                $this->endX * $this->size_case + $this->size_case,
                $this->endY * $this->size_case,
                $this->endX * $this->size_case + $this->size_case,
                ($this->endY * $this->size_case) + $this->size_case,
                $white
            );
        }

        // Gestion de la sortie
        if(!$name_save) {
            ob_start();
            imagepng($im);
            $image_data = ob_get_clean();
            $base64_image = base64_encode($image_data);
            imagedestroy($im);
            return '<img src="data:image/png;base64,'.$base64_image.'" />';
        } else {
            imagepng($im, $name_save);
            imagedestroy($im);
        }
    }

    private function walk($x, $y) {
        if ($this->visited[$x][$y] == 0) {
            $this->visited[$x][$y] = 1;
        }

        // On mélange l'ordre des directions pour ne pas avoir de labyrinthe régulier
        shuffle($this->direction);

        // On parcours toutes les directions
        foreach ($this->direction as $dir) {
            $nextX = $x + $dir['x'];
            $nextY = $y + $dir['y'];
            if ($nextX >= $this->nb_case_width
                or $nextY >= $this->nb_case_height
                or $nextX < 0
                or $nextY < 0) {
                // On sort du cadre du labyrinthe => direction suivante
                continue;
            }
            if ($this->visited[$nextX][$nextY] == 1) {
                // Deja visité => direction suivante
                continue;
            }

            if ($nextX == $x) {
                // Déplacement Vertical
                if ($nextY > $y) {
                    // vers le bas => On modifie le motif de la case voisine en bas
                    $this->maze[$x][$nextY] = 1;
                } else {
                    //vers le haut
                    if ($this->maze[$x][$y] == 2) {
                        // On modifie le motif de la case en cours
                        $this->maze[$x][$y] = 3;
                    } else {
                        // On modifie le motif de la case en cours
                        $this->maze[$x][$y] = 1;
                    }
                }
            }

            if ($nextY == $y) {
                //Déplacement Horizontal
                if ($nextX > $x) {
                    //vers la droite
                    if ($this->maze[$x][$y] == 1) {
                        // On modifie le motif de la case en cours
                        $this->maze[$x][$y] = 3;
                    } else {
                        // On modifie le motif de la case en cours
                        $this->maze[$x][$y] = 2;
                    }
                } else {
                    //vers la gauche => On modifie le motif de la case voisine a gauche
                    $this->maze[$nextX][$y] = 2;
                }
            }
            // Et on recommence avec la case voisine d'une facon recursive jusqu'a la fin...
            $this->walk($nextX, $nextY);
        }
    }

    private function getRandomDirection() {
        $directions = $this->direction;
        // Retirer la direction vers le haut pour un labyrinthe circulaire
        array_splice($directions, 0, 1);

        // Mélanger et retourner une direction aléatoire
        shuffle($directions);
        return $directions[0];
    }
}

?>