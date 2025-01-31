abstract class AuthRepository {
  Future<bool> register(String name, String password, String email,context,String lang);
  Future<bool> login( String password, String email,context);
}




