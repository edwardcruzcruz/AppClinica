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
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento2.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento3.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Horarios.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
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
  List<HorarioRango> horariosID;
  Doctor doctor;
  User usuario;
  int idEspecialidadEscogida;
  Function callback,callbackloading,callbackfull;
  bool agendar;
  CalendarioPage({Key key, this.usuario,this.idEspecialidadEscogida,this.horarios,this.horariosID,this.doctor,this.callback,this.callbackloading,this.callbackfull,this.agendar}) : super(key: key);
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
      //
      for(int h=0;h<horarios.length;h++){
        DateTime fechaTemp=DateTime.parse(horarios.elementAt(h).Fecha);
        _selectedEvents.add(this.widget.horariosID.elementAt(h).HorarioInicio+ " "+this.widget.horariosID.elementAt(h).Horariofin);
        //_selectedEvents.add(horario.Hora);
        int days=fechaTemp.difference(temp).inDays-1;
        _events[fechaTemp.add(Duration(days: days))]=_selectedEvents.toList();
        /*
        _selectedEvents.add(this.widget.horariosID.elementAt(h).HorarioInicio+ " "+this.widget.horariosID.elementAt(h).Horariofin);
          //_selectedEvents.add(horario.Hora);
          if(!_events.containsKey(fechaTemp)){
            _events[fechaTemp]=_selectedEvents.toList();
          }else{
            _events[fechaTemp]=_selectedEvents.toList();

          }
        */
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

  Future _onDaySelected(DateTime day, List events) {// async
    print('CALLBACK: _onDaySelected');
    print('$day');
    setState(() {
      _fechaElegida=day;
      _selectedEvents = events;
    });
    /*this.widget.callbackloading();
    List<Cita> citas=await RestDatasource().ListarCitas();
    if(citas!=null){
      for(int i=0;i<citas.length;i++){
        if(citas.elementAt(i).Especialidad!=null){
          //horariosId.add(horarioid);
        }

      }
    }
    this.widget.callbackfull;*/
    this.widget.callback(Horarios(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,horarios: this.widget.horarios,doctor: this.widget.doctor,date: _fechaElegida,selectedEvents: _selectedEvents,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          height: 100.0,
          decoration: new BoxDecoration(

              gradient: new LinearGradient(
                colors: [
                  Color(0xFF00a18d),
                  Color(0xFF00d6bc),
                ],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 120.0))
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Align(
                  child: Text(Strings.CuerpoTituloBienvenido,style: appTheme().textTheme.display1,),
                  alignment: Alignment(-0.80, 0),
                ),
                Align(
                  child: new Text(storageService.getCuentaActual,style: appTheme().textTheme.display2,),
                  alignment: Alignment(-0.80, 0),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),),
                Align(
                  child: Text(Strings.AppbarIconoAgregarCita,style: appTheme().textTheme.display3,),
                ),
              ],
            ),
          ),
        ),
        new Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Switch out 2 lines below to play with TableCalendar's settings
              //-----------------------
              _cabeceraAgendar(),
              /*Container(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async{
                        this.widget.callbackloading();
                        List<Doctor> doctores= await RestDatasource().doctoresEspecialidad(this.widget.doctor.Especialidad);
                        this.widget.callbackfull();
                        this.widget.callback(Agendamiento2(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,doctores: doctores,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
                            Text(Strings.TextRetroceder,style: appTheme().textTheme.subtitle,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //alignment: Alignment(50, 0),
                        margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
                        child: Text(Strings.AgendarTitulo3,style: appTheme().textTheme.title,)
                    )
                  ],
                ),
              ),*/
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      width: 270,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 40),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: new Image.asset('assets/avatar.png',width: 43,height: 50),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text((this.widget.doctor.Especialidad==3?"OD. ":this.widget.doctor.Especialidad==2?"NUT. ":"PSIC. ")+this.widget.doctor.Nombre+" "+this.widget.doctor.Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: _buildTableCalendar(),
                      //width: 300,
                      //height: 300,
                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 8.0),
              //Expanded(child: _buildEventList()),
            ],
          ),
        )
        //),
      ],
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
        selectedColor: appTheme().buttonColor,
        todayColor: appTheme().textTheme.display4.color,
        markersColor: appTheme().textTheme.display3.color,
        //outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: appTheme().textTheme.display4.color,//color 2 semanas  mes, etc.. cabecera
          borderRadius: BorderRadius.circular(16.0),
        ),
        //formatButtonVisible: false,//oculto 2 semanas, mes , etc
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

  /*Widget _buildEventList() {
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
              this.widget.callbackloading();
              Doctor doctor=await RestDatasource().doctoresId(horarios.elementAt(0).IdDoctor);
              this.widget.callbackfull();
              this.widget.callback(Agendamiento3(cita: new Cita(storageService.getEmail,doctor.Especialidad,"consulta",(DateFormat("yyyy-MM-dd").format(_fechaElegida).toString()+" "+event),doctor.Nombre+' '+doctor.Apellido),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Agendamiento3(cita: new Cita(storageService.getEmail,doctor.Especialidad,"consulta",DateTime.parse(DateFormat("yyyy-MM-dd").format(_fechaElegida).toString()+" "+event),doctor.Nombre+' '+doctor.Apellido),)),
              );*/
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
  void _showDialogSeleccionNull() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sin contenido"),
          content: new Text("No hay horarios disponibles con este doctor"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  Widget _cabeceraAgendar() {
    if (this.widget.agendar) {
      return new Container(
        child: new Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                this.widget.callbackloading();
                List<Doctor> doctores= await RestDatasource().doctoresEspecialidad(this.widget.doctor.Especialidad);
                this.widget.callbackfull();
                this.widget.callback(Agendamiento2(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,doctores: doctores,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
                    Text(Strings.TextRetroceder,style: appTheme().textTheme.subtitle,)
                  ],
                ),
              ),
            ),
            Container(
              //alignment: Alignment(50, 0),
                margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
                child: Text(Strings.AgendarTitulo3,style: appTheme().textTheme.title,)
            )
          ],
        ),
      );

  }else
    return new Container(
      child: new Row(
        children: <Widget>[
          Container(
            //alignment: Alignment(50, 0),
              margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
              child: Text(Strings.AgendarTitulo3,style: appTheme().textTheme.title,)
          )
        ],
      ),
    );
  }
  /*if (this.widget.agendar){
  return new GestureDetector(
  onTap: () async{
  this.widget.callbackloading();
  List<Doctor> doctores= await RestDatasource().doctoresEspecialidad(this.widget.doctor.Especialidad);
  this.widget.callbackfull();
  this.widget.callback(Agendamiento2(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,doctores: doctores,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
  },
  child: Container(
  margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
  child: Row(
  children: <Widget>[
  Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
  Text(Strings.TextRetroceder,style: appTheme().textTheme.subtitle,)
  ],
  ),
  ),
  ),
  Container(
  //alignment: Alignment(50, 0),
  margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
  child: Text(Strings.AgendarTitulo3,style: appTheme().textTheme.title,)
  )
  }else{
  return new Container(
  //alignment: Alignment(50, 0),
  margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
  child: Text(Strings.AgendarTitulo3,style: appTheme().textTheme.title,)
  )
  }*/

}