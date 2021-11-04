from brownie import accounts, network, TrueFalseNFT
import brownie
from web3 import Web3

def test_owner_can_set_flip_price():
    owner = accounts[0]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.setFlipPrice(Web3.toWei(0.02, 'ether'), {'from': owner})

    assert contract.flipPrice() == Web3.toWei(0.02, 'ether')

def test_non_owner_cant_set_flip_price():
    owner = accounts[0]
    account1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    with brownie.reverts('Ownable: caller is not the owner'):
         contract.setFlipPrice(Web3.toWei(0.02, 'ether'), {'from': account1})

def test_owner_can_set_lock_price():
    owner = accounts[0]
    contract = TrueFalseNFT.deploy({'from': owner})
    contract.setLockPrice(Web3.toWei(0.02, 'ether'), {'from': owner})

    assert contract.lockPrice() == Web3.toWei(0.02, 'ether')

def test_non_owner_cant_set_lock_price():
    owner = accounts[0]
    account1 = accounts[1]
    contract = TrueFalseNFT.deploy({'from': owner})
    with brownie.reverts('Ownable: caller is not the owner'):
         contract.setLockPrice(Web3.toWei(0.02, 'ether'), {'from': account1})
