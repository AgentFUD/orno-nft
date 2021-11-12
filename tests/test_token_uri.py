from brownie import network, OrNoNFT, SVGLib
from web3 import Web3
import pytest
from helpers import token_uri_to_svg


def test_tokenuri_after_mint_is_correct_what_true(accounts, contract):
    account = accounts[0]
    
    contract.mint("WHAT", True, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHAT' in svg_text
    assert 'YES &#160;&#160;#&#160;&#160;' in svg_text

def test_tokenuri_after_mint_is_correct_tesla_false(accounts, contract):
    account = accounts[0]
    
    contract.mint("TESLA", False, {'from': account})

    token_uri = contract.tokenURI(1)
    svg_text = token_uri_to_svg(token_uri=token_uri)
    
    assert 'TESLA' in svg_text
    assert 'NO &#160;&#160;#&#160;&#160;' in svg_text

def test_tokenuri_after_mint_is_correct_bitcoin_true(accounts, contract):
    account = accounts[0]
    
    contract.mint("Bitcoin", True, {'from': account})

    token_uri = contract.tokenURI(2)
    svg_text = token_uri_to_svg(token_uri=token_uri)
    
    assert 'Bitcoin' in svg_text
    assert 'YES &#160;&#160;#&#160;&#160;' in svg_text
