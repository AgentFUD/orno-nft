def test_withdrawal(accounts, web3, orno_nft_contract):
    owner = accounts[0]

    payee1 = accounts[10]
    payee2 = accounts[11]

    orno_nft_contract.mint("WHAT", True, {"from": owner})


    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.1, "ether")})
    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.2, "ether")})
    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.3, "ether")})
    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.4, "ether")})

    assert orno_nft_contract.balance() == web3.toWei(1, "ether")

    payee1_balance_before_withdraw = payee1.balance()
    payee2_balance_before_withdraw = payee2.balance()
    contract_balance_before_withdraw = orno_nft_contract.balance()

    # Withdraw everything
    orno_nft_contract.withdraw({"from": owner})

    payee1_balance_after_withdraw = payee1.balance()
    payee2_balance_after_withdraw = payee2.balance()
    contract_balance_after_withdraw = orno_nft_contract.balance()

    assert contract_balance_after_withdraw == web3.toWei(0, "ether")

    # payee1 should have balance increased with 0.55 * contract balance
    assert abs(payee1_balance_after_withdraw - (payee1_balance_before_withdraw + 0.55 * contract_balance_before_withdraw)) < web3.toWei(0.00001, "ether")

    # payee2 should have balance increased with 0.45 * contract balance
    assert abs(payee2_balance_after_withdraw - (payee2_balance_before_withdraw + 0.45 * contract_balance_before_withdraw)) < web3.toWei(0.00001, "ether")