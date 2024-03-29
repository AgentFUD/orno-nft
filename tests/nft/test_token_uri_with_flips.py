from helpers import token_uri_to_svg


def test_tokenuri_after_flip(accounts, web3, orno_nft_contract):
    account = accounts[0]

    orno_nft_contract.mint("WHATOO", True, {"from": account})

    token_uri = orno_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "WHATOO" in svg_text
    assert "YES &#160;&#160;#&#160;&#160;" in svg_text
    assert "0 FLIPS" in svg_text

    """First flip """
    orno_nft_contract.flip(0, {"from": account, "value": web3.toWei(0.01, "ether")})

    token_uri = orno_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "WHATOO" in svg_text
    assert "NO &#160;&#160;#&#160;&#160;" in svg_text
    assert "1 FLIPS" in svg_text

    """Second flip """
    orno_nft_contract.flip(0, {"from": account, "value": web3.toWei(0.01, "ether")})

    token_uri = orno_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "WHATOO" in svg_text
    assert "YES &#160;&#160;#&#160;&#160;" in svg_text
    assert "2 FLIPS" in svg_text
