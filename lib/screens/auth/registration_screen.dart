import 'package:flutter/material.dart';
import 'package:delivery_client/utils/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:delivery_client/screens/auth/login_screen.dart'; // For navigation

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  Country _selectedCountry = Country.parse('US'); // Default country

  // Controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.6,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kBorderRadiusStandard),
          topRight: Radius.circular(kBorderRadiusStandard),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: InkWell(
                    onTap: _showCountryPicker,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                      child: Text(
                        '${_selectedCountry.flagEmoji} +${_selectedCountry.phoneCode}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // Add more specific phone validation if needed
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  // Placeholder for strength indicator (e.g., suffixIcon or a separate widget)
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              // Simple Password Strength Indicator (Visual Only)
              Container(
                height: 5,
                margin: const EdgeInsets.only(top: 4, bottom: kDefaultPadding),
                decoration: BoxDecoration(
                  color: _passwordController.text.isEmpty
                      ? kNeutralLightGrayColor
                      : (_passwordController.text.length < 6 ? kErrorColor : kSuccessColor),
                  borderRadius: BorderRadius.circular(kBorderRadiusStandard),
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: theme.textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: theme.colorScheme.primary, decoration: TextDecoration.underline),
                            // recognizer: TapGestureRecognizer()..onTap = () => print('Terms of Service tapped'),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: theme.colorScheme.primary, decoration: TextDecoration.underline),
                            // recognizer: TapGestureRecognizer()..onTap = () => print('Privacy Policy tapped'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_termsAccepted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Please accept the terms of service.')));
                      return;
                    }
                    // Process registration
                    print('Registration form valid and terms accepted');
                  }
                },
                child: const Text('Create Account'),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Text('Or sign up with', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
              const SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Placeholder for Social Login Buttons
                  IconButton(
                    icon: const Icon(Icons.g_mobiledata, size: 40),
                    onPressed: () {},
                    tooltip: "Sign up with Google",
                  ), // Example
                  IconButton(icon: const Icon(Icons.apple, size: 40), onPressed: () {}, tooltip: "Sign up with Apple"),
                ],
              ),
              const SizedBox(height: kDefaultPadding * 2),
              TextButton(
                onPressed: () {
                  // Navigate to Login Screen
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: const Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
