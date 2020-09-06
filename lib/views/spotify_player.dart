import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

class SpotifyPlayer extends StatefulWidget {
  @override
  _SpotifyPlayerState createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final credentials = SpotifyApiCredentials('45fd3c0e9208458fa73fb1295cdcc82f', '0818c0e2f2c542e4a6d9573f583fba10');
    final grant = SpotifyApi.authorizationCodeGrant(credentials);
    final authUri = grant.getAuthorizationUrl(
      Uri.parse('https://dannyhyatt.com/yes/'),
      scopes: ['user-read-playback-state', 'streaming', 'user-read-email', 'playlist-read-collaborative', 'user-modify-playback-state', 'user-read-private', 'user-top-read', 'user-read-playback-position', 'user-read-currently-playing', 'playlist-read-private', 'app-remote-control'],
    );
    debugPrint(authUri.toString());
    final spotify = SpotifyApi.fromAuthCodeGrant(grant, Uri.parse('https://dannyhyatt.com/yes/?code=AQAg66yNCyunmnYiC8rrbt0OrUab89-KGL1hLe4sebEvLMRhpO325xeP7ZFROBxwpqWjgM0CyI6uiBmCYzAifFLpPMCdhuFWreDnXZmLGj1lao2b8b2t3SXJuvlueOU_oRUDkkL0geSF6tz9EYL13gBmKj0vGJ8yjRuNkNg8Vx4vsnQfq5VtNt4xNUESX66PEHpIvshMTsQbFUR0EkJtKwyVDefXqJQpz9nH7nbO9YBGJVIFvrKi6aUTXpv6_pjQc5qOpd7iPhcKGn2Zy4qMjDmcf3C6hJoes0GhvpdYzfcaDTlgfvQiqQQDABXPHDjA3PzKV6sbzYrvWmfZUihHdZnKetGoT6ceq3BvSlhAJU-7xnoqjLxBmWI45IvAXeU7HX1gL0Y67NxmkPAcgPaZiNeFYqEgd00t9JCYE-YTv-iAvzf4Z3RG2d2BmIfCnauBmbvxcucecxwjf1D6HCJgwfxeOTdGoqeP44rOuqc_Ns2Cw1bkW6stfxy6Cq5RDSZMtaAPHM3GP0ksEHjPMd_kTCZ79j6cwlMG1XDA3-79IKh2Dvc0R3lCtg').toString());
    final me = await spotify.me.get();
//    final authCode = 'AQCqlHd7H5ZUDf4a0cbivLopV9qoUGU13qKoitsF3Y5ICd9_1dXZ5fZWhH8HDbph6tSrCsMeYxrWHN5Gbd03m9g0Yhm2eWp6aIwG68j3ZtDbk5cIZe0kSyM0-XX0PLVN2ZeJcHQHuj7UWpsMjFjoH9tBoknXRYn5VVR7w3WulLdZcbQzenSvRhSFnzBnMglMpkUDfoVLtCoOobHJbRjiavfYDINSWpGCLAASRSwk6Ms5oiOgF2UcsLGZw8bLu9VacJsHfErnmiGM7-VwctGS1Vnd-KtbWUFdMgK4CfdnV9oA1F9-Kl14gXC2DUZ2fXgixeEZ5fyDf6GjysPpEFsKFrYlKU3sLr-cIGknk-fHfd85geg17nDy3NZY_rkOy01PDpgkWvgs_oILeAJ-hKeMyN725suqSAFG8ojoZ2o9Ajq3KlE3IHuAZFeCKCIU1VtwIKesQUmfPG83fGkuGMsvmAtaeBR-mDGH4K1kFJek3L006NWcXw';
    debugPrint('got: ${me.email}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation(Color(0xff1db954)),
        ),
      ),
    );

    return Container();
  }
}
