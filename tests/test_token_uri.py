from brownie import accounts, network, OrNoNFT, SVGLib
from web3 import Web3
from helpers import token_uri_to_svg

def test_tokenuri_after_mint_is_correct_what_true():
    account = accounts[0]
    SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})
    
    contract.mint("WHAT", True, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHAT' in svg_text
    assert 'TRUE' in svg_text

def test_tokenuri_after_mint_is_correct_tesla_false():
    account = accounts[0]
    SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})
    
    contract.mint("TESLA", False, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)
    
    assert 'TESLA' in svg_text
    assert 'FALSE' in svg_text

def test_tokenuri_after_mint_is_correct_bitcoin_true():
    account = accounts[0]
    SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})
    
    contract.mint("Bitcoin", True, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)
    
    assert 'Bitcoin' in svg_text
    assert 'TRUE' in svg_text
