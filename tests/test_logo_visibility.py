from helpers import token_uri_to_svg


def test_orno_logo_appears_after_mint(contract):
    contract.mint("HasLogo", True)

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "ORNO.IO" in svg_text


def test_after_10_flips_logo_disappears(accounts, web3, contract):
    account = accounts[0]
    contract.mint("HasNoLogo", True)
    token_uri = contract.tokenURI(0)
    for x in range(10):
        contract.flip(0, {"from": account, "value": web3.toWei(0.01, "ether")})

    token_uri = contract.tokenURI(0)

    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "ORNO.IO" not in svg_text
