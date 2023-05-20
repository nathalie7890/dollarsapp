import 'package:dollar_app/ui/widgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isEditing = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _setIsEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  _onSaveClick() {
    setState(() {
      _isEditing = false;
    });
  }

  _onCancelClick() {
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.88,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: nunitoText("Profile", 30, FontWeight.bold, primary)),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        color: Colors.grey.shade800)
                  ]),
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/bob_marley.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _bodyContent(_isEditing),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: _isEditing
                        ? _cancelSaveBtnRow()
                        : _btn(_setIsEditing, "Edit Profile")),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Dollars App 2023",
              style: GoogleFonts.montserrat(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

// btns of cancel and save edit profile
  Widget _cancelSaveBtnRow() {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
                height: 50,
                child: _btn(_onCancelClick, "Cancel", color: burgundy))),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: SizedBox(
          height: 50,
          child: _btn(
            _onSaveClick,
            "Save",
          ),
        )),
      ],
    );
  }

// elevated button
  ElevatedButton _btn(void Function() onPressed, String title,
      {Color color = primary}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: nunitoText(title, 15, FontWeight.w500, tertiary));
  }

// body content
  Column _bodyContent(bool isEditing) {
    if (!isEditing) {
      return Column(
        children: [
          _divider(),
          _userDetail("Name", "Bob Marley", 17),
          _divider(),
          _userDetail("Email", "gigaChadBob@gmail.com", 17),
        ],
      );
    } else {
      return Column(
        children: [
          _userEditInput("Name", _name, false),
          const SizedBox(
            height: 8,
          ),
          _userEditInput("Email", _email, false),
          const SizedBox(
            height: 8,
          ),
          _userEditInput("Password", _password, true),
        ],
      );
    }
  }

// text field to edit user detail
  Container _userEditInput(
      String title, TextEditingController controller, bool isPass) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText(title, 15, FontWeight.bold, Colors.grey.shade700),
          TextField(
            obscureText: isPass,
            controller: controller,
            style: GoogleFonts.nunito(
                color: primary, fontWeight: FontWeight.w600, fontSize: 17),
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primary)),
              hintText: title,
            ),
          ),
        ],
      ),
    );
  }

// text to display user detail
  Container _userDetail(String title, String value, double valueSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText(title, 15, FontWeight.w600, Colors.grey.shade700),
          const SizedBox(height: 5),
          nunitoText(value, valueSize, FontWeight.w700, primary)
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 20,
    );
  }
}
