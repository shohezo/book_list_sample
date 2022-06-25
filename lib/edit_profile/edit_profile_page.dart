import 'package:book_list_sample/edit_profile/edit_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name, this.description);

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(
        name,
        description,
      ),
      //EditBookModelが作られる時にuserの情報も渡している
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール編集'),
          centerTitle: true,
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    controller: model.nameController,
                    decoration: InputDecoration(
                      hintText: '名前',
                    ),
                    onChanged: (text) {
                      model.setName(text);
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: model.descriptionController,
                    decoration: InputDecoration(
                      hintText: '自己紹介',
                    ),
                    onChanged: (text) {
                      model.setDescription(text);
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            //追加の処理
                            try {
                              await model.Update();
                              Navigator.of(context).pop();
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
