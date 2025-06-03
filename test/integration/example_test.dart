import 'package:go_router_paths/go_router_paths.dart';
import 'package:test/test.dart';

class AppPaths {
  static Path get home => Path('home');
  static WelcomePath get welcome => WelcomePath();

  static UsersPath get users => UsersPath();
  static Param<Param> get books => Param('books', 'bookId');
  static SettingPath get setting => SettingPath();
}

class WelcomePath extends Path<WelcomePath> {
  WelcomePath() : super('welcome');

  Path get login => Path('login', parent: this);
  Path get register => Path('register', parent: this);
}

class UsersPath extends Path<UsersPath> {
  UsersPath() : super('users');

  UserPath get user => UserPath(this);
}

class UserPath extends Param<UserPath> {
  UserPath(UsersPath usersPath) : super.only('userId', parent: usersPath);

  Path get edit => Path('edit', parent: this);
  Path get delete => Path('delete', parent: this);
}

class SettingPath extends Path<UsersPath> {
  SettingPath() : super('setting');

  Path get edit => Path('edit', parent: this);

  Param<Param> get account => Param('account', 'userId', parent: this);
}

void main() {
  test('example', () {
    expect(AppPaths.home.path, '/home');
    expect(AppPaths.welcome.login.path, '/welcome/login');
    expect(AppPaths.welcome.register.path, '/welcome/register');
    expect(AppPaths.users.path, '/users');
    expect(
      AppPaths.users.user.define('Luke Skywalker').path,
      '/users/Luke%20Skywalker',
    );
    expect(
      AppPaths.users.user.define('Jar Jar binks').edit.path,
      '/users/Jar%20Jar%20binks/edit',
    );
    expect(
      AppPaths.users.user.define('Darth Vader').delete.path,
      '/users/Darth%20Vader/delete',
    );
    expect(
      AppPaths.books
          .define('Star Wars')
          .query({'first-trilogy-only': 'true'}).path,
      '/books/Star%20Wars?first-trilogy-only=true',
    );
    expect(
      AppPaths.setting.account
          .define('profile')
          .withQuery(UserSetter('userId'))
          .path,
      '/setting/account/profile?userId=userId',
    );
  });
}

class UserSetter with Queryable {
  UserSetter(this.userId);

  final String userId;

  @override
  Map<String, dynamic> toJson() => {'userId': userId};
}
