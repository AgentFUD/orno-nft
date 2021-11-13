from web3 import Web3
import pytest

def test_deploy_contract(contract):
    assert len(contract.address) == 42

def test_basic_properties(accounts, contract):
    account = accounts[0]
    contract.mint("WHAT", False, {'from': account})
    assert contract.tokenStates(0) == False

    contract.mint("WHAT", True, {'from': account})
    assert contract.tokenStates(1) == True

    assert contract.flips(0) == 0
