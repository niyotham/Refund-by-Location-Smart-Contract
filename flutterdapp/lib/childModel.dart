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
  late List empStatus;
  late String balance;
  late ContractFunction _readCoordinates;
  late ContractFunction _sendCoordinates;
  late ContractFunction _updateCompCountStatus;
  late ContractFunction _empContractStatus;
  childModel() {
    initiateSetup();
  }
  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
        "https://goerli.infura.io/ws/v3/d6525bf95d3746c485fbcfb80bea5bf6",
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
    _sendCoordinates = _contract.function("sendCoordinates");
    _updateCompCountStatus = _contract.function('updateCompCountStatus');
    _empContractStatus = _contract.function('empContractStatus');
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

  getBalance(String address) async {
    EtherAmount etherAmount =
        await _client.getBalance(EthereumAddress.fromHex(address));
    balance = '${etherAmount.getValueInUnit(EtherUnit.ether)} Eth';
  }

  getContractStatus(String address) async {
    initiateSetup();

    empStatus = await _client.call(
        contract: _contract,
        function: _empContractStatus,
        params: [EthereumAddress.fromHex(address)]);
    print(empStatus);
  }

  updateCompCountStatus(String latitude, String longitude) async {
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _updateCompCountStatus,
            parameters: [
              BigInt.from(int.parse(latitude)),
              BigInt.from(int.parse(longitude))
            ]));
    print('set employee executed');
    isLoading = false;
    notifyListeners();
  }
}
