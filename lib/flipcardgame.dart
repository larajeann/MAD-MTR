import 'package:alvaro_midtermproject/homeScreen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'data.dart';
import 'dart:async';

class FlipCardGame extends StatefulWidget {
  final Level _level;  FlipCardGame(this._level);
  @override
  _FlipCardGameState createState() => _FlipCardGameState(_level);
}

class _FlipCardGameState extends State<FlipCardGame> {
  _FlipCardGameState(this._level);

  Level _level;
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;

  late bool _isFinished;
  late int _left;
  late List<String> _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  Widget getItem(int index) { // pangkuha po ito ng data/pics then displays it
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.check_circle_outline_rounded),
        title: const Text("FilipiKnows"),
        centerTitle: true,
       backgroundColor: Colors.brown[200],
      foregroundColor: Colors.white,
        actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                     Navigator.of(context).pop( CupertinoPageRoute(  builder: (_) => HomeScreen()));
                  },
                ),
              ],
      ),
      body: _isFinished
        ? Scaffold(  
            body: Center( 
              child: GestureDetector(
                onTap: () => restart(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                     Container(    
                      decoration: BoxDecoration(
                            color: Colors.brown[500], 
                            borderRadius: BorderRadius.circular(50) 
                           ),
                            child: ListTile(
                            title: const Center(child: Text('Play Again',
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),  
                            onTap: () => restart(),

                           ),), 
                          SizedBox(height: 15),
                              Container( decoration:   BoxDecoration(
                                  color: Colors.brown[200], 
                                  borderRadius: BorderRadius.circular(50), 
                                ),
                              child: ListTile( 
                              title: const Center(child: Text('Home',
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
                              onTap: () {
                                print("tapped");
                                  Navigator.of(context).pop(
                                  CupertinoPageRoute(
                                    builder: (_) => HomeScreen()));
                              },
                            ),
                          ), 
                  ],
              ),
            )
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               Text('Pairs Left: $_left',style: Theme.of(context).textTheme.headlineSmall), 
                              ],
                            ),
                    ),
                   Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:  const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          if (!_start) { 
                            return getItem(index);
                          }
                        return FlipCard( 
                            key: _cardStateKeys[index],
                            onFlip: () {
                              if (!_flip) {
                                _flip = true;
                                _previousIndex = index;
                              } else {
                                _flip = false;
                                if (_previousIndex != index) {
                                  if (_data[_previousIndex] != _data[index]) 
                                  { //cards DONT match po
                                    _wait = true;
                                    Future.delayed(const Duration(milliseconds: 1000), () { //used to give users a chance to see the unmatched cards before they flip back.
                                      _cardStateKeys[_previousIndex].currentState!.toggleCard(); //effectively flips the previous card back to its original state which is true
                                      _previousIndex = index;
                                      _cardStateKeys[_previousIndex].currentState!.toggleCard();
                                      Future.delayed(const Duration(milliseconds: 150), () { //ensure that the card flip animation completes before updating the state. para hindi mag overlap
                                        setState(() {
                                          _wait = false; //This triggers a rebuild of the UI
                                        });
                                      });
                                    });
                                  } 
                                  else {  //cards MATCH po
                                    _cardFlips[_previousIndex] = false;
                                    _cardFlips[index] = false;
                                    setState(() {
                                      _left -= 1; //meaning bawas na po yung pairs
                                    });
                                    if (_cardFlips.every((t) => t == false)) { //na matched na po lahat
                                      Future.delayed(const Duration(milliseconds: 800), () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Finished!',
                                          text: 'Great Job!',
                                          confirmBtnColor: Colors.brown,
                                          headerBackgroundColor: Colors.brown,
                                      );
                                        setState(() { print('won');
                                          _isFinished = true;
                                          _start = false;
                                        });
                                      });
                                    }
                                  }
                                }
                              }
                              setState(() {});
                            },
                            flipOnTouch: _wait ? false : _cardFlips[index],
                            direction: FlipDirection.HORIZONTAL,
                            front: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 3,
                                    spreadRadius: 0.8,
                                    offset: Offset(2.0, 1),
                                  )
                                ]
                              ),
                              margin: EdgeInsets.all(4.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/pics/quest.png",
                                ),
                              ),
                            ),
                            back: getItem(index),
                          );
                        },
                        itemCount: _data.length,
                      ),
                    )
                
                  ],
                ),
              ),
            ),
        ),
    );
  }
  
 void restart() {
  _data = getSourceArray(_level).cast<String>(); //retrieves the data from the fillSource with the given level
  _cardFlips = getInitialItemState(_level); 
  _cardStateKeys = getCardStateKeys(_level);
  _left = (_data.length ~/ 2); // the length of the data divided by 2 po
  _isFinished = false;

  _cardStateKeys.forEach((key) { //yung present state nung card kung naka face up ba or hindi
    key.currentState?.toggleCard();
  });

  setState(() {
    _start = true;
  });
}


  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    super.dispose();
  }

}

