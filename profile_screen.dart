import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();

  String fName;
  String lName;
  String number;
  String pincode;
  DateTime birthDate;
  String birthDateInString;
  bool isDateSelected = false;
  String gender;
  String bloodGroup;
  String allergy;
  String comorbidies;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 80.0,
                    child: Icon(
                      Icons.face,
                      size: 70.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Enter Profile Details',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  firstName(),
                  SizedBox(
                    height: 10.0,
                  ),
                  lastName(),
                  SizedBox(
                    height: 20.0,
                  ),
                  emergencyNumber(),
                  SizedBox(
                    height: 30.0,
                  ),
                  picCodeSelection(),
                  SizedBox(
                    height: 30.0,
                  ),
                  dateOfBirth(),
                  SizedBox(
                    height: 10.0,
                  ),
                  genderSelection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  bloodGroupSelection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  allergySelection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  comorbidiesSelection(),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    onPressed: () {
                      final isValid = formKey.currentState.validate();

                      if (isValid) {
                        formKey.currentState.save();
                      }

                      firstNameController.clear();
                      lastNameController.clear();
                      numberController.clear();
                      pincodeController.clear();
                      birthDateInString = 'select Date';
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'First Name',
      ),
      controller: firstNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter first name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          fName = value;
        });
      },
    );
  }

  Widget lastName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Last Name',
      ),
      controller: lastNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter first name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          number = value;
        });
      },
    );
  }

  Widget emergencyNumber() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Contact Number',
      ),
      controller: numberController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter Number';
        } else if (value.length != 10) {
          return 'Enter Correct Number';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          fName = value;
        });
      },
    );
  }

  Widget picCodeSelection() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'PinCode',
      ),
      controller: pincodeController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter pincode';
        } else if (value.length != 6) {
          return 'Enter Correct pincode';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          pincode = value;
        });
      },
    );
  }

  Widget dateOfBirth() {
    return Row(
      children: [
        Text(
          'Birth Date',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          width: 20.0,
        ),
        GestureDetector(
          child: new Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime(1900),
                lastDate: new DateTime(2100));
            if (date != null && date != birthDate) {
              setState(
                () {
                  birthDate = date;
                  isDateSelected = true;
                  birthDateInString =
                      "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                },
              );
            }
          },
        ),
        SizedBox(
          width: 20.0,
        ),
        if (isDateSelected) Text(birthDateInString),
        if (!isDateSelected) Text(' Select Date'),
      ],
    );
  }

  Widget genderSelection() {
    return Row(
      children: [
        Text(
          'Gender  ',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          width: 70.0,
        ),
        DropdownButton<String>(
          value: gender,
          onChanged: (String newValue) {
            setState(() {
              gender = newValue;
            });
          },
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget bloodGroupSelection() {
    return Row(
      children: [
        Text(
          'Blood Group ',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          width: 50.0,
        ),
        DropdownButton<String>(
          value: bloodGroup,
          onChanged: (String newValue) {
            setState(() {
              bloodGroup = newValue;
            });
          },
          items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget allergySelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Allergy ',
          style: TextStyle(fontSize: 20.0),
        ),
        DropdownButton<String>(
          value: allergy,
          onChanged: (String newValue) {
            setState(() {
              allergy = newValue;
            });
          },
          items: <String>[
            'Overactive Immune System',
            'Animal Dander',
            'Dust Mites',
            'Insect Stings',
            'Food Allergy',
            'Medication Allergy',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget comorbidiesSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Co - morbidies ',
          style: TextStyle(fontSize: 20.0),
        ),
        DropdownButton<String>(
          value: comorbidies,
          onChanged: (String newValue) {
            setState(() {
              comorbidies = newValue;
            });
          },
          items: <String>[
            'Hypertension',
            'heart Disease',
            'Diabetes',
            'High Blood Pressure',
            'Depression',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
