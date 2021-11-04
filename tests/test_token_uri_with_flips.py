from brownie import accounts, network, TrueFalseNFT
from web3 import Web3
from helpers import token_uri_to_svg

def test_tokenuri_after_flip():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    
    contract.mint("WHATOO", True, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'TRUE' in svg_text
    assert 'flips: 0' in svg_text

    """First flip """
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.01, 'ether')})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'FALSE' in svg_text
    assert 'flips: 1' in svg_text

    """Second flip """
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.01, 'ether')})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'TRUE' in svg_text
    assert 'flips: 2' in svg_text
