final userTable = 'userTable';

//UserTable Table fields
final name = "name";
final email = "email";
final phoneNumber = "phoneNumber";
final sapName = "sapName";
final isSapEnabled = "isSapEnabled";
final userType = "userType";
final active = "active";



String createUserTableDB = "CREATE TABLE IF NOT EXISTS $userTable ("
    "$name TEXT, "
    "$email TEXT, "
    "$phoneNumber TEXT, "
    "$sapName TEXT, "
    "$isSapEnabled BIT, "
    "$userType INT, "
    "$active BIT "
    ")";
