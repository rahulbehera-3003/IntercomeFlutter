import 'package:intercom_platform_interface/intercom_platform_interface.dart';

class Intercom {
  Intercom._();

  static final Intercom _instance = Intercom._();

  /// get the instance of the [Intercom].
  static Intercom get instance => _instance;

  static IntercomPlatform get _delegate => IntercomPlatform.instance;

  /// Function to initialize the Intercom SDK.
  ///
  /// First, you'll need to get your Intercom [appId].
  /// [androidApiKey] is required if you want to use Intercom in Android.
  /// [iosApiKey] is required if you want to use Intercom in iOS.
  ///
  /// You can get these from Intercom settings:
  /// * [Android](https://app.intercom.com/a/apps/_/settings/android)
  /// * [iOS](https://app.intercom.com/a/apps/_/settings/ios)
  ///
  /// Then, initialize Intercom in main method.
  Future<void> initialize({
    required String appId,
    String? androidApiKey,
    String? iosApiKey,
  }) {
    return _delegate.initialize(appId: appId, androidApiKey: androidApiKey, iosApiKey: iosApiKey);
  }

  /// You can check how many unread conversations a user has
  /// even if a user dismisses a notification.
  ///
  /// You can listen for unread conversation count with this method.
  Stream<int> getUnreadStream() {
    return _delegate.getUnreadStream();
  }

  /// To make sure that conversations between you and your users are kept private
  /// and that one user can't impersonate another then you need you need to setup
  /// the identity verification.
  ///
  /// This function helps to set up the identity verification.
  /// Here you need to pass hash (HMAC) of the user.
  ///
  /// This must be called before registering the user in Intercom.
  ///
  /// To generate the user hash (HMAC) see
  /// <https://gist.github.com/thewheat/7342c76ade46e7322c3e>
  ///
  /// Note: identity verification does not apply to unidentified users.
  Future<void> setUserHash(String userHash) {
    return _delegate.setUserHash(userHash);
  }

  /// Function to create a identified user in Intercom.
  /// You need to register your users before you can talk to them and
  /// track their activity in your app.
  ///
  /// You can register a identified user either with [userId].
  Future<void> loginIdentifiedWithUserId({
    required String userId,
    IntercomStatusCallback? statusCallback,
  }) {
    return _delegate.loginIdentifiedWithUserId(userId: userId, statusCallback: statusCallback);
  }

  /// Function to create a identified user in Intercom.
  /// You need to register your users before you can talk to them and
  /// track their activity in your app.
  ///
  /// You can register a identified user either with [email].
  Future<void> loginIdentifiedWithEmail({
    required String email,
    IntercomStatusCallback? statusCallback,
  }) {
    return _delegate.loginIdentifiedWithEmail(email: email, statusCallback: statusCallback);
  }

  /// Function to create a identified user in Intercom.
  /// You need to register your users before you can talk to them and
  /// track their activity in your app.
  ///
  /// You can register a identified user either with [userId] and with [email].
  Future<void> loginIdentifiedUser({
    required String userId,
    required String email,
    IntercomStatusCallback? statusCallback,
  }) {
    return _delegate.loginIdentifiedUser(
      userId: userId,
      email: email,
      statusCallback: statusCallback,
    );
  }

  /// Function to create a unidentified user in Intercom.
  /// You need to register your users before you can talk to them and
  /// track their activity in your app.
  Future<void> loginUnidentifiedUser({IntercomStatusCallback? statusCallback}) {
    return _delegate.loginUnidentifiedUser(statusCallback: statusCallback);
  }

  /// To logout a user from Intercom.
  /// This clears the Intercom SDK's cache of your user's identity.
  Future<void> logout() {
    return _delegate.logout();
  }

  /// To hide or show the standard launcher on the bottom right-hand side of the screen.
  Future<void> setLauncherVisibility(IntercomVisibility visibility) {
    return _delegate.setLauncherVisibility(visibility);
  }

  /// You can check how many unread conversations a user has
  /// even if a user dismisses a notification.
  ///
  /// You can get the current unread conversation count with this method.
  Future<int> unreadConversationCount() {
    return _delegate.unreadConversationCount();
  }

  /// To allow or prevent in app messages from popping up in certain parts of your app.
  Future<void> setInAppMessagesVisibility(IntercomVisibility visibility) {
    return _delegate.setInAppMessagesVisibility(visibility);
  }

  /// To open the Intercom messenger.
  ///
  /// This is used when you manually want to launch Intercom messenger.
  /// for e.g: from your custom launcher (Help & Support) or (Talk to us).
  Future<void> displayMessenger() {
    return _delegate.displayMessenger();
  }

  /// To close the Intercom messenger.
  ///
  /// This is used when you manually want to close Intercom messenger.
  Future<void> hideMessenger() {
    return _delegate.hideMessenger();
  }

  /// To display an Activity with your Help Center content.
  ///
  /// Make sure Help Center is turned on.
  /// If you don't have Help Center enabled in your Intercom settings the method
  /// displayHelpCenter will fail to load.
  Future<void> displayHelpCenter() {
    return _delegate.displayHelpCenter();
  }

  /// To display an Activity with your Help Center content for specific collections.
  ///
  /// Make sure Help Center is turned on.
  /// If you don't have Help Center enabled in your Intercom settings the method
  /// displayHelpCenterCollections will fail to load.
  /// The [collectionIds] you want to display.
  Future<void> displayHelpCenterCollections(List<String> collectionIds) {
    return _delegate.displayHelpCenterCollections(collectionIds);
  }

  /// To display an Activity with your Messages content.
  Future<void> displayMessages() {
    return _delegate.displayMessages();
  }

  /// To log events in Intercom that record what users do in your app and when they do it.
  /// For example, you can record when user opened a specific screen in your app.
  /// You can also pass [metaData] about the event.
  Future<void> logEvent(String name, [Map<String, Object?>? metaData]) {
    return _delegate.logEvent(name, metaData);
  }

  /// The [token] to send to the Intercom to receive the notifications.
  ///
  /// For the Android, this [token] must be a FCM (Firebase cloud messaging) token.
  /// For the iOS, this [token] must be a APNS token.
  Future<void> sendTokenToIntercom(String token) {
    return _delegate.sendTokenToIntercom(token);
  }

  /// When a user taps on a push notification Intercom hold onto data
  /// such as the URI in your message or the conversation to open.
  ///
  /// When you want Intercom to act on that data, use this method.
  Future<void> handlePushMessage() {
    return _delegate.handlePushMessage();
  }

  /// To open the Intercom messenger to the composer screen with [message]
  /// field pre-populated.
  Future<void> displayMessageComposer(String message) {
    return _delegate.displayMessageComposer(message);
  }

  /// To check if the push [message] is for Intercom or not.
  /// This is useful when your app is also configured to receive push messages
  /// from third parties.
  Future<bool> isIntercomPush(Map<String, String> message) async {
    return _delegate.isIntercomPush(message);
  }

  /// If the push [message] is for Intercom then use this method to let
  /// Intercom handle that push.
  Future<void> handlePush(Map<String, String> message) {
    return _delegate.handlePush(message);
  }

  /// This method allows you to set a fixed bottom padding for in app messages and the launcher.
  ///
  /// It is useful if your app has a tab bar or similar UI at the bottom of your window.
  /// [padding] is the size of the bottom padding in points.
  Future<void> setBottomPadding(int padding) {
    return _delegate.setBottomPadding(padding);
  }

  /// To display an Article, pass in an [articleId] from your Intercom workspace.
  ///
  /// An article must be ‘live’ to be used in this feature.
  /// If it is in a draft or paused state,
  /// end-users will see an error if the app tries to open the content.
  Future<void> displayArticle(String articleId) {
    return _delegate.displayArticle(articleId);
  }

  /// To display a Carousel, pass in a [carouselId] from your Intercom workspace.
  ///
  /// A carousel must be ‘live’ to be used in this feature.
  /// If it is in a draft or paused state,
  /// end-users will see an error if the app tries to open the content.
  Future<void> displayCarousel(String carouselId) {
    return _delegate.displayCarousel(carouselId);
  }

  /// To display a Survey, pass in a [surveyId] from your Intercom workspace.
  ///
  /// A survey must be ‘live’ to be used in this feature.
  /// If it is in a draft or paused state,
  /// end-users will see an error if the app tries to open the content.
  Future<void> displaySurvey(String surveyId) {
    return _delegate.displaySurvey(surveyId);
  }
}
