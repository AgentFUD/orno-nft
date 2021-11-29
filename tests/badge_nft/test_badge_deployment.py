def test_deploy_contract(orno_badge_nft_contract):
    assert len(orno_badge_nft_contract.address) == 42


def test_basic_properties(accounts, orno_badge_nft_contract):
    account = accounts[0]
    owner = accounts[1]

    orno_badge_nft_contract.mint("WHAT", 10, owner, {"from": account})
    assert orno_badge_nft_contract.ownerOf(0) == owner

    assert orno_badge_nft_contract.tokenURI(0) == "Yee"
