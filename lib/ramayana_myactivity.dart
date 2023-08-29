import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:myactivity_project/models/model_edit_myactivity.dart';
import 'package:myactivity_project/models/model_list_task.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:http/http.dart' as http;
import 'package:myactivity_project/models/model_list_project.dart';
import 'package:notification_permissions/notification_permissions.dart' as notifPermission;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:text_area/text_area.dart';

class RamayanaMyActivity extends StatefulWidget {
  const RamayanaMyActivity({super.key});

  @override
  State<RamayanaMyActivity> createState() => _RamayanaMyActivityState();
}

class _RamayanaMyActivityState extends State<RamayanaMyActivity> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController date = TextEditingController();
  TextEditingController timeStart = TextEditingController();
  TextEditingController timeEnd = TextEditingController();
  TextEditingController project = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController desc = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  UserData userData = UserData();
  bool _loadingPath = false;
  bool up = false;
  bool sendDataApi = false;
  String _udid = 'Unknown';
  var dokumen = '';
  bool uploadEdit = false;
  bool edit = false;
  String? _fileName;
  List<PlatformFile>? _paths;
  // final File fileForFirebase = File(_path.path);
  String? _directoryPath;
  var selected = 'Reguler';
  late int idEdit;
  File? file;
  int intJoinStart = 0;
  String? nameFile;
  String paths = '';
  String dokumenEdit = '';
  var projectId = '';
  var taskId = '';
  var selectedTask = 'My Task';
  String? _extension;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeStart = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? _setDate;
  Dio dio = Dio();
  String formattedDate = DateFormat('d MMMM yyyy').format(DateTime.now());
  String dateInput = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchProject(username: '${userData.getUsername7()}');
    fetchTask(username: '${userData.getUsername7()}');
    fetchEdit(user_create: '${userData.getUsername7()}');
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  //---------------------------------------------------POP UP----------------------------------------------------------
  popup() {
    AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 170,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        child: Center(
          child: Text(
            'SUCCESS',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  popupFormat() {
    AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 170,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        child: Center(
          child: Text(
            'Format Harus .jpg/.jpeg/.png/.docx/.xlsx/.pdf',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  popupEdit() {
    AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 600,
        width: 2000,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 224),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 17, 17),
                      minRadius: 45,
                      child: Icon(
                        Icons.task,
                        size: 50,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Task',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        color: Colors.black,
                        height: 1,
                      )
                    ],
                  )
                ],
              ),
              height: 120,
              width: 2000,
            ),
            Container(
              margin: EdgeInsets.only(),
              // color: Colors.amber,
              height: 450,
              child: ListView(
                children: MyactivityEditModel.myactivityedit.map((e) {
                  deskripsi() {
                    final text = '${e.myactivity_desc}';
                    print(text.length);
                    if (text.length >= 20) {
                      return '${text.characters.take(20)}....';
                    } else {
                      return text;
                    }
                  }

                  task() {
                    var taskDesc = '';
                    MyactivityModelTask.myactivitytask.forEach((element) {
                      if (e.task_id == element.task_id) {
                        taskDesc = '${element.task_desc}';
                      }
                    });
                    print(taskDesc);
                    return taskDesc;
                  }

                  taskIdd() {
                    var taskDescId = '';
                    MyactivityModelTask.myactivitytask.forEach((element) {
                      if (e.task_id == element.task_id) {
                        taskDescId = '${element.task_id}';
                      }
                    });
                    print(taskDescId);
                    return taskDescId;
                  }

                  project() {
                    var projectDesc = '';
                    MyactivityModel.myactivitymodel.forEach((element) {
                      if (e.projek_id == element.project_id) {
                        projectDesc = '${element.project_desc}';
                      }
                    });
                    print(projectDesc);
                    return projectDesc;
                  }

                  projectIdd() {
                    var projectDescId = '';
                    MyactivityModel.myactivitymodel.forEach((element) {
                      if (e.projek_id == element.project_id) {
                        projectDescId = '${element.project_id}';
                      }
                    });
                    print(projectDescId);
                    return projectDescId;
                  }

                  return ListTile(
                    onTap: () async {
                      setState(() {
                        sendDataApi = false;
                        print('sendDataApi :${sendDataApi}');
                        edit = true;
                        print(task());
                        print(project());
                        timeStart..text = '${e.time_start}';
                        timeEnd..text = '${e.time_end}';
                        selected = '${project()}';
                        projectId = '${projectIdd()}';
                        selectedTask = '${task()}';
                        taskId = '${taskIdd()}';
                        desc..text = '${e.myactivity_desc}';
                        uploadEdit = true;
                        _directoryPath = null;
                        dokumen = '${e.dokumen}';
                        dokumenEdit = '${e.dokumen != null ? e.dokumen : ''}';
                        // file = File('${e.dokumen}');

                        idEdit = e.myactivity_id;
                        print('sendDataApi :${sendDataApi}');
                        print('paths : ${_paths}');
                        print('up : ${dokumen}');
                        print('edit : ${edit}');
                        print('selected : ${selected}');
                        print('selectedTask : ${selectedTask}');
                        print('file : ${file}');
                        print(idEdit);
                      });
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.task_alt,
                      color: Color.fromARGB(255, 255, 17, 17),
                    ),
                    title: Text(
                      '${deskripsi()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '${e.time_start} s/d ${e.time_end}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),

      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  //------------------------------------------------------------------------------------------------------

  //---------------------------------------------API------------------------------------------------------

  fetchProject({required String username}) async {
    MyactivityModel.myactivitymodel.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/activity/list_data_projek'),
        body: {'username': '${username}'});
    var data = jsonDecode(responseku.body);
    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      final Map<String, MyactivityModel> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        MyactivityModel.myactivitymodel
            .add(MyactivityModel.fromjson(data['data'][i]));
        MyactivityModel.myactivitymodel.forEach((element) {
          MyactivityModel.addSelect.add('${element.project_desc}');
          print(MyactivityModel.addSelect);
        });
      }

      print('check length ${MyactivityModel.myactivitymodel.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  fetchTask({required String username}) async {
    MyactivityModelTask.myactivitytask.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/activity/list_data_task'),
        body: {'username': '${username}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        MyactivityModelTask.myactivitytask
            .add(MyactivityModelTask.fromjson(data['data'][i]));
        MyactivityModelTask.myactivitytask.forEach((element) {
          MyactivityModelTask.addselectTask.add('${element.task_desc}');
          print(MyactivityModelTask.addselectTask);
        });
      }
      print('check length ${MyactivityModelTask.myactivitytask.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  fetchEdit({required String user_create}) async {
    MyactivityEditModel.myactivityedit.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/activity/clock_daily_activity'),
        body: {'user_create': '${user_create}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      final Map<String, MyactivityEditModel> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        MyactivityEditModel.myactivityedit
            .add(MyactivityEditModel.fromjson(data['data'][i]));
      }
      MyactivityEditModel.myactivityedit.forEach((element) {
        profileMap[element.myactivity_desc] = element;
        MyactivityEditModel.myactivityedit = profileMap.values.toList();
        print(MyactivityEditModel.myactivityedit);
      });
      print('check length ${MyactivityEditModel.myactivityedit.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  //----------------------------------------------------------------------------------------------------------------

  getDataApi() {
    MyactivityEditModel.myactivityedit.forEach((element) {});
  }

  Future<void> requestPermission() async {
    final permission = Permission.storage;
    print('permission');
    await notifPermission.NotificationPermissions.requestNotificationPermissions;
    await notifPermission.NotificationPermissions.getNotificationPermissionStatus();
    await Permission.manageExternalStorage.request();

    final result = await permission.request();

    if(result == PermissionStatus.denied){
     final requestStorageAgain= await Permission.storage.request();
log("result permission $requestStorageAgain");
     if(requestStorageAgain == PermissionStatus.denied){
      throw Exception("Permission Storage is need");
     }
    }
    if (Platform.isIOS) {
      bool storage = await Permission.storage.status.isGranted;
      if (storage) {
        // Awesome
      } else {
        // Crap
      }
    } else {
      bool storage = true;
      bool videos = true;
      bool photos = true;

      // Only check for storage < Android 13
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        print('diatas 33');
        print(Permission.photos.status);
        videos = await Permission.videos.status.isGranted;
        photos = await Permission.photos.status.isGranted;
      } else {
        storage = await Permission.storage.status.isGranted;
      }

      if (storage && videos && photos) {
        // Awesome
      } else {
        // Crap
      }
    }
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      uploadEdit = false;

      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: _multiPick,
        allowedExtensions:['jpg', 'jpeg', 'png','xlsx', 'pdf'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths?.first.extension);

      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  Widget build(BuildContext context) {
    List<String> resultProject =
        LinkedHashSet<String>.from(MyactivityModel.addSelect).toList();
    List<String> result =
        LinkedHashSet<String>.from(MyactivityModelTask.addselectTask).toList();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DefaultBottomBarController(child: Ramayana()),
                  ),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: Text('My Activity',
              style: TextStyle(fontSize: 23), textAlign: TextAlign.center),
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 5,
          toolbarHeight: 90,
        ),
        body: Stack(children: [
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              // height: 450,
              // width: 300,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(
                              Icons.date_range_rounded,
                              size: 33,
                              color: Color.fromARGB(255, 255, 17, 17),
                            ),
                            //  labelText: 'Date',
                            hintText: '${formattedDate}',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.black)),
                        style: TextStyle(fontSize: 18),
                        // enabled: false,
                        keyboardType: TextInputType.text,
                        readOnly: true,

                        onSaved: (String? val) {
                          _setDate = val;
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: Color.fromARGB(255, 255, 17, 17),
                            size: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 350,
                            child: DropdownButton<String>(
                                    value: selected,
                                    hint: Text('${selected}',
                                    style: TextStyle(
                                      color: Colors.black,

                                      fontSize: 17, fontWeight: FontWeight.w500
                                    ),
                                    ),
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                         selected = value!;
                                      });

                                    },
                                    items: resultProject.map((e) => DropdownMenuItem(
                                      onTap: () {
                                        MyactivityModel.myactivitymodel.forEach((element) {

                                          if(e == element.project_desc) {
                                            setState(() {

                                              projectId = '${element.project_id}';
                                              selected = projectId;

                                            });
                                          }
                                        });
                                      },
                                      value: e,
                                      child:
                                     Text('${e}'),
                                      )
                                      ).toList(),

                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.task,
                            color: Color.fromARGB(255, 255, 17, 17),
                            size: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            // margin: EdgeInsets.only(right: 30),
                            width: 350,
                            child: DropdownButton<String>(

                                    value: selectedTask,
                                    hint: Text('${selectedTask}',
                                    style: TextStyle(
                                      color: Colors.black,

                                      fontSize: 17, fontWeight: FontWeight.w500
                                    ),
                                    ),
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                          selectedTask = value!;
                                      });

                                    },
                                    items: result.map((e) => DropdownMenuItem(
                                       onTap: () {
                                        MyactivityModelTask.myactivitytask.forEach((element) {

                                            if(e == element.task_desc) {
                                            setState(() {

                                              taskId = '${element.task_id}';
                                              selectedTask = taskId;
                                            });
                                          }

                                        });
                                      },
                                      value: e,
                                      child:
                                     Text('${e}'),
                                      )
                                      ).toList(),

                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              child: TextFormField(
                                  validator: RequiredValidator(
                                      errorText: ' Please Enter'),
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock_clock,
                                        size: 30,
                                        color: Color.fromARGB(255, 255, 17, 17),
                                      ),
                                      //  labelText: 'Date',
                                      hintText: '${formattedTime}',
                                      hintStyle: TextStyle(fontSize: 18)),
                                  style: TextStyle(fontSize: 18),
                                  // enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: timeStart,
                                  onTap: () async {
                                    TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.grey,
                                              splashColor: Colors.white,
                                              textTheme: TextTheme(
                                                subtitle1: TextStyle(
                                                    color: Colors.black),
                                                button: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              accentColor: Colors.black,
                                              colorScheme: ColorScheme.light(
                                                  primary: Color.fromARGB(
                                                      255, 255, 17, 17),
                                                  primaryVariant: Colors.white,
                                                  secondaryVariant:
                                                      Colors.black,
                                                  onSecondary: Colors.black,
                                                  onPrimary: Colors.white,
                                                  surface: Colors.white,
                                                  onSurface: Colors.black,
                                                  secondary: Colors.white),
                                              dialogBackgroundColor:
                                                  Colors.white,
                                            ),
                                            child: child ?? Text(""),
                                          );
                                        },
                                        initialTime: selectedTimeStart
                                        //   .replacing(
                                        //       hour: selectedTimeStart.hourOfPeriod),
                                        );
                                    if (picked != null)
                                      setState(() {
                                        selectedTimeStart = picked;
                                        var hourStart = selectedTimeStart.hour
                                            .toString()
                                            .padLeft(2, '0');
                                        var minuteStart = selectedTimeStart
                                            .minute
                                            .toString()
                                            .padLeft(2, '0');
                                        var join = hourStart + minuteStart;
                                        intJoinStart = int.parse(join);
                                        print(join);
                                        print(intJoinStart);

                                        timeStart.text = DateFormat(
                                                '${selectedTimeStart.hour.toString().padLeft(2, '0')}:${selectedTimeStart.minute.toString().padLeft(2, '0')}'
                                                // 'HH:mm:ss'
                                                )
                                            .format(
                                                // dt
                                                DateTime(selectedTimeStart.hour,
                                                    selectedTimeStart.minute))
                                            .toString();
                                        print(timeStart.text);
                                      });
                                  }),
                            ),
                            Text(
                              'to',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              width: 170,
                              child: TextFormField(
                                  validator: RequiredValidator(
                                      errorText: ' Please Enter'),
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock_clock,
                                        color: Color.fromARGB(255, 255, 17, 17),
                                        size: 30,
                                      ),
                                      //  labelText: 'Date',
                                      hintText: '${formattedTime}',
                                      hintStyle: TextStyle(fontSize: 18)),
                                  style: TextStyle(fontSize: 18),
                                  // enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: timeEnd,
                                  onTap: () async {
                                    sendDataApi = false;
                                    final TimeOfDay? picked =
                                        await showTimePicker(
                                            context: context,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data: ThemeData(
                                                  primarySwatch: Colors.grey,
                                                  splashColor: Colors.white,
                                                  textTheme: TextTheme(
                                                    subtitle1: TextStyle(
                                                        color: Colors.black),
                                                    button: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  accentColor: Colors.black,
                                                  colorScheme:
                                                      ColorScheme.light(
                                                          primary:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  17,
                                                                  17),
                                                          primaryVariant:
                                                              Colors.white,
                                                          secondaryVariant:
                                                              Colors.black,
                                                          onSecondary:
                                                              Colors.black,
                                                          onPrimary:
                                                              Colors.white,
                                                          surface: Colors.white,
                                                          onSurface:
                                                              Colors.black,
                                                          secondary:
                                                              Colors.white),
                                                  dialogBackgroundColor:
                                                      Colors.white,
                                                ),
                                                child: child ?? Text(""),
                                              );
                                            },
                                            initialTime: selectedTime);

                                    if (picked != null)
                                      setState(() {
                                        selectedTime = picked;
                                        var hour = selectedTime.hour
                                            .toString()
                                            .padLeft(2, '0');
                                        var minute = selectedTime.minute
                                            .toString()
                                            .padLeft(2, '0');
                                        var join = hour + minute;
                                        int intJoin = int.parse(join);
                                        print(join);
                                        print(intJoin);

                                        print(selectedTime);
                                        intJoinStart >= intJoin
                                            ? timeEnd.text = timeStart.text
                                            : timeEnd.text = DateFormat(
                                                    '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}')
                                                .format(DateTime(picked.hour,
                                                    picked.minute));
                                        print(timeEnd.text);
                                      });
                                  }),
                            ),
                          ],
                        ),
                      ]),

                  SizedBox(
                    height: 20,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: ' Please Enter'),
                        controller: desc,
                        maxLines: 7,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Deskripsi',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 17, 17)),
                          prefixIcon: Icon(
                            Icons.chrome_reader_mode,
                            color: Color.fromARGB(255, 255, 17, 17),
                            size: 30,
                          ),
                          // fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ],
                  ),

                  // -------------------------------------------UPLOAD DOKUMEN ----------------------------------------------
                  SizedBox(height: 20),

                  Builder(
                      builder: (BuildContext context) => uploadEdit
                          ? ListTile(
                              title: Text(dokumen),
                            )
                          : _loadingPath
                              ? SpinKitWave(
                                  color: Color.fromARGB(255, 255, 17, 17),
                                  size: 30.0,
                                  duration: Duration(seconds: 10),
                                )
                              : _directoryPath != null
                                  ? ListTile(
                                      title: const Text('Directory path'),
                                      subtitle: Text(_directoryPath!),
                                    )
                                  : _paths != null
                                      ? Container(
                                          // padding: const EdgeInsets.only(bottom: 30),
                                          height: 80,
                                          child: Scrollbar(
                                              child: ListView.separated(
                                            itemCount: _paths != null &&
                                                    _paths!.isNotEmpty
                                                ? _paths!.length
                                                : 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final bool isMultiPath =
                                                  _paths != null &&
                                                      _paths!.isNotEmpty;
                                              nameFile = (isMultiPath
                                                  ? _paths!
                                                      .map((e) => e.name)
                                                      .toList()[index]
                                                  : _fileName ?? '...');
                                              paths = _paths!
                                                  .map((e) => e.path)
                                                  .toList()[index]
                                                  .toString();

                                              file = File(paths);
                                              print(file);

                                              return ListTile(
                                                title: Text(
                                                  nameFile!,
                                                ),
                                                subtitle: Text(paths),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                          )),
                                        )
                                      : const SizedBox()),

                  Container(
                    margin: EdgeInsets.only(right: 220),
                    child: MaterialButton(
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color.fromARGB(255, 219, 215, 215),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_copy),
                          Text(
                            'Upload Document',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      onPressed: () {
                        // requestPermission(); //dikomennnnn
                        print('dateinput : ${dateInput}');
                        _openFileExplorer();
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minWidth: 100,
                          height: 50,
                          color: Color.fromARGB(255, 255, 17, 17),
                          onPressed: () async {
                            
                            _loadingPath = false;
                            print(edit);
                            popupEdit();
                            setState(() {
                              fetchEdit(
                                  user_create: '${userData.getUsername7()}');
                            });
                            ;
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minWidth: 100,
                          height: 50,
                          color: Color.fromARGB(255, 255, 17, 17),
                          onPressed: () async {
                            
                            print(edit);
                            if (_formKey.currentState!.validate()) {
                              
                              MyActivity apiMyactivity = MyActivity();

                              print('edit : ${edit}');
                              print('loading : ${up}');
                              //1x save
                              if(sendDataApi == false) {
                                sendDataApi = true;
                                
                              if (edit == true) {
                                if (_paths != null) {
                                  var formData = FormData.fromMap({
                                    'user_create': '${userData.getUsername7()}',
                                    'time_start': timeStart.text,
                                    'time_end': timeEnd.text,
                                    'task_id': taskId == ''
                                        ? 'P202300001-001'
                                        : taskId,
                                    'projek_id': projectId == ''
                                        ? 'P202300001'
                                        : projectId,
                                    'myactivity_id': idEdit,
                                    'myactivity_desc': desc.text,
                                    'date_create': dateInput,
                                    'dokumen':   await MultipartFile.fromFile(
                                      file!.path,
                                      filename: '${nameFile}'
                                    ) ,
                                    'beforedokumen': '${dokumen}'
                                  });

                                  var response = await dio.post(
                                      '${tipeurl}v1/activity/updateDailyActivity',
                                      data: formData);

                                      AndroidDeviceInfo info =
                                  await deviceInfo.androidInfo;
                              var formDataLog = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'My Activity - Edit My Activity',
                                ' info2': '${_udid} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              print('berhasil $_udid');
                               var responseLog =
                                await dio.post('${tipeurl}v1/activity/createmylog', data: formDataLog);
                            print('berhasil $_udid');
                                } else {
                                  var formData = FormData.fromMap({
                                    'user_create': '${userData.getUsername7()}',
                                    'time_start': timeStart.text,
                                    'time_end': timeEnd.text,
                                    'task_id': taskId == ''
                                        ? 'P202300001-001'
                                        : taskId,
                                    'projek_id': projectId == ''
                                        ? 'P202300001'
                                        : projectId,
                                    'myactivity_id': idEdit,
                                    'myactivity_desc': desc.text,
                                    'date_create': dateInput,
                                    'dokumen': '${dokumenEdit}',
                                    'beforedokumen': '${dokumen}'
                                  });

                                  var response = await dio.post(
                                      '${tipeurl}v1/activity/updateDailyActivity',
                                      data: formData);

                                       AndroidDeviceInfo info =
                                  await deviceInfo.androidInfo;
                              var formDataLog = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'My Activity - Edit My Activity',
                                ' info2': '${_udid} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              print('berhasil $_udid');
                              var responseLog =
                                await dio.post('${tipeurl}v1/activity/createmylog', data: formDataLog);
                            print('berhasil $_udid');
                                }

                                print('file : ${file}');
                                print('DATA EDIT');

                                print('DATA Input');
                              } else {
                                if (_paths != null) {
                                  var formData = FormData.fromMap({
                                    'user_create': '${userData.getUsername7()}',
                                    'time_start': timeStart.text,
                                    'time_end': timeEnd.text,
                                    'task_id': taskId == ''
                                        ? 'P202300001-001'
                                        : taskId,
                                    'projek_id': projectId == ''
                                        ? 'P202300001'
                                        : projectId,
                                    'myactivity_status': null,
                                    'myactivity_desc': desc.text,
                                    'date_create': dateInput,
                                    'dokumen':   await MultipartFile.fromFile(
                                      file!.path,
                                      filename: '${nameFile}'
                                    )
                                  });

                                  var response = await dio.post(
                                      '${tipeurl}v1/activity/create_daily_activity',
                                      data: formData);

                                       AndroidDeviceInfo info =
                                  await deviceInfo.androidInfo;
                              var formDataLog = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'My Activity - Input My Activity',
                                ' info2': '${_udid} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              print('berhasil $_udid');
                              var responseLog =
                                await dio.post('${tipeurl}v1/activity/createmylog', data: formDataLog);
                            print('berhasil $_udid');
                                } else {
                                  var formData = FormData.fromMap({
                                    'user_create': '${userData.getUsername7()}',
                                    'time_start': timeStart.text,
                                    'time_end': timeEnd.text,
                                    'task_id': taskId == ''
                                        ? 'P202300001-001'
                                        : taskId,
                                    'projek_id': projectId == ''
                                        ? 'P202300001'
                                        : projectId,
                                    'myactivity_status': null,
                                    'myactivity_desc': desc.text,
                                    'date_create': dateInput,
                                  });

                                  var response = await dio.post(
                                      '${tipeurl}v1/activity/create_daily_activity',
                                      data: formData);

                                      AndroidDeviceInfo info =
                                  await deviceInfo.androidInfo;
                              var formDataLog = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'My Activity - Input My Activity',
                                ' info2': '${_udid} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              print('berhasil $_udid');
                              var responseLog =
                                await dio.post('${tipeurl}v1/activity/createmylog', data: formDataLog);
                            print('berhasil $_udid');
                                }
                              }

                              
                              print(
                                  'Berhasil ${dokumen} ${dokumenEdit}, ${selectedTask}, ${timeStart.text}, ${timeStart.text}, ${timeStart.text},');
                              popup();
                              uploadEdit = false;
                              timeStart.clear();
                              timeEnd.clear();
                              desc.clear();
                              selected = 'Reguler';
                              selectedTask = 'My Task';
                              _paths = null;
                              up = false;
                              setState(() {
                                fetchEdit(
                                    user_create: '${userData.getUsername7()}');
                                edit = false;
                              });
                            }
                            }
                            else {
                              print('sudah input/edit');
                            }
                            //save data 1x
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          )
        ]));
  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
  DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color.fromARGB(255, 255, 17, 17)),
    ),
  );
}
