import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.article,
                        size: 26.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Attractions",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "6 Attractions",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.comment,
                        size: 26.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Comments",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "+32 Comments",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.people,
                        size: 26.0,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Subscribers",
                        style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "32 Subscribers",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        size: 26.0,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Liked\nAttractions",
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "23 Attractions",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
