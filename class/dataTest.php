use PHPUnit\Framework\TestCase;

class DataTest extends TestCase
{
// Valeurs fictives pour la configuration de la base de données
private const SERVEUR_BDD = 'xxx';
private const USER_BDD = 'xxx';
private const PASSWORD_BDD = 'xxx';
private const NAME_BDD = 'xxx';
private const ERROR_SERVEUR = 'Erreur Connexion Serveur BDD';
private const ERROR_BDD = 'Erreur selection BDD';

// Créer une instance de la classe Data
private $data;

public function setUp(): void
{
// Créer une instance de la classe Data avec des valeurs fictives
$this->data = new DataMock();
}

public function testQuery()
{
// Tester la méthode query avec une requête valide
$result = $this->data->query("SELECT * FROM table_test");
$this->assertNotFalse($result);

// Tester la méthode query avec une requête invalide
$result = $this->data->query("REQUETE INVALIDE");
$this->assertFalse($result);
}

public function testSquery()
{
// Requête SQL fictive pour les tests
$sql = "SELECT * FROM table_test";

// Tester la méthode squery avec un résultat valide
$this->data->setMockResult(['resultat_test']);
$result = $this->data->squery($sql);
$this->assertEquals(['resultat_test'], $result);

// Tester la méthode squery avec un résultat invalide
$this->data->setMockResult(false);
$result = $this->data->squery($sql);
$this->assertFalse($result);
}

// Classe mock pour remplacer les méthodes mysqli
private class DataMock extends Data
{
private $mockResult;

public function setMockResult($result)
{
$this->mockResult = $result;
}

protected function query($query)
{
return $this->mockResult;
}
}

public function testBuildRFromId()
{
// Requête SQL fictive pour le test
$table = 'table_test';
$id = 1;
$idFieldName = 'id';
$expectedResult = ['id' => 1, 'nom' => 'Test'];

// Définir le résultat attendu pour la requête SQL
$this->data->setMockResult([$expectedResult]);

// Tester la méthode build_r_from_id
$result = $this->data->build_r_from_id($table, $id, $idFieldName);
$this->assertEquals($expectedResult, $result);
}

public function testGetData()
{
// Requête SQL fictive pour le test
$sql = "SELECT * FROM table_test";
$expectedResult = [['id' => 1, 'nom' => 'Test'], ['id' => 2, 'nom' => 'Exemple']];

// Définir le résultat attendu pour la requête SQL
$this->data->setMockResult($expectedResult);

// Tester la méthode getData
$result = $this->data->getData($sql);
$this->assertEquals($expectedResult, $result);
}

public function testSqlDelete()
{
// Requête SQL fictive pour le test
$table = 'table_test';
$id = 1;
$idFieldName = 'id';

// Tester la méthode sql_delete
$result = $this->data->sql_delete($table, $id, $idFieldName);
$this->assertTrue($result);
}

public function testSqlUpdate()
{
// Requête SQL fictive pour le test
$table = 'table_test';
$id = 1;
$dataToUpdate = ['nom' => 'Nouveau nom'];

// Tester la méthode sql_update
$result = $this->data->sql_update($table, $id, $dataToUpdate);
$this->assertTrue($result);
}

public function testSqlInsert()
{
// Requête SQL fictive pour le test
$table = 'table_test';
$dataToInsert = ['nom' => 'Nouveau nom'];

// Tester la méthode sql_insert
$insertedId = $this->data->sql_insert($table, $dataToInsert);

// Vérifier que l'ID inséré est un entier positif
$this->assertGreaterThan(0, $insertedId);
}

}