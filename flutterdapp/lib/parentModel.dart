import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'main.dart' as pass;

class parentModel extends ChangeNotifier {
  bool isLoading = true;
  List<dynamic> addresses = [];
  late Client _httpClient;
  late String _contractAddress;
  late String _abi;
  late Web3Client _client;
// ignore: unused_field
  late Credentials _credentials;
  late String x;
  late String y;
  late String latitude;
  late String longitude;
  late DeployedContract _contract;
  late ContractFunction _readCoordinates;
  late ContractFunction _empContractStatus;
  late List empStatusList;
  late ContractFunction _getEmployees;
  late ContractFunction _setEmployee;

  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
        "wss://goerli.infura.io/ws/v3/d6525bf95d3746c485fbcfb80bea5bf6",
        _httpClient);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    _abi = await rootBundle.loadString("../assets/abi.json");
    _contractAddress = "0xDD958a6a596b0C84aE80D6D5927ca24ea53fE66F";
//print(_abi);
//print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(
        "dc18426456bc2e9640594701099a0bb8217ff8017e1b92a47bf768160c67ba65");
//print(_credentials);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abi, "Project"),
        EthereumAddress.fromHex(_contractAddress));
    _readCoordinates = _contract.function("readCoordinates");
    print(_contract);
//print("stopped here");
  }

  getCoordinates() async {
    initiateSetup();
    List readCoordinates = await _client
        .call(contract: _contract, function: _readCoordinates, params: []);
    x = readCoordinates[0];
    y = readCoordinates[1];
    print("data retrieved");
    print(x);
    print(y);
//print(pass.password);
    latitude = EncryptionDecryption.decryptAES(x);
    longitude = EncryptionDecryption.decryptAES(y);
    print("Decrypted");
    print(latitude);
    print(longitude);
    isLoading = false;
    notifyListeners();
  }

  getEmployeeContractStatus(List address) async {
    initiateSetup();

    List empStatus = [];

    if (addresses.length != 0) {
      for (int i = 0; i < addresses.length; i++) {
        empStatus.add(await _client.call(
            contract: _contract,
            function: _empContractStatus,
            params: [address[i]]));
      }
      empStatusList = empStatus;
    } else {
      empStatusList = [];
    }
  }

  getEmployees() async {
    initiateSetup();
    List employees = await _client
        .call(contract: _contract, function: _getEmployees, params: []);
    addresses = employees[0];

    isLoading = false;
    notifyListeners();
  }

  setEmployee(String _empAddr, int _latitude, int _longitude, int _max_radius,
      int _payAmount, int _reqAmount) async {
    initiateSetup();
    print('set employee called');
    print(EthereumAddress.fromHex(_empAddr));

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _setEmployee,
            parameters: [
              EthereumAddress.fromHex(_empAddr),
              BigInt.from(_latitude),
              BigInt.from(_longitude),
              BigInt.from(_max_radius),
              BigInt.from(_payAmount),
              BigInt.from(_reqAmount)
            ]));
    getEmployees();
    isLoading = false;
    notifyListeners();
  }
}
