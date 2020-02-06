import 'package:flutter/material.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Mis_Citas.dart';

void main() => runApp(Alert_Citas());

class Alert_Citas extends StatefulWidget {
  int cita_id;
  int rating;
  String opinion;
  Function callback, callbackloading, callbackfull;
  Alert_Citas({Key key, this.cita_id, this.rating, this.opinion,this.callback, this.callbackloading, this.callbackfull})
      : super(key: key);

  @override
  _Alert_CitasState createState() => _Alert_CitasState();
}

class _Alert_CitasState extends State<Alert_Citas> {
  var rating = 0.0;

  TextEditingController opinion = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Dialog(

      child:
      Container(
        height: 275,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            /*mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,*/
            children: [
              Center(
                child: Text(
                    '¡Califícanos!'
                ),
              ),
              Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: SmoothStarRating(



                      rating: rating,
                      size: 45,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                      allowHalfRating: false,
                      spacing: 0.0,
                      onRatingChanged: (value) {
                        print(value);
                        print(rating);

                        setState(() {
                          rating = value;
                        });
                        /*setState(() {

                            });*/
                      },
                    ),
                  )

              ),
              Center(
                child: TextField(
                  maxLines: 3,
                  controller: opinion,
                  decoration:
                  InputDecoration(
                      hintText: "Danos tu opinión...",
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),

                      ),
                      fillColor: Color(0xFF00d6bc)
                  ),
                ),
              ),

              FlatButton(
                textColor: Color(0xFF00d6bc),

                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Aceptar",
                    textAlign: TextAlign.right,
                    //style: buttonTextStyle
                  ),

                ),

                onPressed: () async{
                  print(rating);
                  print(opinion.text);
                  print(this.widget.opinion);
                  print(this.widget.cita_id);
                  var respuesta = await RestDatasource().save_comentario(this.widget.cita_id,opinion.text);
                  var respuesta1= await RestDatasource().save_puntuacion(this.widget.cita_id,rating);
                  Navigator.of(context).pop();

                  this._showDialogSave();

                },
              ),
              /*SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )*/
            ],
          ),
        ),
      ),
    )
    ;
  }

  void _showDialogSave() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Registro Exitoso"),
          content: new Text("Se ha registrado su comentario, gracias por calificarnos "),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                this.widget.callback(Citas(
                    callback: this.widget.callback,
                    callbackloading: this.widget.callbackloading,
                    callbackfull: this.widget.callbackfull));
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],

        );

          /*actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                this.widget.callback(Noticias());
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],*/

      },
    );
  }

}