from brownie import network, OrNoNFT, SVGLib
from web3 import Web3
import brownie
import pytest


def test_an_nft_can_be_locked_by_owner(accounts, contract):
    owner = accounts[0]
    contract.mint("First", True, {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == True

def test_an_nft_cant_be_locked_by_non_owner(accounts, contract):
    owner = accounts[0]
    flipper1 = accounts[1]
    contract.mint("Second", True, {'from': owner})

    with brownie.reverts("OrNoNFT: Lock error, not owner or insufficient funds"):
        contract.lock(1, {'from': flipper1, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(1) == False

def test_locked_nft_can_be_locked_again_by_owner(accounts, contract):
    owner = accounts[0]
    contract.mint("Third", True, {'from': owner})

    contract.lock(2, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(2) == True

    contract.lock(2, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(2) == True

def test_locked_nft_cant_be_locked_by_non_owner(accounts, contract):
    owner = accounts[0]
    flipper1 = accounts[1]
    contract.mint("Fourth", False, {'from': owner})

    contract.lock(3, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(3) == True
    assert contract.ownerOf(3) == owner

    with brownie.reverts("OrNoNFT: Lock error, not owner or insufficient funds"):
        contract.lock(3, {'from': flipper1, 'value': Web3.toWei(0.009, 'ether')})
    assert contract.lockedTokens(3) == True
    assert contract.ownerOf(3) == owner
