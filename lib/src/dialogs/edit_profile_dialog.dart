import 'dart:io';
import '../helpers/app_constants.dart' as constants;
import 'package:arrant_construction_vendor/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EditProfileDialog extends StatelessWidget {
  final User user;
  final Function onConfirmMethod;
  final Function? onCancel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();
  final TextEditingController _pastExperianceController =
      TextEditingController();

  late final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();

  EditProfileDialog(this.user, this.onConfirmMethod, {Key? key, this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nameController.text = user.fname! + " " + user.lname!;
    _phoneController.text = "+" + user.contactNumber!;
    _shopAddressController.text = user.shopAddress!;
    _pastExperianceController.text = user.pastExperience!;

    return Platform.isAndroid
        ? AlertDialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Center(
              child: Text(
                "Edit Profile",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _profileFormKey,
                child: _ProfileData(
                    user: user,
                    nameCon: _nameController,
                    phoneCon: _phoneController,
                    shopAddCon: _shopAddressController,
                    pastExpCon: _pastExperianceController,
                    context: context),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  // if ((_nameController.text.length > 5 &&
                  //         _nameController.text.contains(' '))
                  //      &&
                  // (_phoneController.text.length == 12 &&
                  //     _phoneController.text.startsWith('+1'))
                  //   ) {
                  if (_profileFormKey.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    user.fname = _nameController.text.split(" ").first;
                    user.lname = _nameController.text.split(" ").last;
                    user.contactNumber = _phoneController.text;
                    user.pastExperience = _pastExperianceController.text;
                    user.shopAddress = _shopAddressController.text;
                    onConfirmMethod(user);
                    Get.back();
                  } else {
                    Fluttertoast.showToast(msg: "Invalid input!");
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (onCancel == null) {
                    Get.back();
                  } else {
                    onCancel!();
                  }
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(
              "Edit Profile",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _profileFormKey,
                child: _ProfileData(
                    user: user,
                    nameCon: _nameController,
                    phoneCon: _phoneController,
                    shopAddCon: _shopAddressController,
                    pastExpCon: _pastExperianceController,
                    context: context),
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  // if ((_nameController.text.length > 5 &&
                  //     _nameController.text.contains(' '))) // &&
                  // (_phoneController.text.length == 12 &&
                  //     _phoneController.text.startsWith('+1')))
                  ///   {
                  if (_profileFormKey.currentState!.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    user.fname = _nameController.text.split(" ").first;
                    user.lname = _nameController.text.split(" ").last;
                    user.contactNumber = _phoneController.text;
                    user.pastExperience = _pastExperianceController.text;
                    user.shopAddress = _shopAddressController.text;
                    onConfirmMethod(user);
                    Get.back();
                  } else {
                    Fluttertoast.showToast(msg: "Invalid input!");
                  }
                },
                child: const Text("Save"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (onCancel == null) {
                    Get.back();
                  } else {
                    onCancel!();
                  }
                },
                child: const Text("Cancel"),
              ),
            ],
          );
  }
}

class _ProfileData extends StatelessWidget {
  final User user;
  final TextEditingController nameCon;
  final TextEditingController phoneCon;
  final TextEditingController shopAddCon;
  final TextEditingController pastExpCon;

  final BuildContext context;
  const _ProfileData(
      {Key? key,
      required this.user,
      required this.nameCon,
      required this.phoneCon,
      required this.shopAddCon,
      required this.pastExpCon,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: nameCon,
          keyboardType: TextInputType.text,
          maxLines: null,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontSize: 19,
            // fontWeight: FontWeight.bold,
          ),
          // onChanged: (input) {
          //   nameCon.text = input;
          // },
          validator: (input) => input!.length < 3 || !input.contains(' ')
              ? constants.nameShouldBeMinThreeChar
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _textFormInputDecoration(
            icon: Icons.person_outline_outlined,
            labelText: '',
            hintText: "Full Name",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        TextFormField(
          controller: phoneCon,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontSize: 19,
            // fontWeight: FontWeight.bold,
          ),
          // onChanged: (input) => user.contactNumber = input,
          validator: (input) => input!.length != 11 || !input.startsWith("+1")
              ? constants.invalidNumber
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _textFormInputDecoration(
            icon: Icons.phone_android_outlined,
            labelText: '',
            hintText: "+16102347536",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        TextFormField(
          controller: shopAddCon,
          keyboardType: TextInputType.text,
          maxLines: null,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontSize: 19,
            // fontWeight: FontWeight.bold,
          ),
          // onChanged: (input) {
          //   user.shopAddress = input;
          // },
          validator: (input) => input!.isEmpty ? constants.required : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _textFormInputDecoration(
            icon: Icons.location_on_outlined,
            labelText: '',
            hintText: "Shop Address",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        TextFormField(
          controller: pastExpCon,
          keyboardType: TextInputType.text,
          maxLines: null,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontSize: 19,
            // fontWeight: FontWeight.bold,
          ),
          // onChanged: (input) {
          //   user.pastExperience = input;
          // },
          validator: (input) => input!.isEmpty ? constants.required : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _textFormInputDecoration(
            icon: Icons.work_outline_outlined,
            labelText: '',
            hintText: "Past Experiences",
          ),
        ),
      ],
    );
  }

  InputDecoration _textFormInputDecoration({
    @required String? labelText,
    @required IconData? icon,
    String hintText = "",
    Color? hintTextColor,
    Color? lableColor,
    double? lableSize,
    Color? borderColor,
    bool isHintBold = false,
    bool isLabelFloating = true,
    InputBorder? border,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: lableColor ?? Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: lableSize,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontWeight: isHintBold ? FontWeight.bold : FontWeight.normal,
        fontSize: 10,
      ),
      floatingLabelBehavior: isLabelFloating
          ? FloatingLabelBehavior.auto
          : FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(10),
      border: border ??
          OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: borderColor ??
                  Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
    );
  }
}
