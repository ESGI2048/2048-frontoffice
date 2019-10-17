class ComponentGrid {
  //List<List<Component>> gridComponent;

  void InterpretAction(int direction){
    switch(direction)
    {
      
    }
  }
}


class Component {
  String id;
  String _name;
  int _value;
  String _imageFilePath;
  String _type;
  int x, y;

  Component(String name, int value, String imageFilePath, String type) {
    _name = name;
    _value = value;
    _imageFilePath = imageFilePath;
    _type = type;
  }

/*
* Rules for addition of components:
* Boitier val 1 + Boitier val 1
* Cadran val 1 + Cadran val 1 = Cadran val 2
* Bracelet
* */

  static void MoveComponent(Component c, int x, int y){

  }


  static Component AddTwoComponents(Component c1, Component c2)
  {

  }
  static Component AddTwoComponents2(Component c1, Component c2)
  {

    Component newComp = new Component("initName", 0, "C:\\", "initVal");
    // detect the type
    if(c1._type == c2._type && c1._value == c2._value){
      if (c1._type == "cadran"){
        switch(c1._value){
          case 2:
            newComp._value = c1._value + c2._value;
            newComp._name = '${c1._type}${newComp._value}';
            break;
          case 4:
            break;
          case 8:
            break;
          case 16:
            break;
        }
      }else if (c1._type == "boitier"){

      }else if (c1._type == "bracelet"){

      }

    }

    // detect the value


    //Component c3 = new Component(c1._name, c1._value + c2._value, );

  }

}