part of dash_chat;

class DateBuilder extends StatelessWidget {
  DateBuilder({
    required this.date,
    this.customDateBuilder,
    this.dateFormat,
  });

  final DateTime date;
  final Widget Function(String)? customDateBuilder;
  final DateFormat? dateFormat;

  @override
  Widget build(BuildContext context) {
    return customDateBuilder?.call(dateFormat?.format(date) ??
            DateFormat('yyyy-MM-dd').format(date)) ??
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.only(
            bottom: 5.0,
            top: 5.0,
            left: 10.0,
            right: 10.0,
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            dateFormat != null
                ? dateFormat!.format(date)
                : DateFormat('yyyy-MMM-dd').format(date),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        );
  }
}
