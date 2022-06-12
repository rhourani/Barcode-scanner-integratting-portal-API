final userTokenTable = 'userTokenTable';

//userTokenTable Table fields
final userID = "id";
final token = "token";
final expiration = "expiration";
final email = "email";


String createUserTokenTableDB = "CREATE TABLE IF NOT EXISTS $userTokenTable ("
    "$userID INTEGER PRIMARY KEY, "
    "$token TEXT,"
    "$expiration TEXT,"
    "$email TEXT"
    ")";
