from brownie import accounts, network, OrNoNFT, SVGLib
from web3 import Web3
import brownie
import pytest


def test_locked_nft_can_be_locked_twice(accounts, contract):
    owner = accounts[0]
    
    contract.mint("First", True, {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

def test_locked_nft_can_be_flipped_by_owner(accounts, contract):
    owner = accounts[0]
    flipper1 = accounts[1]
    contract.mint("Bullshit", False, {'from': owner})

    contract.lock(1, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.flip(1, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.tokenStates(1) == True

    contract.lock(1, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(1) == True

def test_locked_nft_can_not_be_flipped_by_non_owner(accounts, contract):
    owner = accounts[0]
    flipper1 = accounts[1]
    contract.mint("BTC is good", True, {'from': owner})

    with brownie.reverts("OrNoNFT: Lock error, not owner or insufficient funds"):
        contract.lock(2, {'from': flipper1, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(2) == False
