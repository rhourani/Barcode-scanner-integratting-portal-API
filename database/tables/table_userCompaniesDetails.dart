final userCompaniesDetailsTableDB = 'userCompaniesDetailsTableDB';

//UserCompanies Table fields
final id = "id";
final companyID = "companyId";
final companyName = "companyName";
final companyHost = "host";
final connectionString = "connectionString";



String createUserCompaniesDetailsTableDB = "CREATE TABLE IF NOT EXISTS $userCompaniesDetailsTableDB ("
    "$id INTEGER PRIMARY KEY, "
    "$companyID INTEGER, "
    "$companyName TEXT, "
    "$companyHost TEXT, "
    "$connectionString TEXT "
    ")";
