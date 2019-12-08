<?php
declare(strict_types=1);

class Fixtures
{
    /**
     * @var PDO $connection
     */
    private static $connection;

    /**
     * @return void
     */
    public function generate(): void
    {
        $connection = $this->getConnection();

        try {
            $connection->beginTransaction();
            $this->cleanup();
            $connection->commit();

            $connection->beginTransaction();
            $this->generateUsers(2000);
            $this->generatePurchases();
            $connection->commit();
        } catch (Exception $e) {
            $connection->rollBack();
            echo $e->getMessage();
        }
    }

    private function getRandomName(): string
    {
        static $randomNames = ['Norbert','Damon','Laverna','Annice','Brandie','Emogene','Cinthia','Magaret','Daria','Ellyn','Rhoda','Debbra','Reid','Desire','Sueann','Shemeka','Julian','Winona','Billie','Michaela','Loren','Zoraida','Jacalyn','Lovella','Bernice','Kassie','Natalya','Whitley','Katelin','Danica','Willow','Noah','Tamera','Veronique','Cathrine','Jolynn','Meridith','Moira','Vince','Fransisca','Irvin','Catina','Jackelyn','Laurine','Freida','Torri','Terese','Dorothea','Landon','Emelia'];
        return $randomNames[array_rand($randomNames)] . ' ' . $randomNames[array_rand($randomNames)];
    }

    private function getRandomProduct(): string
    {
        return uniqid();
    }

    /**
     * @return PDO
     */
    public function getConnection(): PDO
    {
        if (null === self::$connection) {
            self::$connection = new PDO('mysql:host=127.0.0.1:3357;dbname=budget', 'root', 'root', []);
            self::$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }

        return self::$connection;
    }

    private function cleanup(): void
    {
        $connection = $this->getConnection();
        $connection->exec('DELETE FROM user WHERE user_id > 6');
        $connection->exec('ALTER TABLE user AUTO_INCREMENT = 7');
        $connection->exec('ALTER TABLE purchased_item AUTO_INCREMENT = 17');
    }

    /**
     * @param int $usersCount
     * @throws Exception
     */
    public function generateUsers(int $usersCount): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();

        // === CREATE USERS ===
        $start = microtime(true);

        $userGroupId = $userName = $email = $login = $password = $dob = '';
        $minAgeTimestamp = $currentTimestamp - (31556952 * 45);
        $maxAgeTimestamp = $currentTimestamp - (31556952 * 16);
        $statement = $connection->prepare(<<<SQL
    INSERT INTO user (user_group_id, user_name, email, login, password, dob)
    VALUES (:userGroupId, :userName, :email, :login, :password, :dob)
    ON DUPLICATE KEY UPDATE dob=VALUES(dob), user_group_id=VALUES(user_group_id);
SQL
        );
        $statement->bindParam(':userGroupId', $userGroupId);
        $statement->bindParam(':userName', $userName);
        $statement->bindParam(':email', $email);
        $statement->bindParam(':login', $login);
        $statement->bindParam(':password', $password);
        $statement->bindParam(':dob', $dob);

        for ($userId = 7; $userId < $usersCount; $userId++) {
            $userGroupId = random_int(1, 3);
            $userName = $this->getRandomName();
            $email = str_replace(' ', '', strtolower($userName)) . '@example.com';
            $login = str_replace(' ', '_', strtolower($userName));
            $password = $login;
            $timestamp = random_int($minAgeTimestamp, $maxAgeTimestamp);
            $dob = date('Y-m-d', $timestamp);
            $statement->execute();
        }

        echo 'Create users: ' . (microtime(true) - $start) . "\n";
    }

    public function generatePurchases(): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();

        // === CREATE PURCHASES ===
        $start = microtime(true);
        $userId = $categoryId = $purchasedItem = $price = $purchasedAt = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO purchased_item (user_id, category_id, purchased_item, price, purchased_at)
    VALUES (:userId, :categoryId, :purchasedItem, :price, :purchasedAt)
SQL
        );
        $statement->bindParam(':userId', $userId, PDO::PARAM_INT);
        $statement->bindParam(':categoryId', $categoryId, PDO::PARAM_INT);
        $statement->bindParam(':purchasedItem', $purchasedItem);
        $statement->bindParam(':price', $price, PDO::PARAM_INT);
        $statement->bindParam(':purchasedAt', $purchasedAt);

        $userIdsStatement = $connection->query('SELECT user_id FROM user');
        $userIds = $userIdsStatement->fetchAll(PDO::FETCH_COLUMN);

        foreach ($userIds as $userId) {
            for ($i = 0; $i < 10; $i++) {
                $categoryId = random_int(1, 6);
                $purchasedItem = $this->getRandomProduct();
                $price = random_int(10, 100000);
                $timestamp = random_int($currentTimestamp - 31556952, $currentTimestamp);
                $purchasedAt = date('Y-m-d', $timestamp);
                $statement->execute();
            }
        }

        echo 'Create purchases: ' . (microtime(true) - $start) . "\n";
    }
}

$fixturesGenerator = new Fixtures();
$fixturesGenerator->generate();