import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  @override
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  Iterable<Contact> _contacts;
  @override
  initState() {
    super.initState();

    _getPermission().then((PermissionStatus status) {
      setState(() {
        if (status == PermissionStatus.granted) {
          getContacts();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _contacts != null
        ? ListView.builder(
            itemCount: _contacts?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = _contacts?.elementAt(index);
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar),
                      )
                    : CircleAvatar(
                        child: Text(contact.initials()),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                title: Text(contact.displayName ?? ''),
              );
            },
          )
        : Center(child: const CircularProgressIndicator());
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      print('ffff');
      _contacts = contacts;
    });
  }
}
