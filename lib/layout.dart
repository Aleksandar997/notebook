import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'pages/contacts.dart';
import 'services/implementations/routing_service.dart';

@injectable
class Layout extends StatefulWidget {
  final RoutingService routing = new RoutingService();
  @override
  _Layout createState() => _Layout(routing);
}

class _Layout extends State<Layout> {
  _Layout(RoutingService _routing) {
    routing = _routing;
  }
  RoutingService routing;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    var selectedPage = routing.pages.elementAt(index);
    print(selectedPage);
    setState(() {
      routing.onPageChange(selectedPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    _onItemTapped(_selectedIndex);
    return Scaffold(
      appBar: AppBar(title: Text(routing.title)),
      // body: _widgetOptions.elementAt(_selectedIndex),
      body: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('Contacts'),
            child: Contacts(),
          ),
          MaterialPage(
            child: routing.selectedPage,
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => setState(() => {LayourService.title.add('layout')}),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
