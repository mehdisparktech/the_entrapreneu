import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:the_entrapreneu/features/auth/sign%20up/presentation/widget/success_profile.dart';
import 'package:the_entrapreneu/utils/constants/success_dialog.dart';

class OfferDialog {
  static void show(
      BuildContext context, {
        required double budget,
        required DateTime serviceDate,
        required String serviceTime,
        required VoidCallback onSubmit,
      }) {
    final TextEditingController budgetController =
    TextEditingController(text: '\$${budget.toStringAsFixed(0)}');

    final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd MMMM yyyy').format(serviceDate),
    );

    final TextEditingController timeController = TextEditingController(
      //text: serviceTime.format(context),
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title + Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Custom Offer',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Budget Field
                TextField(
                  controller: budgetController,
                  decoration: InputDecoration(
                    labelText: 'Budget',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.h),

                // Service Date Field
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Service Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: serviceDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      dateController.text =
                          DateFormat('dd MMMM yyyy').format(pickedDate);
                    }
                  },
                ),
                SizedBox(height: 12.h),

                // Service Time Field
                TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Service Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onTap: () async {
                    /*TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: serviceTime,
                    );
                    if (pickedTime != null) {
                      timeController.text = pickedTime.format(context);
                    }*/
                  },
                ),
                SizedBox(height: 20.h),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      SuccessDialog();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
