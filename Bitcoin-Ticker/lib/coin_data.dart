import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey='C0AF0376-65B9-47D9-AA94-65CA880F6225';
const urlstart='https://rest.coinapi.io/v1/exchangerate';

class CoinData {


  Future getCoinData({String currtype}) async {
    Map<String, String> cryptoPrices = {};
    for (String bttype in cryptoList) {
      String requestURL = '$urlstart/$bttype/$currtype?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        String data = response.body;
        print(data);
        var decodeddata = jsonDecode(data);
        double rate = decodeddata['rate'];
        cryptoPrices[bttype]=rate.toStringAsFixed(0);


      }
      else {
        print(response.statusCode);
        throw 'Some Problem!!';
      }
    }
    return cryptoPrices;

  }
}
