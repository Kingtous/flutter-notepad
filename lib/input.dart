import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:music_player/common.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var _image = Image.asset("assets/status_empty.png");
  var _image_path;
  var _text = "";

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image_path = image.path;
    setState(() {
      _image = Image.file(image);
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image_path = image.path;
    setState(() {
      print("更新图片");
      _image = Image.file(image);
    });
  }

  // 图片选择
  void getImage() async {
    //图库或者拍照
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("请做出你的选择！"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("图库"),
                onPressed: () {
                  getImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                child: Text("拍照"),
                onPressed: () {
                  getImageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void saveEdited() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> lists = prefs.getStringList("RecordList")??List<String>();
    lists.add(_text);
    lists.add(_image_path);
    showCupertinoDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("提示"),
        content:
          Text("保存成功"),
        actions: <Widget>[
          FlatButton(onPressed: (){
            // 回到主界面
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }, child: Text("确定"))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("输入你要记的事情"),
        ),
        body: Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: PageView(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 20,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          icon: Icon(Icons.text_fields),
                          labelText: "请输入事情描述",
                          helperText: "例如：今天我要去打篮球、约会、上课..."),
                      onChanged: (String s){
                        _text = s;
                      },
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("添加备忘图片"),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _image,
                          ),
                          CupertinoButton(
                            child: Text("选择图片"),
                            color: Colors.blue,
                            pressedOpacity: 0.5,
                            onPressed: getImage,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: FloatingActionButton.extended(
            onPressed: () {
              saveEdited();
            },
            label: Text("添加"),
            icon: Icon(Icons.add),
          ),
        ));
  }
}
