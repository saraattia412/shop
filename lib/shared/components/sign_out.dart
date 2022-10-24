

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'navigate_and_finish.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value)
    {
      navigateAndFinish(context, LogInScreen(),);
    }
  });
}
