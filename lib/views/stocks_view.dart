import 'package:alpha_vantage_package/alpha_vantage_package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StocksView extends StatefulWidget {
  @override
  _StocksViewState createState() => _StocksViewState();
}

class _StocksViewState extends State<StocksView> {

  bool isLoading = true;
  Map<String, dynamic> quotePrices = Map();
  final symbols = [
//    'MSFT', 'GOOG', 'KO', 'AMZN', 'TSLA',
    'TSN', 'ASML', 'MU', 'CSCO'];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
//    final timeSeries = TimeSeries('CO1J6O4NOH2ZIGDM');
    final timeSeries = TimeSeries('39ON9XH1UAZKDQA3');
    for (String symbol in symbols) {
      quotePrices[symbol] = (await timeSeries.getIntraday(symbol)).getJSONMap();
      debugPrint('got $symbol');
    }
//    debugPrint('yuh\n${quotePrices}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 2.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Text('Stocks', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.left),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                for(var symbol in symbols)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2.2 - 116,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '$symbol: \$${(quotePrices[symbol]["Time Series (1min)"][quotePrices[symbol]["Time Series (1min)"].keys.toList()[0]]['4. close']).substring(0,(quotePrices[symbol]["Time Series (1min)"][quotePrices[symbol]["Time Series (1min)"].keys.toList()[0]]['4. close']).length-2)}',
                                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                                maxLines: 3,
                              ),
                              Text(
                                // todo there's a probelm with this
                                'at ${DateFormat('MM/dd hh:mm').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(quotePrices[symbol]["Time Series (1min)"].keys.toList()[0]))}',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.right,
                                maxLines: 3,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
