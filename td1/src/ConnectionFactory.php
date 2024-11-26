<?php
namespace iutnc\hellokant;

use \PDO as PDO;
use \Exception as Exception;
use \PDOException as PDOException;
class ConnectionFactory
{
    private static ?PDO $pdoInstance = null;
    public static function makeConnectionFromFile(string $filePath): PDO
    {
        if (self::$pdoInstance === null) {
            if (!file_exists($filePath)) {
                throw new Exception("Le fichier de configuration {$filePath} est introuvable.");
            }

            $conf = parse_ini_file($filePath);

            if (!isset($conf['driver'], $conf['host'], $conf['port'], $conf['dbname'], $conf['user'], $conf['password'])) {
                throw new Exception("Configuration de connexion invalide dans le fichier {$filePath}.");
            }

            try {
                $dsn = sprintf(
                    '%s:host=%s;port=%d;dbname=%s;charset=utf8',
                    $conf['driver'],
                    $conf['host'],
                    $conf['port'],
                    $conf['dbname']
                );

                $options = [
                    PDO::ATTR_PERSISTENT => true,
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_EMULATE_PREPARES => false,
                    PDO::ATTR_STRINGIFY_FETCHES => false,
                    PDO::FETCH_ASSOC => true,
                ];

                self::$pdoInstance = new PDO($dsn, $conf['user'], $conf['password'], $options);
            } catch (PDOException $e) {
                throw new Exception('Échec de la connexion à la base de données : ' . $e->getMessage());
            }
        }

        return self::$pdoInstance;
    }

    public static function getConnection(): PDO
    {
        if (self::$pdoInstance === null) {
            throw new Exception('La connexion n\'a pas encore été initialisée.');
        }

        return self::$pdoInstance;
    }
}

