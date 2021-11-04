from brownie import accounts, network, TrueFalseNFT
import brownie
from web3 import Web3


def test_owner_can_flip_state_multiple_times():
    owner = accounts[0]
    
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", True)

    assert contract.tokenStates(0) == True

    contract.flip(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False

    contract.flip(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == True

    contract.flip(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False

def test_non_owners_can_flip_state_multiple_times():
    owner = accounts[0]
    account1 = accounts[1]
    account2 = accounts[2]
    
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", True)

    assert contract.tokenStates(0) == True

    contract.flip(0, {'from': account1, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False

    contract.flip(0, {'from': account2, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == True

    contract.flip(0, {'from': account2, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False

    contract.flip(0, {'from': account1, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == True

    contract.flip(0, {'from': account1, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False
    
    assert contract.flips(0) == 5

def test_flip_cannot_be_sent_with_less_than_required_ethers():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    contract.mint("First", True)
    with brownie.reverts("TrueFalseNFT: Flip error, unsufficient funds"):
         contract.flip(0, {'from': account, 'value': Web3.toWei(0.009, 'ether')})

def test_flip_can_be_done_by_owner():
    owner = accounts[0]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", True, {'from': owner})
    contract.flip(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.tokenStates(0) == False
