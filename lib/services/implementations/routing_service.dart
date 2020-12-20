import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notebook/pages/contacts.dart';

@named
@prod
@Injectable()
class RoutingService with ChangeNotifier {
  Widget selectedPage;
  String title;

  List<Routing> pages = <Routing>[
    new Routing('Contacts', MaterialPage(child: Contacts()))
  ];

  void onPageChange(Routing selectedPage) {
    this.title = selectedPage.name;
    this.selectedPage = selectedPage.page.child;
  }
}

class Routing {
  String name;
  MaterialPage page;

  Routing(String name, MaterialPage page) {
    this.name = name;
    this.page = page;
  }
}
