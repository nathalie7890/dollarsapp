import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ui
import '../colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dollar_app/ui/widgets/nunito_text.dart';

// utils
import '../utils/utils.dart';
import '../widgets/toast.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final auth = AuthService();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();

    _getCurrentUser();
    super.initState();
  }

  bool _isEditing = false;
  bool _isSubmitLoading = false;

  String username = "";
  String email = "";
  String userId = "";
  String photoUrl = '';

  _getCurrentUser() {
    final user = auth.getCurrentUser();

    if (user != null) {
      setState(() {
        username = user.displayName ?? "";
        email = user.email ?? "";
        userId = user.uid;
        photoUrl = user.photoURL ?? "";

        _username.text = user.displayName ?? "";
        _email.text = user.email ?? "";
      });
    }
  }

  _setIsEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  bool _nameError = false;
  bool _emailError = false;
  bool _passError = false;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // validate every input
  bool _isValid() {
    setState(() {
      _nameError = _username.text.length < 3;
      _emailError = !Utils.isEmailValid(_email.text);
      _passError = _password.text.length < 5;
    });

    List<bool> boolList = [
      _nameError,
      _emailError,
      _passError,
    ];

    return !boolList.contains(true);
  }

// save profile update
  _onSaveClick() {
    if (_isValid()) {
      setState(() {
        _isSubmitLoading = true;
      });

      _updateUser()
          .then((value) => {
                if (value == true)
                  {
                    setState(() {
                      _isEditing = false;
                      _password.text = "";
                    })
                  }
                else
                  {
                    setState(() {
                      _passError = true;
                    })
                  },
                setState(() {
                  _isSubmitLoading = false;
                })
              })
          .then((value) => _getCurrentUser());
    }
  }

  Future<bool> _updateUser() async {
    return await auth.updateUser(
        _username.text, _email.text, _password.text, selectedImage);
  }

// select image
  File? selectedImage;

  _onProfilePicTap() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

// when cancel btn is clicked
  _onCancelClick() {
    setState(() {
      _isEditing = false;
      selectedImage = null;
    });

    _getCurrentUser();
  }

// logout
  _onLogoutClick() {
    auth.logout().then((value) => context.go("/login"));
  }

  _onPasswordChange() async {
    await auth.auth.sendPasswordResetEmail(email: email);
    showToast("Link is sent!");
  }

  @override
  dispose() {
    _controller.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // title and logout btn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nunitoText("Profile", 25, FontWeight.bold, primary),
                SizedBox(
                  height: 25,
                  child: _btn(() {
                    _onLogoutClick();
                  }, "Logout"),
                )
              ],
            ),
            const SizedBox(height: 25),

            // profile pic card
            _profilePicCard(context),
            const SizedBox(height: 20),

            // body content
            _isEditing ? _editUser() : _nameEmail(),
            const SizedBox(height: 20),

            // edit profile/save edit btn
            SizedBox(
                height: 50,
                width: double.infinity,
                child: _isEditing
                    ? _cancelSaveBtnRow()
                    : _btn(_setIsEditing, "Edit Profile")),
            const SizedBox(height: 10),
            _footer()
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: nunitoText("Change password", 16, FontWeight.bold, primary),
          content: nunitoText(
              "A link with reset password instructions will be sent to your email. Click Ok to conirm.",
              15,
              FontWeight.w500,
              primary),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: expense_red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                _onPasswordChange();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Text _footer() {
    return Text(
      "Dollars App 2023",
      style: GoogleFonts.montserrat(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
          fontSize: 14),
    );
  }

  Container _profilePicCard(BuildContext context) {
    return Container(
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
        child: GestureDetector(
          onTap: () {
            _isEditing ? _onProfilePicTap() : {};
          },
          child: CircleAvatar(
            radius: 50,
            child: ClipOval(
                child: AspectRatio(
              aspectRatio: 1.0,
              child: selectedImage != null
                  ? Image.file(selectedImage!)
                  : photoUrl.isNotEmpty
                      ? Image.network(photoUrl)
                      : Image.asset("assets/images/logo.png"),
            )),
          ),
        ),
      ),
    );
  }

// btns of cancel and save edit profile
  Widget _cancelSaveBtnRow() {
    return _isSubmitLoading
        ? loadingSpinner(_controller)
        : Row(
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

// edit user input
  Column _editUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _divider(),
        _userEditInput("Name", _username, false),
        _invalidInput(_nameError, "Invalid username"),
        const SizedBox(
          height: 8,
        ),
        _userEditInput("Email", _email, false),
        _invalidInput(_emailError, "Invalid email"),
        const SizedBox(height: 10),
        nunitoText("Enter your password before saving.", 15, FontWeight.w400,
            Colors.blue.shade700),
        const SizedBox(
          height: 8,
        ),
        _userEditInput("Password", _password, true),
        _invalidInput(_passError, "Invalid password"),
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
              onTap: () {
                _showDialog(context);
              },
              child: nunitoText("Change password?", 15, FontWeight.bold,
                  Colors.blue.shade700)),
        )
      ],
    );
  }

// display name and email
  Column _nameEmail() {
    return Column(
      children: [
        _divider(),
        _userDetail("Name", username, 17),
        _divider(),
        _userDetail("Email", email, 17),
      ],
    );
  }

// text field to edit user detail
  Column _userEditInput(
      String title, TextEditingController controller, bool isPass) {
    return Column(
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
                borderSide: BorderSide(color: primary, width: 2)),
            hintText: title,
          ),
        ),
      ],
    );
  }

// invalid input
  Widget _invalidInput(bool error, String errorMessage) {
    return error
        ? nunitoText(errorMessage, 17, FontWeight.w500, expense_red)
        : Container();
  }

// text to display user detail
  SizedBox _userDetail(String title, String value, double valueSize) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nunitoText(title, 15, FontWeight.w600, Colors.grey.shade700),
          const SizedBox(height: 5),
          nunitoText(value, valueSize, FontWeight.w600, primary)
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
