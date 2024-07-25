import 'package:flutter/material.dart';
import 'animal.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

int score = 0;
List<Animal> list1 = [];
List<Animal> list2 = [];
void initLevel() {
  score = 0;
  list1 = [
    Animal(name: 'Tiger', img: 'assets/tiger.jpg', voice: 'none'),
    Animal(name: 'Bird', img: 'assets/bird.jpg', voice: 'none'),
    Animal(name: 'Deer', img: 'assets/deer.jpg', voice: 'none'),
    Animal(name: 'Elephant', img: 'assets/elephant.jpg', voice: 'none'),
  ];
  list2 = List<Animal>.from(list1);

  list1.shuffle();
  list2.shuffle();
}

class _Level1State extends State<Level1> {
  @override
  void initState() {
    initLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Score: ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  score.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(
                  width: 240,
                ),
                IconButton(
                  onPressed: () {
                    initLevel();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 260,
            color: Colors.orange,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                children: list1.map((animal1) {
                  return Draggable<Animal>(
                    data: animal1,
                    childWhenDragging: Container(),
                    feedback: Text(
                      animal1.name,
                      style: TextStyle(
                          fontSize: 28,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: Text(
                        animal1.name,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                width: 100,
              ),
              Column(
                children: list2.map((animal2) {
                  return DragTarget<Animal>(onAcceptWithDetails: (animal1) {
                    if (animal1.data.name == animal2.name) {
                      setState(() {
                        list1.remove(animal2);
                        list2.remove(animal2);
                        score = score + 10;
                      });
                    }
                  }, builder: (context, _, __) {
                    return Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Image(
                        
                        image: AssetImage(animal2.img),
                        width: 100,
                        height: 50,
                      ),
                    );
                  });
                }).toList(),
                
              ),
            ],
          ),
        ],
      ),
      
    )
    
    ;
  }
}
