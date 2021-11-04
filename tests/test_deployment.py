from brownie import accounts, network, TrueFalseNFT
from web3 import Web3

def test_deploy_contract():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    assert len(contract.address) == 42

def test_basic_properties():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    contract.mint("WHAT", "YES", {'from': account})
    
    assert contract.tokenStates(0) == True
    assert contract.tokenStates(1) == False
    assert contract.flips(0) == 0