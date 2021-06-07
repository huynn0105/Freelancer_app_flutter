import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:get/get.dart';

class JobOffersScreen extends StatelessWidget {
  final controller = Get.find<JobDetailController>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // void sendOffer() async {
    //   if (formKey.currentState.validate()) {
    //     final  result = await controller.sendOffer();
    //     if (result) {
    //       Get.snackbar('Success', 'Register Success ',
    //           snackPosition: SnackPosition.BOTTOM);
    //       Get.offAllNamed(Routes.home);
    //     } else {
    //       Get.snackbar('Error', controller.message.value,
    //           backgroundColor: Colors.red,
    //           colorText: Colors.white,
    //           snackPosition: SnackPosition.TOP);
    //     }
    //   } else {
    //     Get.snackbar('Error', 'Kiểm tra lại thông tin',
    //         backgroundColor: Colors.red,
    //         colorText: Colors.white,
    //         snackPosition: SnackPosition.TOP);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Offer information'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Column(
                  children: [
                    EditBox(
                      title: 'Proposed cost',
                      hint: '10,000,000',
                      validator:
                          MinLengthValidator(1, errorText: "Can't be left blank"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsFormatter()],
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'VNĐ',
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding,),
                    EditBox(
                      title: 'Expected to be completed in',
                      hint: '6 ',
                      validator:
                          MinLengthValidator(1, errorText: "Can't be left blank"),
                      keyboardType: TextInputType.number,
                      suffixIcon: PopupMenuButton(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Week',
                          ),
                        ),
                        itemBuilder: (BuildContext bc) => [
                          PopupMenuItem(
                            child: Text(
                              'Day',
                            ),
                            value: "/Day",
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Week',
                            ),
                            value: "/Week",
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Month',
                            ),
                            value: "/Month",
                          ),
                        ],
                        onSelected: (route) {
                          print(route);
                          // Note You must create respective pages for navigation
                          // Navigator.pushNamed(context, route);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Proposal to convince customers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding/2,
                    ),
                    Text(
                      '1.What experiences and skills do you have that would be a good fit for this project?',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),

                    InputText(
                      hint:
                          '''- I have xx years of experience in this field..\n- I am proficient in using tools such as...\n- I've done similar projects in the past...''',
                      maxLines: 5,
                      validator:
                          MinLengthValidator(1, errorText: "Can't be left blank"),
                    ),
                    SizedBox(
                      height: kDefaultPadding/2,
                    ),
                    Text(
                      '2.How do you plan to do this project?',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    InputText(
                      hint:
                          '''- First I will...\n- Then I will...\n- I believe it will be completed as planned''',
                      maxLines: 5,
                      validator:
                          MinLengthValidator(1, errorText: "Can't be left blank"),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Your contact information',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     SizedBox(
                //       height: kDefaultPadding/2,
                //     ),
                //     InputText(
                //       hint: 'Phone',
                //       icon: Icon(Icons.phone),
                //     ),
                //     SizedBox(
                //       height: kDefaultPadding/2,
                //     ),
                //     InputText(
                //       hint: 'Skype',
                //       icon: Icon(FontAwesomeIcons.skype),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                RoundedButton(
                    onTap: () {
                      controller.sendOffer();
                    },
                    child: Text(
                      'Send offer',
                      style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                    )),
                SizedBox(
                  height: kDefaultPadding*2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditBox extends StatelessWidget {
  const EditBox({
    this.controller,
    this.title,
    this.hint,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    Key key,
  }) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: kDefaultPadding/4,
        ),
        InputText(
          hint: hint,
          controller: controller,
          suffixIcon: suffixIcon,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
        ),
      ],
    );
  }
}
