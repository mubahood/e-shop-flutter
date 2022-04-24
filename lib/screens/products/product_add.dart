import 'package:dio/dio.dart';
import 'package:eshops/models/product_model.dart';
import 'package:eshops/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKey = GlobalKey<FormState>();
  int counter = 0;
  TextEditingController controller_name = new TextEditingController();
  TextEditingController controller_price = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Add"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 3) {
                    return "Title too short.";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: 'What is the name of this product?',
                  labelText: 'Product Name',
                ),
                controller: controller_name,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  icon: Icon(Icons.money),
                  hintText: 'How much is this product?',
                  labelText: 'Product Price',
                ),
                controller: controller_price,
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("ADD PHOTO", style: TextStyle(color: Colors.black,fontSize: 30),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: TextButton(onPressed: () {
                      pick_from_camera();
                    },
                    child: Text("USE CAMERA"),),
                  ),
                  Container(
                    child: TextButton(onPressed: () {
                      pick_from_gallery();
                    },
                    child: Text("USE GALLERY"),),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    do_upload();
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool is_initialized = false;



  void do_upload() async {


    Map<String,dynamic> raw_form = {
      'name':'Spoons',
      'price':'650',
      'details':'Simple sugar details go here.',
    };



    if(!image_path.isEmpty){
      raw_form['image'] =  await MultipartFile.fromFile(image_path, filename: 'image');

    }
    var formData = FormData.fromMap(raw_form);
    var response = await Dio().post(
    '${Utils.BASE_URL}/api/product-create.php',
    data: formData
    );

    print("DONE....");

    return;


    //validating data
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First fix errors in the form.')),
      );
      return;
    }


    ProductModel product = new ProductModel();
    //collecing data
    product.name = controller_name.value.text.toString();
    product.price = int.parse(controller_price.value.text.toString());
    Utils.images.shuffle();
    Utils.images.shuffle();
    Utils.images.shuffle();
    product.photo = Utils.images[0];

    print("NAME ${product.price} ");


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Good to go!')),
    );
  }
  String image_path = "";
  final ImagePicker _picker = ImagePicker();
  Future<void> pick_from_camera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo!=null){
      image_path = photo.path;
    }
  }
  Future<void> pick_from_gallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if(photo!=null){
      image_path = photo.path;
    }
  }
}
