abstract class AuthRepository {
  Future<bool> register(String name, String password, String email,context);
  Future<bool> login( String password, String email,context);
}




