from brownie import accounts, network, TrueFalseNFT
from web3 import Web3
import brownie


def test_an_nft_can_be_locked_by_owner():
    owner = accounts[0]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

def test_an_nft_cant_be_locked_by_non_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    with brownie.reverts("TrueFalseNFT: Lock error, not owner or insufficient funds"):
        contract.lock(0, {'from': flipper1, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == False

def test_locked_nft_can_be_locked_again_by_owner():
    owner = accounts[0]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True

def test_locked_nft_cant_be_locked_by_non_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.mint("First", "YES", {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(1, 'ether')})
    assert contract.lockedTokens(0) == True
    assert contract.ownerOf(0) == owner

    with brownie.reverts("TrueFalseNFT: Lock error, not owner or insufficient funds"):
        contract.lock(0, {'from': flipper1, 'value': Web3.toWei(0.02, 'ether')})
    assert contract.lockedTokens(0) == True
    assert contract.ownerOf(0) == owner
