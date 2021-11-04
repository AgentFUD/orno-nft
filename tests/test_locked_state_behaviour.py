from brownie import accounts, network, TrueFalseNFT
from web3 import Web3
import brownie


def test_locked_nft_can_be_locked_twice():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

def test_locked_nft_can_be_flipped_by_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.flip(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.tokenStates(0) == False

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

def test_locked_nft_can_not_be_flipped_by_non_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    with brownie.reverts("TrueFalseNFT: Lock error, not owner or insufficient funds"):
        contract.lock(0, {'from': flipper1, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == False