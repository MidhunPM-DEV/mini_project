import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniproject/features/model/contactmodel.dart';

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    return [];
  }

  void add(ContactModel contact) {
    state = [contact, ...state];
    log("added");
  }

  void delete(index, context) {
    final contacts = state;
    contacts.removeAt(index);
    state = List.from(contacts);
    Navigator.pop(context);
  }

  void edit(ContactModel newContact, index, context) {
    final contact = state;
    contact[index] = newContact;
    state = List.from(contact);
    Navigator.pop(context);
  }
}

final contactProvider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);
