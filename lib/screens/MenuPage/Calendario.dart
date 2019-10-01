//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/components/table_calendar.dart';
import 'package:flutter_app/models/Cita.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento3.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};
/*void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarioPage(title: 'Table Calendar Demo'),
    );
  }
}*/
class CalendarioPage extends StatefulWidget {
  List<Horario> horarios;

  CalendarioPage({Key key, this.horarios}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => CalendarioPage(),
    );
  }

  //CalendarioPage({Key key, this.especialidad}) : super(key: key);

  //final String especialidad;

  @override
  _CalendarioState createState() => _CalendarioState(this.horarios);
}

class _CalendarioState extends State<CalendarioPage> with TickerProviderStateMixin {
  List<Horario> horarios;
  DateTime _fechaElegida=DateTime.now();
  Map<DateTime, List<String>> _events=new HashMap();
  List<String> _selectedEvents= new List();
  AnimationController _animationController;
  CalendarController _calendarController;
  var storageService = locator<Var_shared>();


  _CalendarioState(this.horarios);

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    DateTime temp=DateTime.parse(DateFormat("yyyy-MM-dd").format(_selectedDay).toString());

    if(horarios!=null){
      for(final horario in horarios){
        DateTime fechaTemp=DateTime.parse(horario.Fecha);
        //print(horario.Fecha+"->"+DateFormat("yyyy-MM-dd").format(_selectedDay).toString());
        print(horario.Fecha==DateFormat("yyyy-MM-dd").format(_selectedDay).toString());
        if(fechaTemp.isAfter(temp)){
          _selectedEvents.add(horario.Hora);
          //_selectedEvents.add(horario.Hora);
          _events[fechaTemp.add(Duration(days: fechaTemp.difference(temp).inDays))]=_selectedEvents.toList();
        }else if(fechaTemp.isBefore(temp)){
          print("hola antes");
        }else if(fechaTemp.isAtSameMomentAs(temp)){
          //print("hey");
          //_events.addAll(DateTime.parse(horario.Fecha),List());
          _selectedEvents.add(horario.Hora);
          //_selectedEvents.add(horario.Hora);
          if(!_events.containsKey(fechaTemp)){
            _events[fechaTemp]=_selectedEvents.toList();
          }else{
            _events[fechaTemp]=_selectedEvents.toList();

          }
          //_selectedEvents.add(horario.Hora);
          //print(_selectedEvents.length);
        }
      }
    }

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    print('$day');
    setState(() {
      _fechaElegida=day;
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          //_buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('setDay 10-07-2019'),
          onPressed: () {
            _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () async{
            print(DateTime.parse(DateFormat("yyyy-MM-dd").format(_fechaElegida).toString()+" "+event));
            if(horarios!=null){//el calendario es valido
              Doctor doctor=await RestDatasource().doctoresId(horarios.elementAt(0).IdDoctor);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Agendamiento3(cita: new Cita(storageService.getEmail,doctor.Especialidad,"consulta",DateTime.parse(DateFormat("yyyy-MM-dd").format(_fechaElegida).toString()+" "+event),doctor.Nombre+' '+doctor.Apellido),)),
              );
            }else{
              print("no se peude hacer nada");
            }



            //print('$event tapped!');
          },
        ),
      ))
          .toList(),
    );
  }
}