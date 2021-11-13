import os
from brownie import OrNoNFT, SVGLibReal, accounts, network, config

def main():
    account = accounts[0]
    # account = accounts.add(config['wallets']['from_key'])
    SVGLibReal.deploy({"from": account})
    contract = OrNoNFT.deploy(SVGLibReal[0].address, {'from': account})
    contract = OrNoNFT[0]
    contract.mint("USDT", True, {'from': account})
    num = contract.tokenCounter()
    
    print("-"*100)
    uriv = contract.tokenURI(num - 1)
    print(uriv)
    print("-"*100)
