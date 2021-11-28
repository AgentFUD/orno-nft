def test_deploy_contract(orno_badge_nft_contract):
    assert len(orno_badge_nft_contract.address) == 42


def test_basic_properties(accounts, orno_badge_nft_contract):
    account = accounts[0]
    orno_badge_nft_contract.mint("WHAT", False, {"from": account})
    assert orno_badge_nft_contract.tokenStates(0) == False
