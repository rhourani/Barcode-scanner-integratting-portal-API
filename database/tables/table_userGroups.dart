final userTable = 'userTable';

//UserTable Table fields
final groupID = "groupID";
final groupName = "groupName";



String createUserTableDB = "CREATE TABLE IF NOT EXISTS $userTable ("
    "$groupID INTEGER, "
    "$groupName TEXT, "
    ")";
