import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../entities/Event.dart';
import '../services/EventService.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({Key? key}) : super(key: key);

  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {

  final _saved = <Event>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  late Future<List<Event>> futureEvents;
  final events = <Event>[];

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
    futureEvents.then((values) => {
      for (final e in values) {
        events.add(e),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (i.isOdd) return const Divider();

                        return _buildRow(snapshot.data![i]);
                      }));
            }
          },
        ),
      ),
    );
  }

  Widget _buildRow(Event event) {
    final alreadySaved = _saved.contains(event);

    return ListTile(
      title: Text(
        event.title,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(event);
          } else {
            _saved.add(event);
          }
        });
      },
    );
  }

Future<List<Event>> fetchEvents() async {
  final response = await http
      .get(Uri.parse('http://localhost:8080/events'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EventService.parseEvents(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load events');
  }

}

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (event) {
              return ListTile(
                title: Text(
                  event.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}