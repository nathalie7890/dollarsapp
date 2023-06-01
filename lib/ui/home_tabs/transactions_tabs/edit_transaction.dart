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

class EditTransaction extends StatefulWidget {
  final String id;

  const EditTransaction({Key? key, required this.id}) : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late String productId;
  final auth = AuthService();
  final transService = TransactionService();

  // visibility of date picker
  bool _datePickerDropDown = false;

  // title, note, amount
  final TextEditingController _title = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  late DateTime _date;
  late String _type;
  late String _category;
  late String? _uploadedImageUrl;

  bool _isLoading = true;
  bool _isSubmitLoading = false;
  bool _titleError = false;
  bool _amountError = false;

  // image upload
  File? selectedImage;

  void refresh() async {
    productId = widget.id;
    final res = await transService.getTransactionById(productId);
    setState(() {
      if (res != null) {
        _title.text = res.title;
        _note.text = res.note ?? "";
        _amount.text = res.amount.toString();
        _category = res.category;
        _type = res.type;
        _date = res.date;
        _uploadedImageUrl = res.image;
        _isLoading = false;
      }
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

  @override
  void initState() {
    super.initState();
    refresh();
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
      _category = value ?? _category;
    });
  }

// select income
  _onIncomeBtnClicked() {
    setState(() {
      _type = "income";
      _category = "salary";
    });
  }

// select expense
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

// select image from gallery
  _onTapImageUpload() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

//revert back to orignal image
  _useOriginalImage() {
    setState(() {
      selectedImage = null;
    });
  }

// add transaction
  Future<bool> _editTransaction(
      Transaction transaction, File? imageFile) async {
    return await transService.editTransaction(transaction, imageFile);
  }

  // add btn click
  _onAddBtnClicked() {
    if (_title.text.isEmpty) {
      setState(() {
        _titleError = true;
      });
      return;
    }

    if ((double.tryParse(_amount.text) ?? 0.0) < 0 || _amount.text.isEmpty) {
      setState(() {
        _amountError = true;
      });
      return;
    }

    setState(() {
      _isSubmitLoading = true;
    });

    final transaction = Transaction(
        id: productId,
        uid: "",
        title: _title.text,
        amount: double.tryParse(_amount.text) ?? 0.0,
        note: _note.text,
        date: _date,
        category: _category,
        type: _type,
        image: _uploadedImageUrl);
    _editTransaction(transaction, selectedImage).then((value) => {
          if (value == true)
            {
              setState(() {
                _isSubmitLoading = false;
              }),
              showToast("Updated successfully!"),
              context.go("/home/$_type")
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Transaction"),
        backgroundColor: primary,
      ),
      body: _isLoading
          ? loadingSpinner(_controller)
          : SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // type

                      typeBtns(
                          _type, _onIncomeBtnClicked, _onExpenseBtnClicked),
                      const SizedBox(height: 15),

                      // title input
                      transInput("Title", _title),
                      const SizedBox(
                        height: 3,
                      ),
                      _titleError
                          ? nunitoText("Title is required", 15, FontWeight.w500,
                              expense_red)
                          : Container(),
                      const SizedBox(height: 15),

                      // amount input
                      transInput("Amount", _amount, isNumber: true),
                      _amountError
                          ? nunitoText("Amount is required", 15,
                              FontWeight.w500, expense_red)
                          : Container(),
                      const SizedBox(height: 15),

                      // date dropdown
                      nunitoText(
                          "Date", 15, FontWeight.bold, Colors.grey.shade700),
                      const SizedBox(height: 10),

                      dateRow(_onTapDatePicker, _date),
                      const SizedBox(height: 6),

                      _datePickerDropDown
                          ? datePicker(_onDateSelected)
                          : Container(),
                      divider(color: Colors.grey.shade500),

                      // category dropdown
                      nunitoText("Category", 15, FontWeight.bold,
                          Colors.grey.shade700),
                      categoryDropDown(
                          _category,
                          _categoryOnChange,
                          _type == "income"
                              ? _incomeCategories
                              : _expenseCategories),
                      const SizedBox(height: 15),

                      // note input
                      transInput("Note (Optional)", _note),
                      const SizedBox(height: 15),

                      // upload image
                      nunitoText("Image (Optional)", 15, FontWeight.bold,
                          Colors.grey.shade700),
                      const SizedBox(height: 15),

                      // transaction image
                      selectedImage != null
                          ? Image.file(selectedImage!)
                          : _uploadedImageUrl != null
                              ? Image.network(_uploadedImageUrl!)
                              : imageUpload(context, _onTapImageUpload),
                      const SizedBox(height: 15),

                      // change image/use original image btn
                      _uploadedImageUrl != null || selectedImage != null
                          ? _changeImage()
                          : Container(),
                      const SizedBox(height: 15),

                      // add transaction button
                      _isSubmitLoading
                          ? loadingSpinner(_controller)
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: _btn(_onAddBtnClicked, "Save Transaction"))
                    ],
                  )),
            ),
    );
  }

  Row _changeImage() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: _btn(_onTapImageUpload, "Change Image",
                color: Colors.grey.shade800),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 50,
            child: _btn(_useOriginalImage, "Use Original",
                color: Colors.blue.shade800),
          ),
        )
      ],
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
