import os
from brownie import TrueFalseNFT, accounts, network, config

def main():
    # account = accounts.add(config['wallets']['from_key'])
    account = accounts[0]
    if network.show_active() == 'development':
        publish_source = False
    else:
        publish_source = True if os.getenv("ETHERSCAN_TOKEN") else False
    TrueFalseNFT.deploy({"from": account}, publish_source=publish_source)
