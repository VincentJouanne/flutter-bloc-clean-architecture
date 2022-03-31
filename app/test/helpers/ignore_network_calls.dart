import 'dart:io';

void ignoreNetworkCalls() {
  HttpOverrides.global = null;
}
