<?php
$bdd = new Data();
$html = '';
// Test retour formulaire
if (isset($_POST) && !empty($_POST)) {
    // Vérification des login et mot de passe récupérés depuis le formulaire
    $login = $_POST['login'];
    $password = $_POST['password'];
    // Requete SQL sur la table t_user
    $sql = "SELECT * FROM t_user WHERE login='" . addslashes($login) . "' LIMIT 1;";
    $rs = $bdd->query($sql);

    if ($rs && mysqli_num_rows($rs)) {
        $data = mysqli_fetch_assoc($rs);
        // Vérification du mot de passe crypté
        if (!empty($password) && password_verify($password, $data['password'])) {

            // Enregistrement des informations en session
            $_SESSION[SESSION_NAME]['id_user'] = $data['id'];
            $_SESSION[SESSION_NAME]['nom_user'] = $data['prenom'] . ' ' . $data['nom'];
            $_SESSION[SESSION_NAME]['avatar'] = $data['avatar'];
            $_SESSION[SESSION_NAME]['id_langue'] = $data['fk_langue'];
            $_SESSION[SESSION_NAME]['isAdmin'] = $data['isAdmin'];

            header("location: index.php?page=home");
        } else {
            $html = '<div class="login_info_error">Mot de passe incorrect !</div>';
        }
    } else {
        $html = '<div class="login_info_error">Login Introuvable</div>';
    }

// Creation de l'interface...
$html .= '<div class="container">';
$html .= '   <form action="index.php?page=login" method="POST">';
$html .= '        <p>Bienvenue</p>';
$html .= '        <input type="text" name="login" id="login" placeholder="Login"/><br>';
$html .= '        <input type="password" name="password" id="password" placeholder="Password"/><br/>';
$html .= '        <input type="submit" value="Connexion"><br>';
$html .= '        <a href="index.php?page=fo_user" class="inscription"> Inscrivez vous ! </a>';
$html .= '    </form>';
$html .= '    <div class="drop drop-1"></div>';
$html .= '    <div class="drop drop-2"></div>';
$html .= '    <div class="drop drop-3"></div>';
$html .= '    <div class="drop drop-4"></div>';
$html .= '    <div class="drop drop-5"></div>';
$html .= '</div>';
