from brownie import accounts, network, OrNoNFT, SVGLib
from web3 import Web3
from helpers import token_uri_to_svg

def test_tokenuri_after_flip():
    account = accounts[0]
    SVGLib.deploy({'from': account})
    contract = OrNoNFT.deploy({'from': account})
    
    contract.mint("WHATOO", True, {'from': account})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'YES &#160;&#160;#&#160;&#160;' in svg_text
    assert '0 FLIPS' in svg_text

    """First flip """
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.01, 'ether')})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'NO &#160;&#160;#&#160;&#160;' in svg_text
    assert '1 FLIPS' in svg_text

    """Second flip """
    contract.flip(0, {'from': account, 'value': Web3.toWei(0.01, 'ether')})

    token_uri = contract.tokenURI(0)
    svg_text = token_uri_to_svg(token_uri=token_uri)

    assert 'WHATOO' in svg_text
    assert 'YES &#160;&#160;#&#160;&#160;' in svg_text
    assert '2 FLIPS' in svg_text
