<h1 align="center">Refund by location smart contract</h1>
<div>
<img src="https://img.shields.io/badge/OS-linux%20%7C%20windows-blue??style=flat&logo=Linux&logoColor=b0c0c0&labelColor=363D44" alt="Operating systems"/>
<a href="https://github.com/Abel-Blue/refund-smart-contract/network/members"><img src="https://img.shields.io/github/forks/Abel-Blue/refund-smart-contract" alt="Forks Badge"/></a>
<a href="https://github.com/Abel-Blue/refund-smart-contract/pulls"><img src="https://img.shields.io/github/issues-pr/Abel-Blue/refund-smart-contract" alt="Pull Requests Badge"/></a>
<a href="https://github.com/Abel-Blue/refund-smart-contract/issues"><img src="https://img.shields.io/github/issues/Abel-Blue/refund-smart-contract" alt="Issues Badge"/></a>
<a href="https://github.com/Abel-Blue/refund-smart-contract/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/Abel-Blue/refund-smart-contract?color=2b9348"></a>
<a href="https://github.com/Abel-Blue/refund-smart-contract/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Abel-Blue/refund-smart-contract?color=2b9348" alt="License Badge"/></a>
</div>

</br>

![ethr](https://phantom-marca.unidadeditorial.es/59644477365716512f144f6f85f31af9/resize/1320/f/jpg/assets/multimedia/imagenes/2022/03/20/16477692211339.jpg)

<hr>

## Introduction

> <p>A program or application stored and run on the blockchain network is referred to as a decentralized application (dApp).</p>

 <p>The refund by location smart contract is aimed to be used when one party, for example, an employer, agrees to pay another party, for example, an employee, for being present in a certain geographic area for a certain duration. The employee's phone sends its GPS location to a smart contract at a certain interval. Based on the pre-agreed contract codified in an Ethereum smart contract, a cryptocurrency payment is executed when all the agreed conditions are met.

If at any point, the GPS sensor indicates that an employee is outside the range of the agreed GPS area, the contract state will be updated to indicate that it is out of compliance.

Ethereum has two types of accounts:

</p>

> 1. Externally Owned Accounts (EOA): These accounts are used by nodes to send or receive Ether. These accounts are associated with a private key.
> 2. Contract Accounts: These accounts hold and execute smart contract code. Unlike EOAs, contract accounts do not have a private key.

## Setting up MetaMask Wallet

To use MetaMask wallet:

- Install MetaMask extension on the desired web browser.
- Setup Account and Test network (in this project, Rinkeby test network is used)
- Load funds into Rinkeby account address by using crypto faucets.

![ethr](images/load.png)

> Then Deploying Smart Contract via Remix IDE. After compiling and deploying the Smart Contract by approving transactions in MetaMask wallet, it will show up on our wallet activity status that the contract is deployed successfully.

![ethr](images/deployedtrans.png)

## Infura

<p>The mobile application (or dApp) is linked to the smart contract using the Infura API. It serves as a Gateway and manages all requests made to the smart contract. An account must must be created in order to access the Infura API. To view the statistics of requests made to a smart contract, a project must first be built for this application.</p>

![ethr](images/infura.png)

## Flutter Mobile Application

<p>After installing the application on the mobile device of the employee, the user interface will look as shown below.</p>

![ethr](images/ola.gif)

# <a name='Flutter App Installation guide'></a>Flutter App Installation guide

### <a name='conda'></a>IOS

```bash
git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter build ios --no-sound-null-safety
flutter install-local --platform ios
```

### <a name='conda'></a>Android

```bash
git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter build apk --no-sound-null-safety
flutter install
```

### <a name='conda'></a>Run flutter App on debug mode

- First connect your device using USB cable.

```bash
git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter run --no-sound-null-safety
```

<hr>

# <a name='license'></a>License

[License](https://github.com/Abel-Blue/refund-smart-contract/blob/main/Licence)
