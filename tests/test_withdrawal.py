from brownie import accounts, network, OrNoNFT, SVGLib
from web3 import Web3

def test_withdrawal(accounts, contract):
    account = accounts[0]
    contract.mint("WHAT", True, {'from': account})
    
    account_balance = account.balance()

    contract.flip(0, {'from': account, 'value': Web3.toWei(0.03, 'ether')})
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.03, 'ether')})
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.03, 'ether')})

    assert contract.balance() == Web3.toWei(0.09, 'ether')

    contract.withdraw({'from': account})

    assert contract.balance() == Web3.toWei(0, 'ether')

    assert account_balance > account.balance()
    assert account_balance * 0.99 < account.balance()
