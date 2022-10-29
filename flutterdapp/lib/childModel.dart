import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:encrypt/encrypt.dart';
import 'main.dart' as pass;

class childModel extends ChangeNotifier {
  bool isLoading = true;
  late Client _httpClient;
  late String _contractAddress;
  late String _abi;
  late Web3Client _client;
  late EthPrivateKey _credentials;
  late DeployedContract _contract;
  late String x;
  late String y;
  late String latitude;
  late String longitude;
  late ContractFunction _readCoordinates;
  late ContractFunction _sendCoordinates;
  childModel() {
    initiateSetup();
  }
  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
        "https://rinkeby.infura.io/v3/84ee596119e643cdb6e534c7c3674cfa",
        _httpClient);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    _abi = await rootBundle.loadString("../assets/abi.json");
    _contractAddress = "0x4943030bce7e49dd13b4dd120c0fef7dde3c18a0";

//print(_abi);
//print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(
        "d585835f87981557df21fbaf99df4c9d06fd374b6efd121c027e0655cee5b627");
//print(_credentials);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abi, "Project"),
        EthereumAddress.fromHex(_contractAddress));
    _readCoordinates = _contract.function("readCoordinates");
    _sendCoordinates = _contract.function("sendCoordinates");
  }

  getCoordinates() async {
    List readCoordinates = await _client
        .call(contract: _contract, function: _readCoordinates, params: []);
    x = readCoordinates[0];
    y = readCoordinates[1];
//print(x);
//print(y);
  }

  addCoordinates(String lat, String lon) async {
//print(lat + "received");
//print(lon + "received");
//print(pass.password);
    latitude = EncryptionDecryption.encryptAES(lat);
    longitude = EncryptionDecryption.encryptAES(lon);
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _sendCoordinates,
        parameters: [latitude, longitude],
        maxGas: 100000,
      ),
      chainId: 4,
    );

//print("Sent Coordinates");
    print("Encrypted Data:");
    print(latitude);
    print(longitude);
    print("Sent Encrypted Data");
    getCoordinates();
    isLoading = false;
    notifyListeners();
  }
}
