import 'package:flutter/material.dart';

class ContactField extends StatelessWidget {
  const ContactField(
      {super.key,
      bool isEdit = false,
      required this.formkey,
      required this.namecontroller,
      required this.phonecontroller,
      required this.onsubmit});

  final GlobalKey<FormState> formkey;
  final TextEditingController namecontroller;
  final TextEditingController phonecontroller;
  final VoidCallback onsubmit;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              namecontroller.clear();
              phonecontroller.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          IconButton(
            onPressed: onsubmit,
            icon: const Icon(Icons.check),
          )
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[350],
            radius: 80,
            child: Icon(
              Icons.person,
              color: Colors.grey[400],
              size: 50,
            ),
          ),
          Positioned(
            top: 120,
            left: 120,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF00C368),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.photo_camera,
                  size: 15,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phonecontroller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "phone number cannot be empty";
                    }
                    if (value.length < 10) {
                      return "enter valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
              ],
            ),
          )),
    ]));
  }
}
