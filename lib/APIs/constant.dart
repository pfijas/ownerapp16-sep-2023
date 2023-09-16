// //Date picker First in project that 2
// Column(
// children: [
// Container(
// width: 300,
// height: 60,
// child: Card(
// elevation: 5,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// side: BorderSide(width: 0, color: Colors.brown),
// ),
// child: Padding(
// padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
// child: TextField(
// controller: _dateController,
// decoration: InputDecoration(
// border: InputBorder.none,
// prefixIcon: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
// SizedBox(width: 8),
// Padding(
// padding: EdgeInsets.only(top: 6),
// child: Text(
// "Date from :",
// style: TextStyle(color: Colors.blueGrey),
// ),
// ),
// SizedBox(
// width: 10,
// ),
// ],
// ),
// ),
// style: TextStyle(color: Colors.blueGrey),
// readOnly: true,
// onTap: () async {
// final pickedDate = await showDatePicker(
// context: context,
// initialDate: selectedDate,
// firstDate: DateTime(2000),
// lastDate: DateTime(2101),
// locale: const Locale("en", "US"),
// initialDatePickerMode: DatePickerMode.year,
// );
// if (pickedDate != null) {
// setState(() {
// selectedDate = pickedDate;
// _dateController.text = _dateFormat.format(selectedDate);
// });
// }
// },
// ),
// ),
// ),
// ),
// SizedBox(height: 10), // Adding spacing between the two cards
// Container(
// width: 300,
// height: 60,
// child: Card(
// elevation: 5,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// side: BorderSide(width: 0, color: Colors.brown),
// ),
// child: Padding(
// padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
// child: TextField(
// controller: _dateControllerTo,
// decoration: InputDecoration(
// border: InputBorder.none,
// prefixIcon: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(Icons.calendar_month_sharp, color: Colors.blueGrey),
// SizedBox(width: 8),
// Padding(
// padding: EdgeInsets.only(top: 6),
// child: Text(
// "Date to :",
// style: TextStyle(color: Colors.blueGrey),
// ),
// ),
// SizedBox(
// width: 10,
// ),
// ],
// ),
// ),
// style: TextStyle(color: Colors.blueGrey),
// readOnly: true,
// onTap: () async {
// final pickedDateTo = await showDatePicker(
// context: context,
// initialDate: selectedDateTo,
// firstDate: DateTime(2000),
// lastDate: DateTime(2101),
// locale: const Locale("en", "US"),
// initialDatePickerMode: DatePickerMode.year,
// );
// if (pickedDateTo != null) {
// setState(() {
// selectedDateTo = pickedDateTo;
// _dateControllerTo.text = _dateFormat.format(selectedDateTo);
// });
// }
// },
// ),
// ),
// ),
// ),
// ],
// )