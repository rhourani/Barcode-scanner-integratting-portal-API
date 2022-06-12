final userPermissionsDBTable = 'userPermissionsTable';

//UserPermissions Table fields
final userName = "userName";
final comLists = "comLists";
final active = "active";


String createUserPermissionsDBTable = "CREATE TABLE IF NOT EXISTS $userPermissionsDBTable ("
    "$userName TEXT, "
    "$comLists TEXT, "
    "$active BIT"
    ")";
