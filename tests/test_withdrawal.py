def test_withdrawal(accounts, web3, orno_nft_contract):
    account = accounts[0]
    orno_nft_contract.mint("WHAT", True, {"from": account})

    account_balance = account.balance()

    orno_nft_contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})
    orno_nft_contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})
    orno_nft_contract.flip(0, {"from": account, "value": web3.toWei(0.03, "ether")})

    assert orno_nft_contract.balance() == web3.toWei(0.09, "ether")

    orno_nft_contract.withdraw({"from": account})

    assert orno_nft_contract.balance() == web3.toWei(0, "ether")

    assert account_balance == account.balance()
