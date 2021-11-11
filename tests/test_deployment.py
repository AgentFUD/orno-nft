from brownie import accounts, network, OrNoNFT, SVGLib
from web3 import Web3

def test_deploy_contract():
    account = accounts[0]
    svgLib = SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})
    assert len(contract.address) == 42

def test_basic_properties():
    account = accounts[0]
    # svgLib = SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})

    contract.mint("WHAT", False, {'from': account})
    assert contract.tokenStates(0) == False

    contract.mint("WHAT", True, {'from': account})
    assert contract.tokenStates(1) == True

    assert contract.flips(0) == 0
