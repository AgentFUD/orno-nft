from helpers import token_uri_to_svg
import pytest

def test_orno_logo_appears_after_mint(accounts, orno_nft_contract):
    owner = accounts[0]
    orno_nft_contract.mint("HasLogo", True, {'from': owner})

    token_uri = orno_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "ORNO.IO" in svg_text


def test_after_10_flips_logo_disappears(accounts, web3, orno_nft_contracts):
    owner = accounts[0]
    orno_nft_contract = orno_nft_contracts[0]
    orno_badge_nft_contract = orno_nft_contracts[1]
    orno_nft_contract.mint("HasNoLogo", True, {'from': owner})
    orno_badge_nft_contract.setMinter(orno_nft_contract.address, {'from': owner})
    
    for x in range(10):
        orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})

    token_uri = orno_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)
    assert "ORNO.IO" not in svg_text

def test_after_10_flips_badge_is_minted(accounts, web3, orno_nft_contracts):
    owner = accounts[0]
    orno_nft_contract = orno_nft_contracts[0]
    orno_badge_nft_contract = orno_nft_contracts[1]
    orno_badge_nft_contract.setMinter(orno_nft_contract.address, {'from': owner})
    
    orno_nft_contract.mint("HasNoLogo", True)

    for x in range(10):
        orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})

    token_uri = orno_badge_nft_contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert "HasNoLogo" in svg_text
    assert "orNo LVL #10" in svg_text
