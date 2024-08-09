import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class ClientController extends GetxController {
  final ImagePicker picker = ImagePicker();
  String? selectedTrip;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  XFile? imageFile;

  Future<void> uploadClient(
      String amount, String description, XFile imageFile) async {
    try {
      // Upload receipt to S3
      final key = DateTime.now().toString();

      // Get URL of uploaded receipt
      final url = await Amplify.Storage.getUrl(key: key);

      // Create Client entry in GraphQL
      final date = DateTime.now().toIso8601String();
      final user = "user-id"; // replace with actual user ID
      // final receiptUrl = url.url;

      final createClientDocument =
          '''mutation CreateClient(\$input: CreateClientInput!) {
        createClient(input: \$input) {
          id
          date
          user
          amount
          description
          receiptUrl
        }
      }''';

      final variables = {
        'input': {
          'date': date,
          'user': user,
          'amount': double.parse(amount),
          'description': description,
          // 'receiptUrl': receiptUrl,
        }
      };

      final response = await Amplify.API
          .mutate(
            request: GraphQLRequest(
                document: createClientDocument, variables: variables),
          )
          .response;

      if (response.errors.isEmpty) {
        print('Client created: ${response.data}');
      } else {
        print('Errors: ${response.errors}');
      }
    } catch (e) {
      print('Error uploading client: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // setState(() {
    imageFile = image;
    // });
    update();
  }

  void chooseTrip(String? value) {
    selectedTrip = value;
    update();
  }

  Future<void> submitExpense() async {
    if (imageFile == null) return;

    final amount = amountController.text;
    final description = descriptionController.text;

    await uploadClient(amount, description, imageFile!);
  }
}
