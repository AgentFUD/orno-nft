import os
from brownie import OrNoNFT, accounts, network, config

def main():
    account = accounts[0]
    # account = accounts.add(config['wallets']['from_key'])
    contract = OrNoNFT.deploy({'from': account})
    contract.mint("USDT", True, {'from': account})
    num = contract.tokenCounter()
    
    print("-"*100)
    uriv = contract.tokenURI(num - 1)
    print(uriv)
    print("-"*100)
