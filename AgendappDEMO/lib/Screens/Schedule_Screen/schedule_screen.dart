import 'package:flutter/material.dart';
import 'package:flutter_login_page/Model/Talk.dart';

class MySchedulePage extends StatefulWidget {
  final List<Talk> talkList;

  const MySchedulePage({Key key, this.talkList}) : super(key: key);

  @override
  MySchedulePageState createState() => MySchedulePageState();
}

class MySchedulePageState extends State<MySchedulePage> {


  List<DateTime> daysList = [new DateTime(2019, 12, 8, 8, 0), new DateTime(2019, 12, 9, 8, 0),new DateTime(2019, 12, 10, 8, 0),new DateTime(2019, 12, 11, 8, 0),new DateTime(2019, 12, 12, 8, 0),new DateTime(2019, 12, 13, 8, 0)];


  final List<String> timeInterval = [
    "08:00 AM", "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 AM", "12:30 AM",
    "01:00 PM", "01:30 PM", "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM"
  ];

  int firstBlock = 0;
  int finalBlock = 0;
  int numBlocks = 0;



  String convertWeekDay(int day){
    switch (day) {
      case 1:
        return "MON";
        break;
      case 2:
        return "TUE";
        break;
      case 3:
        return "WED";
        break;
      case 4:
        return "THU";
        break;
      case 5:
        return "FRI";
        break;
      case 6:
        return "SUN";
        break;
      case 7:
        return "SAT";
        break;
      default:
        return "nada";
    }
  }

  String convertMonth(int month){
    switch (month) {
      case 1:
        return "JAN";
        break;
      case 2:
        return "FEB";
        break;
      case 3:
        return "MAR";
        break;
      case 4:
        return "APR";
        break;
      case 5:
        return "MAY";
        break;
      case 6:
        return "JUN";
        break;
      case 7:
        return "JUL";
        break;
      case 8:
        return "AUG";
        break;
      case 9:
        return "SET";
        break;
      case 10:
        return "OCT";
        break;
      case 11:
        return "NOV";
        break;
      case 12:
        return "DEC";
        break;
      default:
        return "nada";
    }
  }

// Usado para facilitar a colocaçao dos blocos na tabela
  void convertToBlocks(DateTime initTime, DateTime finalTime){

    firstBlock = ((initTime.hour-8)*2 + (initTime.minute)/30).round();
    finalBlock = ((finalTime.hour-8)*2 + (finalTime.minute)/30).round();
    numBlocks = finalBlock - firstBlock;
  }

  Container placeBlocks(int i, int j, Color backColor, Color blockColor){
    int finalBlockBefore = finalBlock;
    convertToBlocks(widget.talkList[j].dateInitial, widget.talkList[j].dateFinal);
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              color: backColor,
              height: MediaQuery.of(context).size.width * 0.055*(firstBlock-finalBlockBefore),
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              color: widget.talkList[j].color.withOpacity(0.5),
              height: MediaQuery.of(context).size.width * 0.055 * numBlocks,
              width: MediaQuery.of(context).size.width,
            )
          ],
        )
    );
  }

  Container displayTime(int i){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            timeInterval[i],
            style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 10
            ),
          ),
        ],
      ),
      color: Colors.white,
      height: MediaQuery.of(context).size.width * 0.055,
      width: MediaQuery.of(context).size.width,
    );
  }

  Container displaySchedule(int i){
    Color color1;
    Color color2;

    if((i%2) != 0){
      color1= Color.fromARGB(255,240,240,240);
      color2= Color.fromARGB(255,250,250,250);
    }
    else{
      color2= Color.fromARGB(255,240,240,240);
      color1= Color.fromARGB(255,250,250,250);
    }
    finalBlock=0;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      convertWeekDay(daysList[i].weekday),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF444444),
                          fontSize: 20
                      ),
                    ),
                    Text(
                      daysList[i].day.toString() + convertMonth(daysList[i].month),
                      style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 13
                      ),
                    ),
                  ],
                ),

              ],
            ),
            color: color1,
            height: MediaQuery.of(context).size.width * (1/(daysList.length + 1)),
            width: MediaQuery.of(context).size.width,
          ),

          for(int j = 0; j < widget.talkList.length; j++)
            if(daysList[i].day == widget.talkList[j].dateInitial.day && widget.talkList[j].selected)
              placeBlocks(i, j, color2, Color.fromARGB(255,247,220,222)),
        ],
      ),
      alignment: Alignment.topLeft,
      color: color2,
      width: MediaQuery.of(context).size.width * (1/(daysList.length + 1)),
      height: MediaQuery.of(context).size.height,
    );

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.width * (0.055 * (timeInterval.length - 2) + 0.1 + 1/(daysList.length + 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget> [
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.width * (1/(daysList.length + 1 + 1.1)),
                        width: MediaQuery.of(context).size.width,
                      ),
                      for(int i = 0; i < timeInterval.length; i++)
                        displayTime(i),
                    ],
                  ),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * (1/(daysList.length + 1)),
                  height: MediaQuery.of(context).size.height,
                ),
                for(int i = 0 ; i < daysList.length ; i ++)
                  displaySchedule(i),

              ],
            )
        )
    );

  }
}