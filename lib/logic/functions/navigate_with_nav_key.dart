void navigateWithNavigatorKey(id, context, kNavigatorKey, removeUntil) {
  // kNavigatorKey.currentState?.popUntil((r) => r.isFirst);
  if (removeUntil) {
    kNavigatorKey.currentState?.pushNamedAndRemoveUntil(id, (route) => false);
  } else {
    kNavigatorKey.currentState?.pushNamed(id);
  }
}
