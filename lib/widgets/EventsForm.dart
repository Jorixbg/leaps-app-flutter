import 'package:flutter/material.dart';

// Define a custom Form widget.
class EventsForm extends StatefulWidget {
  const EventsForm({Key? key}) : super(key: key);

  @override
  EventsFormState createState() {
    return EventsFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class EventsFormState extends State<EventsForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<EventsFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}