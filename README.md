# Refund by Location Smart Contract Dapps-GPS
Ethereum is a decentralized, open-source blockchain with smart contract functionality. Ether is the native cryptocurrency of the platform. Among cryptocurrencies, Ether is second only to Bitcoin in market capitalization. Ethereum was conceived in 2013 by programmer Vitalik Buterin.

![Ethereum](https://github.com/niyotham/Refund-by-Location-Smart-Contract/blob/main/ethereum.png)

## Introduction

The refund by location smart contract is aimed to be used when one party, for example an employer, agrees to pay another party, for example an employee, for being present in a certain geographic area for a certain duration. The employee’s phone sends its GPS location to a smart contract at a certain interval. Based on the pre-agreed contract codified in an Ethereum smart contract, a cryptocurrency payment is executed when all the agreed conditions are met.  

If, at any point, the GPS sensor indicates that an employee is outside the range of the agreed GPS area, the contract state will be updated to indicate that it is out of compliance.  

## objective

produce an Ethereum based dApp thathas both the smart contract tested and deployed in a testnetand
produce an Ethereum based dApp that has both the smart contract tested and deployed in a testnet and a front end that will allow monitoring of the status.

## Plan
* Steps to do the project:
- [ ] Developing smart contract.
    - [x] Use solidity programming
    - [ ]  Testing and deploying the contract on ethereum blockchain
- [ ]  Building frontend web dApp
    - [x]  Designing the user interface
    - [ ]  Implementing  it with Flutter
- [ ]  Connecting the frontend and smart contract backend
## Implementation
- [x ] Frontend  with Flutter
- [x] Backendwith solidity for the smart contract and hardhat frame work is used
### Setting up MetaMask Wallet
To use MetaMask wallet:

- Install MetaMask extension on the desired web browser.
- Setup Account and Test network (in this project, Rinkeby test network is used)
- Load funds into Rinkeby account address by using crypto faucets.

![alt text](https://github.com/niyotham/Refund-by-Location-Smart-Contract/blob/main/flutterdapp/images/Screen%20Shot%202022-10-30%20at%2010.18.00%20AM.png)

> Then Deploying Smart Contract via Remix IDE. After compiling and deploying the Smart Contract by approving transactions in MetaMask wallet, it will show up on our wallet activity status that the contract is deployed successfully.

![alt text](https://github.com/niyotham/Refund-by-Location-Smart-Contract/blob/main/flutterdapp/images/Screen%20Shot%202022-10-30%20at%2010.18.10%20AM.png)

### Infura
> The mobile application (or dApp) is linked to the smart contract using the Infura API. It serves as a Gateway and manages all requests made to the smart contract. An account must must be created in order to access the Infura API. To view the statistics of requests made to a smart contract, a project must first be built for this application.
## Flutter Mobile Application
After installing the application on the mobile device of the employee, the user interface will look as shown below.
![alt text](https://github.com/niyotham/Refund-by-Location-Smart-Contract/blob/main/flutterdapp/images/Screen%20Shot%202022-10-30%20at%208.45.28%20PM.png)
![alt text](https://github.com/niyotham/Refund-by-Location-Smart-Contract/blob/main/flutterdapp/images/Screen%20Shot%202022-10-30%20at%2011.08.06%20PM.png) 


## Installation
* To clone the repository use the below link:
```
https://github.com/niyotham/Refund-by-Location-Smart-Contract
``` 
## To run the repository first run the following:


## Flutter App Installation guide
### IOS
``` git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter build ios --no-sound-null-safety
flutter install-local --platform ios

``` 
### Android
```
git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter build apk --no-sound-null-safety
flutter install
``` 
### Run flutter App on debug mode
First connect your device using USB cable.
```
git clone https://github.com/Abel-Blue/refund-smart-contract.git
cd refund-smart-contract
cd flutterdapp
flutter pub get
flutter run --no-sound-null-safety 
```
