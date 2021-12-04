import os
from brownie import OrNoNFT, OrNoSVGLib, accounts, network, config


def main():
    account = accounts[0]
    # account = accounts.add(config['wallets']['from_key'])
    svgLib = OrNoSVGLib.deploy({"from": account})
    contract = OrNoNFT.deploy({"from": account})
    contract.setSVGLibAddress(svgLib.address, {"from": account})
    # contract = OrNoNFT[0]
    contract.mint("OMG", True, {"from": account})
    num = contract.tokenCounter()

    print("-" * 100)
    uriv = contract.tokenURI(num - 1)
    print(uriv)
    print("-" * 100)
