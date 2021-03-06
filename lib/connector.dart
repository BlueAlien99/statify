import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

enum ConnectionState { uninitialized, initializing, connected, error, reconnecting }

class Connector {
  // Singleton

  static final Connector _connector = Connector._();

  factory Connector() {
    return _connector;
  }

  Connector._();

  // Implementation

  String _token = '';
  String _lastMessage = '';
  StreamSubscription? _sdkConnectionSubscription;
  StreamSubscription? _sdkPlayerSubscription;
  final _connectionState = BehaviorSubject.seeded(ConnectionState.uninitialized);
  final _playerState = BehaviorSubject<PlayerState>();
  final _reconnectionDelay = const Duration(milliseconds: 200);

  String get token {
    return _token;
  }

  String get lastMessage {
    return _lastMessage;
  }

  Stream<ConnectionState> subscribeConnectionState() {
    return _connectionState;
  }

  Stream<PlayerState> subscribePlayerState() {
    return _playerState;
  }

  Future<String> generateToken() {
    return SpotifySdk.getAuthenticationToken(
            clientId: dotenv.env['CLIENT_ID'].toString(),
            redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
            scope: [
              'app-remote-control',
              'user-modify-playback-state',
              'playlist-read-private',
              'user-read-private'
            ].join(', '))
        .then((token) {
      _token = token;
      return _token;
    }).catchError((error) {
      _lastMessage = error.toString();
      _connectionState.add(ConnectionState.error);
      return '';
    });
  }

  Future<bool> connectToRemote() {
    return SpotifySdk.connectToSpotifyRemote(
            clientId: dotenv.env['CLIENT_ID'].toString(),
            redirectUrl: dotenv.env['REDIRECT_URL'].toString())
        .catchError((error) {
      _lastMessage = error.toString();
      _connectionState.add(ConnectionState.error);
      return false;
    });
  }

  Future<void> init() {
    _connectionState.add(ConnectionState.initializing);
    _sdkConnectionSubscription ??= SpotifySdk.subscribeConnectionStatus().listen((event) {
      _lastMessage = 'errorCode: ${event.errorCode ?? ''}\nmessage: ${event.message}';
      if (event.connected) {
        return _connectionState.add(ConnectionState.connected);
      }
      if (_connectionState.value == ConnectionState.connected &&
          event.errorCode == 'SpotifyDisconnectedException') {
        Timer(_reconnectionDelay, connectToRemote);
        return _connectionState.add(ConnectionState.reconnecting);
      }
      if (_connectionState.value == ConnectionState.reconnecting) {
        return;
      }
      debugPrint(_lastMessage);
      return _connectionState.add(ConnectionState.error);
    });
    _sdkPlayerSubscription ??= _connectionState
        .switchMap((_) => SpotifySdk.subscribePlayerState())
        .listen(_playerState.add);
    return generateToken().then((token) => token.isEmpty ? null : connectToRemote());
  }
}
