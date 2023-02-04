import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../services/firebase_service.dart';
import '../models/user.dart' as u;
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  User? currentUser;
  TextEditingController dateController = TextEditingController();

  u.User updateUser = u.User();
  String? fullname;
  String? phoneNumber;

  io.File? imageFile;
  UploadTask? uploadTask;

  String? imageUrl;
  late ImageProvider<Object> currentImage = getImage(updateUser.imageUrl);
  ImageProvider<Object> defaultImage = const NetworkImage(
      'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg');

  getFromGallery() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (result != null) {
        imageFile = io.File(result.path);
      }
    });

    currentImage = FileImage(imageFile as io.File);

    
  }

  String? urlDownload;
  

  Future uploadFile() async {
    final path = 'images/${imageFile}';
    final file = io.File(imageFile!.path);

    final ref = _firebaseService.getStorage().ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });


    final snapshot = await uploadTask!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    // var url = await ref.getDownloadURL();
    log('url of image in uploadFile is $urlDownload');

    // updateUser.imageUrl = urlDownload;

    // updateUser.imageUrl = file.toString();

    // log('Download link $urlDownload');
  }

  ImageProvider<Object> getImage(String? url) {
    if (url == null) {
      if (imageFile == null) {
        return const NetworkImage(
            'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg');
      } else {
        return FileImage(imageFile as io.File);
      }
    } else {
      return NetworkImage(url);
    }
  }

  ImageProvider<Object> displayImage(String? urlFromFirebase) {
    if(currentImage is FileImage){
      return currentImage;
    }
     else {
      if ((currentImage as NetworkImage).url != urlFromFirebase && urlFromFirebase != null) {
      return NetworkImage(urlFromFirebase);
    }
    else{
      return defaultImage;
    }
      
    }
  }

  @override
  void initState() {
    super.initState();

    currentUser = _firebaseService.getCurrentUser();
    log(currentUser!.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firebaseService.getUsers().snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data!.docs;
                  for (var user in users) {
                    if (user.id == currentUser!.uid) {
                      if (currentImage == defaultImage) {
                        currentImage = displayImage(user['imageUrl']);
                      }
                      // currentImage = displayImage(user['imageUrl']);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                color: Colors.greenAccent.shade400,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    await getFromGallery();
                                    currentImage =
                                        displayImage(user['imageUrl']);

                                    //  getFromGallery();
                                  },
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height * 0.2,
                                    // width: MediaQuery.of(context).size.height * 0.2,
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: currentImage,
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              )
                            ],
                          ),
                          ProfileItem(
                            title: '${user['fullname']}',
                            label: 'Full Name',
                            icon: Icons.account_box,
                            newValue: (value) {
                              setState(() {
                                fullname = value;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: TextField(
                              controller: dateController,
                              readOnly: true,
                              onTap: _selectDate,
                              decoration: InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.calendar_month_outlined),
                                  labelText: 'Birthday',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: user['birthday'] ?? 'Your birthday',
                                  border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 0, 230, 118))),
                                  focusColor: Colors.greenAccent.shade400,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                          ),
                          ProfileItem(
                            title: user['phone'] ?? 'Your phone',
                            label: 'Phone Number',
                            icon: Icons.phone,
                            newValue: (value) {
                              phoneNumber = value;
                            },
                          ),
                          ProfileItem(
                            isChangeble: false,
                            title: '${user['email']}',
                            label: 'Email',
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RoundedButton(
                              backgroundColor: Colors.greenAccent.shade400,
                              textColor: Colors.white,
                              text: 'Save',
                              onPressed: () async {
                                await uploadFile();
                                log('url of image in save method is $urlDownload');
                                setState(() {
                                  if (urlDownload != null) {
                                    saveProfile(
                                        birthday: user['birthday'],
                                        fullname: user['fullname'],
                                        phone: user['phone'],
                                        imageURL: urlDownload);
                                  } else {
                                    saveProfile(
                                        birthday: user['birthday'],
                                        fullname: user['fullname'],
                                        phone: user['phone'],
                                        imageURL: user['imageUrl']);
                                  }
                                });
                                   _firebaseService.updateUser(
                                      updateUser, currentUser!.uid);
                                // });
                              }),
                        ],
                      );
                    }
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }

  void saveProfile(
      {String? birthday, String? fullname, String? phone, String? imageURL}) {
    updateUser.fullname = this.fullname;
    updateUser.birth = selectedDate.toString();
    updateUser.phone = phoneNumber;
    if (updateUser.birth == null || updateUser.birth == 'null') {
      updateUser.birth = birthday;
    }
    updateUser.fullname ??= fullname;
    updateUser.phone ??= phone;
    updateUser.imageUrl = imageURL;
    // updateUser.imageUrl = imageFile.toString();

    log('$updateUser');
  }

  DateTime? selectedDate;

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context, //moguci problem
        initialDate: selectedDate ??= DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = '$selectedDate';
    }
  }
}

class ProfileItem extends StatefulWidget {
  String title;
  String label;
  IconData icon;
  Function? newValue;
  bool isChangeble;

  ProfileItem(
      {required this.title,
      required this.label,
      required this.icon,
      this.newValue,
      this.isChangeble = true});

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: TextField(
            enabled: widget.isChangeble,
            onChanged: ((value) => widget.newValue!(value)),
            decoration: InputDecoration(
                suffixIcon: Icon(widget.icon),
                labelText: widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.title,
                border: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 230, 118))),
                focusColor: Colors.greenAccent.shade400,
                hintStyle: const TextStyle(
                  fontSize: 16,
                )),
            // widget.title,
            // style: TextStyle(fontSize: 16),
          ),
        ),
        // Divider(color: Colors.black),
      ],
    );
  }
}
