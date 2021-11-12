import brownie
from web3 import Web3
import pytest

def test_owner_can_set_flip_price(accounts, contract):
    owner = accounts[0]
    contract.setFlipPrice(Web3.toWei(0.02, 'ether'), {'from': owner})
    assert contract.flipPrice() == Web3.toWei(0.02, 'ether')

def test_non_owner_cant_set_flip_price(accounts, contract):
    owner = accounts[0]
    account1 = accounts[1]
    with brownie.reverts('Ownable: caller is not the owner'):
         contract.setFlipPrice(Web3.toWei(0.02, 'ether'), {'from': account1})

def test_owner_can_set_lock_price(accounts, contract):
    owner = accounts[0]
    contract.setLockPrice(Web3.toWei(0.02, 'ether'), {'from': owner})

    assert contract.lockPrice() == Web3.toWei(0.02, 'ether')

def test_non_owner_cant_set_lock_price(accounts, contract):
    owner = accounts[0]
    account1 = accounts[1]
    with brownie.reverts('Ownable: caller is not the owner'):
         contract.setLockPrice(Web3.toWei(0.02, 'ether'), {'from': account1})
