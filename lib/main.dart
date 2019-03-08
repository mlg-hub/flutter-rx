import 'package:flutter/material.dart';

import 'package:weather_rxcom/models/model_command.dart';
import 'package:weather_rxcom/models/model_provider.dart';
import 'package:weather_rxcom/models/models.dart';

import 'package:weather_rxcom/weather_repo.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:http/http.dart' as http;

void main() {
  final repo = WeatherRepo(client: http.Client());
  final modelCommand = ModelCommand(repo);
  runApp(ModelProvider(
    child: MyWeatherApp(),
    modelCommand: modelCommand,
  ));
}

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Weather App', theme: ThemeData(), home: MyHomeApp());
  }
}

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => new _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: <Widget>[
          Container(
            child: Center(
              child: RxLoader<bool>(
                radius: 20.0,
                commandResults: ModelProvider.of(context).getGpsCommand,
                dataBuilder: (context, data) =>
                    Text(data ? 'GPS active' : 'GPS inactive'),
                placeHolderBuilder: (context) => Text('push button'),
                errorBuilder: (context, exception) => Text('$exception'),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.gps_fixed),
            onPressed: ModelProvider.of(context).getGpsCommand,
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(children: <Widget>[
        Expanded(
          child: RxLoader<List<WeatherModel>>(
            radius: 30.0,
            commandResults: ModelProvider.of(context).updateWeatherCommand,
            dataBuilder: (context, data) => WeatherList(data),
            placeHolderBuilder: (context) => Center(
                  child: Text('No data'),
                ),
            errorBuilder: (context, exception) =>
                Center(child: Text('$exception')),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6.0),
                child: WidgetSelector(
                  buildEvents: ModelProvider
                      .of(context)
                      .updateWeatherCommand
                      .canExecute,
                  onTrue: MaterialButton(
                    elevation: 5.0,
                    color: Colors.greenAccent,
                    child: Text("Get the weather"),
                    onPressed:
                        ModelProvider.of(context).updateLocationCommand.execute,
                  ),
                  onFalse: MaterialButton(
                    onPressed: null,
                    color: Colors.grey,
                    child: Text('Data off'),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(children: <Widget>[
                  SliderItem(
                    sliderState: false,
                    command: ModelProvider.of(context).radioCheckedCommand,
                  ),
                  Switch(
                    value: true,
                    onChanged: (item) {
                      setState(() {
                        item = !item;
                      });
                    },
                    activeColor: Colors.greenAccent,
                  )
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class WeatherList extends StatelessWidget {
  final List<WeatherModel> list;
  WeatherList(this.list);
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(list[index].city),
            ));
  }
}

class SliderItem extends StatefulWidget {
  final bool sliderState;
  final ValueChanged<bool> command;

  SliderItem({Key key, this.sliderState, this.command}) : super(key: key);
  @override
  _SliderItemState createState() => new _SliderItemState(sliderState, command);
}

class _SliderItemState extends State<SliderItem> {
  bool sliderState;
  ValueChanged<bool> command;
  _SliderItemState(this.sliderState, this.command);

  @override
  void initState() {
    super.initState();
    command(sliderState);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: sliderState,
      onChanged: (item) {
        setState(() {
          print('the command: $command(item)');
          sliderState = item;
        });
        command(item);
      },
    );
  }
}
