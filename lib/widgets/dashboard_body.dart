import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                Text(
                  "6 Attractions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "3 new Attractions",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type Attraction Title",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40.0,
        ),

        //let's set the filter section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: VAPrimaryColor,
              ),
              label: const Text(
                "2022, July 14, July 15, July 16",
                style: TextStyle(
                  color: VAPrimaryColor,
                ),
              ),
            ),
            Row(
              children: [
                DropdownButton(
                    hint: const Text("Filter by"),
                    style: const TextStyle(fontSize: 18),
                    items: const [
                      DropdownMenuItem(
                        value: "Date",
                        child: Text("Date"),
                      ),
                      DropdownMenuItem(
                        value: "Comments",
                        child: Text("Comments"),
                      ),
                      DropdownMenuItem(
                        value: "Views",
                        child: Text("Views"),
                      ),
                    ],
                    onChanged: (value) {}),
                const SizedBox(
                  width: 20.0,
                ),
                DropdownButton(
                    hint: const Text("Order by"),
                    style: const TextStyle(fontSize: 18),
                    items: const [
                      DropdownMenuItem(
                        value: "Date",
                        child: Text("Date"),
                      ),
                      DropdownMenuItem(
                        value: "Comments",
                        child: Text("Comments"),
                      ),
                      DropdownMenuItem(
                        value: "Views",
                        child: Text("Views"),
                      ),
                    ],
                    onChanged: (value) {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
