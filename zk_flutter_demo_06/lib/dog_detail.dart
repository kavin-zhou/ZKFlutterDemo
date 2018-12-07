import 'package:flutter/material.dart';
import 'dog_model.dart';

class DogDetailPage extends StatefulWidget {
  final Dog dog;
  DogDetailPage(this.dog);

  @override
  _DogDetailPageState createState() => _DogDetailPageState();
}

class _DogDetailPageState extends State<DogDetailPage> {
  final double dogAvatarSize = 150.0;

  Widget get dogImage {
    return Container(
      width: dogAvatarSize,
      height: dogAvatarSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            const BoxShadow(
                offset: const Offset(1.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: const Color(0x33000000)),
            const BoxShadow(
                offset: const Offset(2.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
                color: const Color(0x24000000)),
            const BoxShadow(
                offset: const Offset(3.0, 1.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                color: const Color(0x1F000000)),
          ],
          image: DecorationImage(
            image: NetworkImage(widget.dog.imageUrl),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.star, color: Colors.white, size: 40.0),
        Text('${widget.dog.rating} / 10', style: Theme.of(context).textTheme.display2),
      ],
    );
  }

  Widget get dogProfile {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.red,
            Colors.orange
          ],
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
          Text('${widget.dog.name}', style: TextStyle(fontSize: 32.0)),
          Text('${widget.dog.location}', style: TextStyle(fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text('${widget.dog.description}'),
          ),
          rating,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.dog.name)),
      body: dogProfile,
    );
  }
}