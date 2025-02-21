import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../home_screen/comfy_user_information_function/project_information.dart';

class comfy_toggle_button extends StatefulWidget {
  const comfy_toggle_button({super.key, required this.button, required this.hostname, required this.staticIP, required this.port, required this.username, required this.password});
  final comfy_button button;
  final String hostname; final String username; final String password; final String staticIP;
  final int port;

  @override
  State<comfy_toggle_button> createState() => _comfy_toggle_buttonState();
}

class _comfy_toggle_buttonState extends State<comfy_toggle_button> {
  bool _status = false;
  late SSHClient sshClient;

  @override
  void initState(){
    initClient();
    super.initState();
  }

  @override
  void dispose(){
    try{
      sshClient.close();
    } catch (e){

    }

    super.dispose();
  }

  @override
  void deactivate(){
    try{
      sshClient.close();
    } catch (e){

    }
    super.deactivate();
  }
  Future<void> initClient() async{
    for(String potentialHostName in [widget.staticIP.trim(), widget.hostname]){
      try{
        sshClient = SSHClient(
          await SSHSocket.connect(potentialHostName, widget.port),
          username: widget.username,
          onPasswordRequest: () => widget.password,
        );
        //attempt a connection
        await sshClient.execute('echo hi');
        print('button ssh connection successfully created with hostname $potentialHostName');
        break;
      }
      catch (e){
        //if all hostname tested and not working, report!
        if(potentialHostName == widget.hostname){
          //report SSH not working
          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error connecting to $potentialHostName: $e}')));
        }
      }
    }
  }

  Future<void> onClick() async {
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.click);
    if(_status == true){
      await sshClient.run(widget.button.function!['off']!);
    }
    else{
      await sshClient.run(widget.button.function!['on']!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async{
          setState((){_status = !_status;});
          await onClick();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFDAEED7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.button.color!, width: 2)
                  ),

                ),
              ),
              Container(
                child: Builder(
                  builder: (context){
                    if(_status==true) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 45),
                        child: Image.asset('assets/froggie/toggle-on.png',),
                      );
                    }
                    else{
                      return Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 45, top: 20),
                        child: Image.asset('assets/froggie/toggle-off.png', fit: BoxFit.fill,),
                      );
                    }}
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.button.name!,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          )
        )
    );

  }
}