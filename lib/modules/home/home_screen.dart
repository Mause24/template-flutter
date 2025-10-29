import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/models/modules/posts_models.dart';
import 'package:template_flutter/modules/home/home_services.dart';
import 'package:template_flutter/stores/auh_store.dart';

class HttpRequestTest extends StatefulWidget {
  const HttpRequestTest({super.key});

  @override
  State<StatefulWidget> createState() => _HttpRequestTestState();
}

class _HttpRequestTestState extends State {
  List<Post>? data;

  Future<void> makeHttpRequest() async {
    final posts = await getTodos();
    print(posts);
    setState(() {
      data = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: ElevatedButton(
            onPressed: makeHttpRequest,
            child: Text("Make request"),
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            shrinkWrap: true,
            children:
                (data ?? [])
                    .map(
                      (post) => Container(
                        color: Colors.lightBlueAccent.shade100,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          spacing: 10,
                          children: [
                            Text(
                              post.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              post.body ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authActions = ref.read(authProvider.notifier);

    void onLogOut() {
      authActions.logout();
    }

    return SafeArea(
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: ElevatedButton(onPressed: onLogOut, child: Text("Log out")),
          ),
          Expanded(child: HttpRequestTest()),
        ],
      ),
    );
  }
}
