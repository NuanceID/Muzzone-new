void navigateWithNavigatorKey(id, context, kNavigatorKey, removeUntil) {
  // kNavigatorKey.currentState?.popUntil((r) => r.isFirst);
  if (removeUntil) {
    kNavigatorKey.currentState?.pushNamedAndRemoveUntil(id, (context) => false);
  } else {
    kNavigatorKey.currentState?.pushNamed(id);
  }
}
