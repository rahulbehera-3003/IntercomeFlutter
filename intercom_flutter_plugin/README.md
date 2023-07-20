# intercom_flutter_plugin

Flutter wrapper for Intercom [Android](https://github.com/intercom/intercom-android) and [iOS](https://github.com/intercom/intercom-ios) projects. The Intercom SDK enables you to use the Intercom Messenger in your app, have conversations with your customers, send rich outbound messages, show your Help Center, and track events.

- Uses Intercom Android SDK Version `15.1.3`.
- The minimum Android SDK `minSdkVersion` required is 21.
- Uses Intercom iOS SDK Version `15.0.3`.
- The minimum iOS target version required is 13.

## Usage

### Step 1 - Add references to Intercom
If you’re new to Intercom, you’ll need to create an account and start your free trial.

### Android

#### Permissions
You will need to include the [READ_EXTERNAL_STORAGE](https://developer.android.com/reference/android/Manifest.permission.html#READ_EXTERNAL_STORAGE) permission if you have enabled image attachments:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

You can also include [VIBRATE](https://developer.android.com/reference/android/Manifest.permission.html#VIBRATE) to enable vibration in push notifications:

```xml
<uses-permission android:name="android.permission.VIBRATE"/>
```

### iOS

#### Update Info.plist
**Photo Library usage:**
Add a "Privacy - Photo Library Usage Description" entry to your Info.plist.

This is [required by Apple](https://developer.apple.com/library/archive/qa/qa1937/_index.html) for all apps that access the photo library. It is necessary when installing Intercom due to the image upload functionality. Users will be prompted for the photo library permission only when they tap the image upload button.

### Step 2 - Initialize Intercom
First, you'll need to get your [Intercom](https://www.intercom.com/) **app ID** and **API key**. **Android API key** is required if you want to use Intercom in [Android](https://app.intercom.com/a/apps/_/settings/android). **iOS API key** is required if you want to use Intercom in [iOS](https://app.intercom.com/a/apps/_/settings/ios).

### Flutter
In your `lib/main.dart` file, import `package:intercom_flutter_plugin/intercom_flutter_plugin.dart` and use the methods in `Intercom` class. Then, initialize Intercom in your `lib/main.dart` file:

Example:
```dart
import 'package:flutter/material.dart';
import 'package:intercom_flutter_plugin/intercom_flutter_plugin.dart';

void main() async {
    // initialize the flutter binding.
    WidgetsFlutterBinding.ensureInitialized();
    // initialize the Intercom.
    // make sure to add keys from your Intercom workspace.
    await Intercom.instance.initialize(
      appId: 'appIdHere',
      androidApiKey: 'androidKeyHere',
      iosApiKey: 'iosKeyHere',
    );
    runApp(App());
}
```

### Step 3 - Create an user and display messenger
Finally, you’ll need to create a user, like this:
```dart
class App extends StatelessWidget {
    const App({super.key});
  
    @override
    Widget build(BuildContext context) {
        return ElevatedButton(
            child: Text('Open Intercom'),
            onPressed: () async {
                // messenger will load the messages only if the user is registered in Intercom.
                await Intercom.instance.loginIdentifiedWithEmail(email: 'example@test.com');
                await Intercom.instance.displayMessenger();
            },
        );
    }
}
```
**Available methods:**
```dart
  Future<void> initialize({required String appId, String? androidApiKey, String? iosApiKey});
  Stream<int> getUnreadStream();
  Future<void> setUserHash(String userHash);
  Future<void> loginIdentifiedWithUserId({required String userId, IntercomStatusCallback? statusCallback});
  Future<void> loginIdentifiedWithEmail({required String email, IntercomStatusCallback? statusCallback});
  Future<void> loginIdentifiedUser({required String userId, required String email, IntercomStatusCallback? statusCallback});
  Future<void> loginUnidentifiedUser({IntercomStatusCallback? statusCallback});
  Future<void> logout();
  Future<void> setLauncherVisibility(IntercomVisibility visibility);
  Future<int> unreadConversationCount();
  Future<void> setInAppMessagesVisibility(IntercomVisibility visibility);
  Future<void> displayMessenger();
  Future<void> hideMessenger();
  Future<void> displayHelpCenter();
  Future<void> displayHelpCenterCollections(List<String> collectionIds);
  Future<void> displayMessages();
  Future<void> logEvent(String name, [Map<String, Object?>? metaData]);
  Future<void> sendTokenToIntercom(String token);
  Future<void> handlePushMessage();
  Future<void> displayMessageComposer(String message);
  Future<bool> isIntercomPush(Map<String, String> message);
  Future<void> handlePush(Map<String, String> message);
  Future<void> setBottomPadding(int padding);
  Future<void> displayArticle(String articleId);
  Future<void> displayCarousel(String carouselId);
  Future<void> displaySurvey(String surveyId);
```
That’s it - now you’ve got a working Intercom app. However, you’ll need to register your users before you can talk to them and track their activity in your app.

For more details, see [Intercom for Android](https://developers.intercom.com/installing-intercom/docs/android-installation) or [Intercom for iOS](https://developers.intercom.com/installing-intercom/docs/ios-installation).

## Example of using Intercom for Flutter
For your convenience, we have also added example of working project. Feel free to review it in our [repository](https://github.com/chuvakpavel/IntercomeFlutter/tree/main/intercom_flutter_plugin/example).
