from brownie import accounts, network, OrNoNFT
from web3 import Web3
import brownie


def test_an_nft_can_be_locked_by_owner():
    owner = accounts[0]
    contract = OrNoNFT.deploy({'from': owner})
    contract.mint("First", True, {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == True

def test_an_nft_cant_be_locked_by_non_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = OrNoNFT.deploy({'from': owner})
    contract.mint("First", True, {'from': owner})

    with brownie.reverts("OrNoNFT: Lock error, not owner or insufficient funds"):
        contract.lock(0, {'from': flipper1, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == False

def test_locked_nft_can_be_locked_again_by_owner():
    owner = accounts[0]
    contract = OrNoNFT.deploy({'from': owner})
    contract.mint("First", True, {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == True

    contract.lock(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == True

def test_locked_nft_cant_be_locked_by_non_owner():
    owner = accounts[0]
    flipper1 = accounts[1]
    contract = OrNoNFT.deploy({'from': owner})
    contract.mint("First", False, {'from': owner})

    contract.lock(0, {'from': owner, 'value': Web3.toWei(0.01, 'ether')})
    assert contract.lockedTokens(0) == True
    assert contract.ownerOf(0) == owner

    with brownie.reverts("OrNoNFT: Lock error, not owner or insufficient funds"):
        contract.lock(0, {'from': flipper1, 'value': Web3.toWei(0.009, 'ether')})
    assert contract.lockedTokens(0) == True
    assert contract.ownerOf(0) == owner
