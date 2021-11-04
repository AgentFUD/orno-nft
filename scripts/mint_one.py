import os
from brownie import TrueFalseNFT, accounts, network, config

def main():
    account = accounts[0]
    # account = accounts.add(config['wallets']['from_key'])
    contract = TrueFalseNFT.deploy({'from': account})
    contract.mint("USDT", "NO!", {'from': account})
    num = contract.tokenCounter()
    
    print("-"*100)
    uriv = contract.tokenURI(num - 1)
    print(uriv)
    print("-"*100)
