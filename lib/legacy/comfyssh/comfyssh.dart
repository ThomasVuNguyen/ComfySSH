import 'dart:async';
import 'dart:convert';
import 'package:comfyssh_flutter/components/virtual_keyboard.dart';
import 'package:comfyssh_flutter/function.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xterm/xterm.dart';
import 'dart:io' show Platform;

import '../../main.dart';
String nickname = "nickname";String hostname = "hostname";int port = 22;String username = "username";String password = "password";String color = "color";int _selectedIndex = 0; String distro = "distro";
/* Legacy comfySSH
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<Welcome>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: accentcolor,
          onPressed: () {showDialog(context: context, builder:(BuildContext context){
            return AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              contentPadding: const EdgeInsets.all(20.0),
              title: const Center(child: Text("New Host")),
              titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 24.0, color: textcolor),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField( //add nickname
                      onChanged: (name1){
                        nickname = name1.replaceFirst(name1[0], name1[0].toUpperCase());
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                          hintText: "nickname", hintStyle: GoogleFonts.poppins(fontSize: 18.0),
                          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: textcolor, width: 2.0))
                      ),textInputAction: TextInputAction.next,
                    ), const SizedBox(height: 32, width: double.infinity,),
                    TextField( //add hostname
                      onChanged: (host1){hostname = host1;},
                      decoration: InputDecoration(
                          hintText: "hostname / IP", hintStyle: GoogleFonts.poppins(fontSize: 18.0),
                          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: textcolor, width: 2.0))
                      ),textInputAction: TextInputAction.next,
                    ), const SizedBox(height: 32, width: double.infinity,),
                    TextField( //add username
                      onChanged: (user1){
                        username = user1;
                      },
                      decoration: InputDecoration(
                          hintText: "username", hintStyle: GoogleFonts.poppins(fontSize: 18.0),
                          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: textcolor, width: 2.0))
                      ),textInputAction: TextInputAction.next,
                    ), const SizedBox(height: 32, width: double.infinity,),
                    TextField( //add password
                      onChanged: (pass1){
                        password = pass1;
                      },
                      decoration: InputDecoration(
                          hintText: "password", hintStyle: GoogleFonts.poppins(fontSize: 18.0),
                          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: textcolor, width: 2.0))
                      ),textInputAction: TextInputAction.next,
                    ), const SizedBox(height: 32, width: double.infinity,),
                    DropdownButtonFormField<String> (
                      decoration: const InputDecoration(
                          border:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), borderSide: BorderSide(color: Colors.blue, width: 2.0))
                      ),
                      iconSize: 30.0, iconDisabledColor: textcolor, iconEnabledColor: Colors.blue,
                      value: colorMap.keys.toList()[0],
                      items: colorMap.keys.toList().map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.poppins(fontSize: 18.0),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value){
                        currentDistro = value!;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                    color: accentcolor,
                    textColor: Colors.white,
                    child: Text("Done", style: GoogleFonts.poppins(fontSize: 18),),
                    onPressed: (){
                      newName(nickname);
                      newHost(hostname);
                      newUser(username);
                      newPass(password);
                      newDistro(currentDistro);
                      print("done");
                      setState(() {
                      });
                      Navigator.pop(context);
                      currentDistro=colorMap.keys.first;
                    })],);});
          },
          child: const Icon(Icons.add, size: 28,),
        ),
        appBar: AppBar(
            shape: const Border(bottom: BorderSide(color: textcolor, width: 2)),
            toolbarHeight: 64,
            title: Row(
              children: <Widget>[
                const SizedBox(width: 0, height: 20, child: DecoratedBox(decoration: BoxDecoration(color: bgcolor, ),),), Text('HOSTS', style: GoogleFonts.poppins(color: textcolor, fontWeight: FontWeight.bold, fontSize: 24),),
              ],
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: bgcolor,
            ),
            elevation: 0,
            backgroundColor: bgcolor,
            actionsIconTheme: const IconThemeData(
                size: 30.0,
                color: Colors.white,
                opacity: 10.0
            ),
            actions: <Widget>[
              Padding(padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap:(){
                      showDialog(context: context, builder:(BuildContext context){
                        return AlertDialog(
                          title: Text("Add a new host",  style: GoogleFonts.poppins(fontSize: 18, color: textcolor),),
                          content: Column(mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField( //add nickname
                                onChanged: (name1){
                                  nickname = name1;},
                                decoration: const InputDecoration(
                                  hintText: "nickname",
                                ),textInputAction: TextInputAction.next,
                              ),
                              TextField( //add hostname
                                onChanged: (host1){
                                  hostname = host1;},
                                decoration: const InputDecoration(
                                  hintText: "hostname",
                                ),textInputAction: TextInputAction.next,
                              ),
                              TextField( //add username
                                onChanged: (user1){
                                  username = user1;
                                },
                                decoration: const InputDecoration(
                                  hintText: "username",
                                ),textInputAction: TextInputAction.next,
                              ),
                              TextField( //add password
                                onChanged: (pass1){
                                  password = pass1;
                                },
                                decoration: const InputDecoration(
                                  hintText: "password",
                                ),textInputAction: TextInputAction.next,
                              ),
                              DropdownButtonFormField<String> (
                                value: colorMap.keys.toList()[0],
                                items: colorMap.keys.toList().map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value){
                                  currentDistro = value!;
                                },
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            MaterialButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: const Text("Save"),
                                onPressed: (){
                                  newName(nickname);
                                  newHost(hostname);
                                  newUser(username);
                                  newPass(password);
                                  newDistro(currentDistro);
                                  setState(() {
                                  });
                                  Navigator.pop(context);
                                  currentDistro=colorMap.keys.first;
                                })],);});},
                    child: const Icon(
                      Icons.add,
                      size: 0,
                    )
                ),
              ),
              Padding(padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    child: const Icon(Icons.menu, color: textcolor,),
                    /*onTap: (){
                  showDialog<String>(
                      context: context, builder: (BuildContext context) =>
                      AlertDialog(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset("assets/comfy-cat.png", width: 40.0,),
                                const SizedBox(width: 10.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("comfyStudio team",style: GoogleFonts.poppins(fontSize: 21.0,fontWeight: FontWeight.bold )),
                                    Text("Hey there!",style: GoogleFonts.poppins(fontSize: 12.0, color: const Color(0xff656366))),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Text("Thank you for using comfySSH!",style: GoogleFonts.poppins(fontSize: 16.0, ),),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, ),),
                            Text("With comfySSH, we want to deliver to you a comfortable development experience - minimal and powerful.",style: GoogleFonts.poppins(fontSize: 16.0, )),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, )),Text("If you have any feedback or feature suggestion, you can do so at our website/email:",style: GoogleFonts.poppins(fontSize: 16.0, )),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, )), SelectableText("comfyStudio.tech",style: GoogleFonts.poppins(fontSize: 16.0, fontWeight:FontWeight.w600 )),
                            SelectableText("feedback@comfystudio.tech",style: GoogleFonts.poppins(fontSize: 12.0, fontWeight:FontWeight.w600 )),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, )),Text("You can also see how we have planned for feedback & feature request in the past at our website.",style: GoogleFonts.poppins(fontSize: 16.0, )),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, )),Text("In the mean time, look out for more updates and take care!",style: GoogleFonts.poppins(fontSize: 16.0, )),
                            Text("",style: GoogleFonts.poppins(fontSize: 16.0, ))
                          ],
                        ),
                      )
                  );
                },*/
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const comfySpace()),
                      );
                    }
                ),
              ),

            ]
        ),
        body: FutureBuilder(
          future: Future.wait([reAssignNameList(),reAssignHostList(),reAssignUserList(),reAssignPassList(),reAssignDistroList()]),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Column(
                children: <Widget>[
                  const SizedBox(height: 43),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0), //card wall padding
                      children: List.generate(snapshot.data[0].length, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0), //distance between cards
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: textcolor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),topRight: Radius.circular(0.0),bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(0.0),
                                  )
                              ),
                              height: 128, width: 106,
                              child: IconButton(
                                  onPressed: () {
                                    nickname = snapshot.data[0][index] ;hostname = snapshot.data[1][index]; username = snapshot.data[2][index]; password = snapshot.data[3][index]; distro = snapshot.data[4][index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  const Control()),
                                    );
                                  },icon: Image.asset(colorMap[distroList[index]]!, height: 50,)
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width-40-106, height: 128,
                              child: ListTile(contentPadding: const EdgeInsets.only(top:0.0, bottom: 0.0),
                                  trailing: const SizedBox( width: 40,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.arrow_forward_ios, color: textcolor,size: 25,),
                                      ],
                                    ),
                                  ),
                                  onLongPress: () => showDialog<String>(
                                    context: context, builder: (BuildContext context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)), side: BorderSide(color: warningcolor, width: 2.0)),
                                    title: Text('Delete host?', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold ),),
                                    content: Text('This will permanently remove host information.', style: GoogleFonts.poppins(fontSize: 16 )),
                                    actions: <Widget>[
                                      RawMaterialButton(onPressed: () => Navigator.pop(context, 'Cancel'),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                                        ), child: const Text('Cancel'),
                                      ),
                                      RawMaterialButton(onPressed: () {removeItem(index); Navigator.pop(context, 'Delete'); setState(() {});},
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), ),
                                        fillColor: warningcolor,
                                        textStyle: GoogleFonts.poppins(color: bgcolor, fontWeight: FontWeight.w600, fontSize: 16), child: const Text('Delete'),
                                      ),],),),
                                  onTap: (){
                                    nickname = snapshot.data[0][index];hostname = snapshot.data[1][index]; username = snapshot.data[2][index]; password = snapshot.data[3][index]; distro = snapshot.data[4][index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  const Term()),
                                    );
                                  },
                                  shape: const RoundedRectangleBorder(side: BorderSide(width: 2, color:textcolor) , borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0),topRight: Radius.circular(8.0),bottomLeft: Radius.circular(0.0),bottomRight: Radius.circular(8.0),)),
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, top: 23, bottom: 23),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data[0][index][0].toUpperCase()+snapshot.data[0][index].substring(1), style: GoogleFonts.poppins(color: textcolor, fontWeight: FontWeight.bold,  fontSize: 20)),
                                        Text("${snapshot.data[2][index]} @ ${snapshot.data[1][index]}", style: GoogleFonts.poppins(color: textcolor, fontSize: 16)),
                                      ],
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      )),
                    ),
                  ),
                ],
              );
            }
            return const Text("loading");
          },
        )
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memoryCheck();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'xterm.dart demo',
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}  //MyApp, wraps the main home page


class Term extends StatefulWidget {
  const Term({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TerminalPage createState() => _TerminalPage();

} //Term

class _TerminalPage extends State<Term> {
  late final terminal = Terminal(inputHandler: keyboard);
  final keyboard = VirtualKeyboard(defaultInputHandler);
  var title = hostname + username + password;
  int buttonState = 1;
  @override
  void initState() {
    print(hostname);
    super.initState();
    initTerminal();

  }
  Future<void> initTerminal() async {
    terminal.write('Connecting...\r\n');
    final client = SSHClient(
      await SSHSocket.connect(hostname, port),
      username: username,
      onPasswordRequest: () => password,
    );
    print(client.username);

    terminal.write('Connected\r\n');
    final session = await client.shell(
      pty: SSHPtyConfig(
        width: terminal.viewWidth,
        height: terminal.viewHeight,
      ),
    );

    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onTitleChange = (title) {
      setState(() => this.title = title);
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      session.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      session.write(utf8.encode(data));
    };

    session.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    session.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 64,
        shape: const Border(bottom: BorderSide(color: textcolor, width: 2)),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: bgcolor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //left alignment for texts
          children: [
            Text(nickname,style: GoogleFonts.poppins(color: textcolor, fontWeight: FontWeight.bold, fontSize: 21)),
            Text(distro,style: GoogleFonts.poppins(color: textcolor, fontSize: 12)),
          ],
        ),
        backgroundColor: bgcolor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back, color: textcolor,))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: TerminalView(terminal),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: VirtualKeyboardView(keyboard),
      ),
    );
  }
} //TerminalState

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  List<String> buttonList = [];
  List<String> sizeXList =[];
  List<String> sizeYList = [];
  List<String> positionList = [];
  List<String> commandList = [];
  String message = 'hi im message';
  void init(){
    //String space1 = "space1";
    //createSpace(space1, host, user, password)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.connected_tv_sharp), onPressed : () async {
        var listTotal = await renderer('space1'); buttonList = listTotal[0]; sizeXList = listTotal[1]; sizeYList = listTotal[2]; positionList = listTotal[3]; commandList = listTotal[4];
        //createSpace('space1');

        setState(() {});
      },),
      body: GridView.count(
        crossAxisCount: 4,
        children:
        List.generate(buttonList.length, (index) {
          return Center(
            child: IconButton(
              onPressed: () {

                setState(() {message = commandList[index];});},
              icon: const Icon(Icons.ac_unit_rounded),
            ),
          );
        }),
      ),
    );
  }
}
 */
