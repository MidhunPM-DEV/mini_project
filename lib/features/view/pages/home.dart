import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniproject/features/model/contactmodel.dart';
import 'package:miniproject/features/providers/contactprovider.dart';
import 'package:miniproject/features/view/widgets/contactfield.dart';
import 'package:miniproject/features/view/widgets/headerwidget.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HeaderWidget(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ContactField(
              formkey: formkey,
              namecontroller: namecontroller,
              phonecontroller: phonecontroller,
              onsubmit: () {
                if (formkey.currentState!.validate()) {
                  ref.read(contactProvider.notifier).add(
                        ContactModel(
                            name: namecontroller.text,
                            phone: phonecontroller.text),
                      );
                  namecontroller.clear();
                  phonecontroller.clear();
                  Navigator.pop(context);
                }
              },
            ),
          );
        },
      ),
      body: ref.watch(contactProvider).isEmpty
          ? const Center(
              child: Text("No contacts"),
            )
          : ListView.builder(
              itemCount: ref.watch(contactProvider).length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => PopUp(
                      onsubmit: () {
                        ref.read(contactProvider.notifier).edit(
                            ContactModel(
                                name: namecontroller.text,
                                phone: phonecontroller.text),
                            index,
                            context);
                        namecontroller.clear();
                        phonecontroller.clear();
                      },
                      name: namecontroller,
                      phone: phonecontroller,
                      formkey: formkey,
                      index: index,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(),
                      title: Text(ref.watch(contactProvider)[index].name),
                      subtitle: Text(ref.watch(contactProvider)[index].phone),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00C368),
        onPressed: () {},
        child: const Icon(Icons.dialpad),
      ),
    );
  }
}

class PopUp extends ConsumerWidget {
  final GlobalKey<FormState> formkey;
  final int index;
  final VoidCallback onsubmit;
  final TextEditingController name;
  final TextEditingController phone;
  const PopUp({
    required this.onsubmit,
    required this.name,
    required this.phone,
    required this.formkey,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              ref.watch(contactProvider.notifier).delete(index, context);
            },
            child: const Text("Delete"),
          ),
          TextButton(
            onPressed: () {
              name.text = ref.watch(contactProvider)[index].name;
              phone.text = ref.watch(contactProvider)[index].phone;
              showModalBottomSheet(
                context: context,
                builder: (context) => ContactField(
                  formkey: formkey,
                  namecontroller: name,
                  phonecontroller: phone,
                  onsubmit: onsubmit,
                ),
              );
            },
            child: const Text("Edit"),
          ),
        ],
      ),
    );
  }
}
