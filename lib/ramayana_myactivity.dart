import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
// import 'package:text_area/text_area.dart';

class RamayanaMyActivity extends StatefulWidget {
  const RamayanaMyActivity({super.key});

  @override
  State<RamayanaMyActivity> createState() => _RamayanaMyActivityState();
}

class _RamayanaMyActivityState extends State<RamayanaMyActivity> {
  @override
  TextEditingController  date = TextEditingController();
  TextEditingController  timeStart = TextEditingController();
  TextEditingController  timeEnd = TextEditingController();
  TextEditingController  project = TextEditingController();
  TextEditingController  task = TextEditingController();
  TextEditingController  desc = TextEditingController();
  UserData userData = UserData();
  bool _loadingPath = false;
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? _setDate;
  Dio dio = Dio();
  DateTime  currentTime = DateTime.now();
  String formattedDate =  DateFormat('d MMMM yyyy').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());

   _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 17, 17),
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    },
      
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
      
  if (picked != null)
    setState(() {
      
      selectedDate = picked;
      date.text = DateFormat('yyyy-MM-dd').format(selectedDate);
     
    });
}

    void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
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
      // print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
    }

  Widget build(BuildContext context) {
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
          elevation:5,
          toolbarHeight: 90,
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
            // height: 450,
            // width: 300,
            child: ListView(
              children: [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text('Date', style: TextStyle(fontSize: 17, color: Colors.black),),
                        SizedBox(height: 10,),
                         TextFormField(
                                          decoration: InputDecoration(
                                             prefixIcon: Icon(Icons.date_range_rounded, size: 30,),
                                            //  labelText: 'Date',
                                            hintText: '${formattedDate}',
                                            hintStyle: TextStyle(fontSize: 18)
                                          ),
                                          style: TextStyle(fontSize: 18),
                                          // enabled: false,
                                          keyboardType: TextInputType.text,
                                          controller: date,
                                          onTap: () async{
                                            final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 17, 17),
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    },
      
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
      
  if (picked != null)
    setState(() {
      
      selectedDate = picked;
      date.text = DateFormat('yyyy-MM-dd').format(selectedDate);
     
    });
                                          },
                                          onSaved: (String? val) {
                                            _setDate = val;
                                          },
                                          
                                        ),
                       ],
                     ),
                                  
                                
                SizedBox(height: 20,),

                Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text('Time', style: TextStyle(fontSize: 17, color: Colors.black),),
                        SizedBox(height: 10,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                              width: 170,
                               child: TextFormField(
                                                decoration: InputDecoration(
                                                   prefixIcon: Icon(Icons.lock_clock, size: 30,),
                                                  //  labelText: 'Date',
                                                  hintText: '${formattedTime}',
                                                  hintStyle: TextStyle(fontSize: 18)
                                                ),
                                                style: TextStyle(fontSize: 18),
                                                // enabled: false,
                                                keyboardType: TextInputType.text,
                                                controller: timeStart,
                                                onTap: () async{
                                                   
                                                  final TimeOfDay? picked = await showTimePicker(
                                   context: context,
                                   builder: (BuildContext context, Widget ?child) {
                                   return Theme(
                                     data: ThemeData(
                                       primarySwatch: Colors.grey,
                                       splashColor: Colors.white,
                                       textTheme: TextTheme(
                                         subtitle1: TextStyle(color: Colors.black),
                                         button: TextStyle(color: Colors.black),
                                       ),
                                       accentColor: Colors.black,
                                       colorScheme: ColorScheme.light(
                                           primary: Color.fromARGB(255, 255, 17, 17),
                                           primaryVariant: Colors.white,
                                           secondaryVariant: Colors.black,
                                           onSecondary: Colors.black,
                                           onPrimary: Colors.white,
                                           surface: Colors.white,
                                           onSurface: Colors.black,
                                           secondary: Colors.white),
                                           dialogBackgroundColor: Colors.white,
                                     ),
                                     child: child ??Text(""),
                                   );
                                 },
                                   
                                   initialTime: selectedTime );
                                 
                                                }
                               ),
                             ),
                             Text('to', style: TextStyle(fontSize: 16,),),
                             Container(
                              width: 170,
                               child: TextFormField(
                                                decoration: InputDecoration(
                                                   prefixIcon: Icon(Icons.lock_clock, size: 30,),
                                                  //  labelText: 'Date',
                                                  hintText: '${formattedTime}',
                                                  hintStyle: TextStyle(fontSize: 18)
                                                ),
                                                style: TextStyle(fontSize: 18),
                                                // enabled: false,
                                                keyboardType: TextInputType.text,
                                                controller: timeEnd,
                                                onTap: () async{
                                                   
                                                  final TimeOfDay? picked = await showTimePicker(
                                   context: context,
                                   builder: (BuildContext context, Widget ?child) {
                                   return Theme(
                                     data: ThemeData(
                                       primarySwatch: Colors.grey,
                                       splashColor: Colors.white,
                                       textTheme: TextTheme(
                                         subtitle1: TextStyle(color: Colors.black),
                                         button: TextStyle(color: Colors.black),
                                       ),
                                       accentColor: Colors.black,
                                       colorScheme: ColorScheme.light(
                                           primary: Color.fromARGB(255, 255, 17, 17),
                                           primaryVariant: Colors.white,
                                           secondaryVariant: Colors.black,
                                           onSecondary: Colors.black,
                                           onPrimary: Colors.white,
                                           surface: Colors.white,
                                           onSurface: Colors.black,
                                           secondary: Colors.white),
                                           dialogBackgroundColor: Colors.white,
                                     ),
                                     child: child ??Text(""),
                                   );
                                 },
                                   
                                   initialTime: selectedTime );
                                 
                                                }
                               ),
                             ),
                           ],
                         ),      ]),           
                                          
                                        
                     

                
                  
                   SizedBox(height: 20,),

                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Project', style: TextStyle(fontSize: 17, color: Colors.black),),
                    TextFormField(
                      controller: project,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.file_copy_outlined),
                        hintText: 'Project',
                        // labelText: 'Project',
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: 20,),

                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task', style: TextStyle(fontSize: 17, color: Colors.black),),
                    TextFormField(
                      controller: task,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.task),
                        hintText: 'Write a Task',
                        // labelText: 'Project',
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 20,),
               
                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text('Description', style: TextStyle(fontSize: 17, color: Colors.black),),
                     SizedBox(height: 20,),
                    TextFormField(
                      controller: desc,
                      maxLines: 7,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        prefixIcon: Icon(Icons.chrome_reader_mode),
                        // fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Builder(
                  builder: (BuildContext context) => _loadingPath
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
                                  height:
                                     80,
                                  child: Scrollbar(
                                      child: ListView.separated(
                                    itemCount:
                                        _paths != null && _paths!.isNotEmpty
                                            ? _paths!.length
                                            : 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final bool isMultiPath =
                                          _paths != null && _paths!.isNotEmpty;
                                      final String name = 'File $index: ' +
                                          (isMultiPath
                                              ? _paths!
                                                  .map((e) => e.name)
                                                  .toList()[index]
                                              : _fileName ?? '...');
                                      final path = _paths!
                                          .map((e) => e.path)
                                          .toList()[index]
                                          .toString();
                                      return ListTile(
                                        title: Text(
                                          name,
                                        ),
                                        subtitle: Text(path),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                  )),
                                )
                              : const SizedBox(),
                ),
                
                Container(
                  margin: EdgeInsets.only(right: 250),
                
                  child: MaterialButton(
                    height: 45,
                   shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                    color: Color.fromARGB(255, 219, 215, 215),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.file_copy),
                                Text('Upload Document')
                              ],
                            ),
                          
                    onPressed: () {
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
                        color: Colors.red,
                        onPressed: () async {
                           var formData = FormData.fromMap({
                      'user_create': '${userData.getUsername7()}',
                      'myactivity_desc': desc.text,
                      'time_start': '15:30',
                      'time_end ': '17:00',
                      'task_id': project.text,
                      'myactivity_status': '1',
                      'date_create' : date.text
                     
                      // 'data_gambar': await MultipartFile.fromFile(
                      //   _image?.path,
                      //   filename: 'data_gambar${now.toString()}.png'
                      // ),
                    });
                    var response = await dio.post('https://dev-android-api.ramayana.co.id:8305/v1/activity/create_daily_activity',
                      data: formData
                    );
                    print('Berhasil, ${desc.text}, ${date.text}, ${timeStart.text}, ${timeEnd.text}, ${project.text}');
                  
                        },
                        child: Text(
                          "Save",
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
                        color: Colors.red,
                        onPressed: () {
                        
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ]),
              ],
            ),
          )
        ]));
  }
}