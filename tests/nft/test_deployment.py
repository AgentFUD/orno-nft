def test_deploy_contract(orno_nft_contract):
    assert len(orno_nft_contract.address) == 42


def test_basic_properties(accounts, orno_nft_contract):
    account = accounts[0]
    orno_nft_contract.mint("WHAT", False, {"from": account})
    assert orno_nft_contract.tokenStates(0) == False

    orno_nft_contract.mint("WHAT", True, {"from": account})
    assert orno_nft_contract.tokenStates(1) == True

    assert orno_nft_contract.flips(0) == 0
