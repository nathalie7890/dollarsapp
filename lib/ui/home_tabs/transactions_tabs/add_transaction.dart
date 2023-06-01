import 'package:dollar_app/data/model/trans.dart';
import 'package:dollar_app/service/auth_service.dart';
import 'package:dollar_app/service/trans_service.dart';
import 'package:dollar_app/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ui
import '../../colors.dart';
import "../../widgets/horizontal_divider.dart";
import '../../widgets/nunito_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dollar_app/ui/home_tabs/transactions_tabs/widgets/add_edit_widgets.dart';

// utils
import '../../widgets/toast.dart';

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final auth = AuthService();
  final transService = TransactionService();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // visibility of date picker
  bool _datePickerDropDown = false;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  DateTime _date = DateTime.now();
  String _type = "income";
  String _category = "salary";

  bool _isSubmitLoading = false;
  bool _titleError = false;
  bool _amountError = false;

// value of date picker
  void _onDateSelected(DateRangePickerSelectionChangedArgs args) {
    final DateTime selectedDate = args.value is DateTime
        ? args.value
        : (args.value as PickerDateRange).startDate;

    setState(() {
      _date = selectedDate;
    });

    debugPrint('Selected Date: ${selectedDate.toString()}');
  }

// onChange for category input
  void _categoryOnChange(String? value) {
    setState(() {
      _category = value ?? '';
    });
  }

// drop down options for category drop down
  final List<String> _expenseCategories = [
    'grocery',
    'transport',
    'recreation',
    "food",
    "bills",
    "clothing",
    "medical",
  ];

  final List<String> _incomeCategories = [
    'salary',
    'investment',
    'passive',
    "bonus",
  ];

  _onIncomeBtnClicked() {
    setState(() {
      _type = "income";
      _category = "salary";
    });
  }

  _onExpenseBtnClicked() {
    setState(() {
      _type = "expense";
      _category = "grocery";
    });
  }

  // toggle visibility of date picker
  _onTapDatePicker() {
    setState(() {
      _datePickerDropDown = !_datePickerDropDown;
    });
  }

  // image upload2
  File? selectedImage;
  _onTapImageUpload() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

// add transaction
  Future<bool> _addTransaction(Transaction transaction, File? imageFile) async {
    return await transService.addTrans(transaction, imageFile);
  }

  // add btn click
  _onAddBtnClicked() {
    if (_title.text.isEmpty) {
      setState(() {
        _titleError = true;
      });
      return;
    }

    if ((double.tryParse(_amount.text) ?? 0.0) < 0) {
      setState(() {
        _amountError = true;
      });
      return;
    }

    setState(() {
      _isSubmitLoading = true;
    });

    final uid = auth.getUid();

    if (uid.isNotEmpty) {
      final transaction = Transaction(
          uid: uid,
          title: _title.text,
          amount: double.tryParse(_amount.text) ?? 0.0,
          note: _note.text,
          date: _date,
          category: _category,
          type: _type);
      _addTransaction(transaction, selectedImage).then((value) => {
            if (value == true)
              {
                setState(() {
                  _isSubmitLoading = false;
                }),
                showToast("Added successfully!"),
                context.pop(_type)
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // type
                typeBtns(_type, _onIncomeBtnClicked, _onExpenseBtnClicked),
                const SizedBox(height: 15),

                // title input
                transInput("Title", _title),
                const SizedBox(
                  height: 3,
                ),
                _titleError
                    ? nunitoText(
                        "Title is required", 15, FontWeight.w500, expense_red)
                    : Container(),
                const SizedBox(height: 15),

                // amount input
                transInput("Amount", _amount, isNumber: true),
                const SizedBox(height: 15),
                _amountError
                    ? nunitoText(
                        "Amount is required", 15, FontWeight.w500, expense_red)
                    : Container(),
                const SizedBox(height: 15),

                // date dropdown
                nunitoText("Date", 15, FontWeight.bold, Colors.grey.shade700),
                const SizedBox(height: 10),

                dateRow(_onTapDatePicker, _date),
                const SizedBox(height: 6),

                _datePickerDropDown ? datePicker(_onDateSelected) : Container(),
                divider(color: Colors.grey.shade500),

                // category dropdown
                nunitoText(
                    "Category", 15, FontWeight.bold, Colors.grey.shade700),
                categoryDropDown(_category, _categoryOnChange,
                    _type == "income" ? _incomeCategories : _expenseCategories),
                const SizedBox(height: 15),

                // note input
                transInput("Note (Optional)", _note),
                const SizedBox(height: 15),

                // upload image
                nunitoText("Image (Optional)", 15, FontWeight.bold,
                    Colors.grey.shade700),
                const SizedBox(height: 15),
                selectedImage != null
                    ? Image.file(selectedImage!)
                    : imageUpload(context, _onTapImageUpload),
                const SizedBox(height: 15),

                // change image button
                selectedImage != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: _btn(_onTapImageUpload, "Change Image",
                            color: Colors.grey.shade800))
                    : Container(),
                const SizedBox(height: 15),

                // add transation button
                _isSubmitLoading
                    ? loadingSpinner(_controller)
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: _btn(_onAddBtnClicked, "Add Transaction"))
              ],
            )),
      ),
    );
  }

// upload image btn
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
}
