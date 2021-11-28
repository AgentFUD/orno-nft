def test_withdrawal(accounts, web3, contract):
    account = accounts[0]
    contract.mint("WHAT", True, {"from": account})

    account_balance = account.balance()

    contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})
    contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})
    contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})

    assert contract.balance() == web3.toWei(0.09, "ether")

    contract.withdraw({"from": account})

    assert contract.balance() == web3.toWei(0, "ether")

    assert account_balance == account.balance()
