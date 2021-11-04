from brownie import accounts, network, TrueFalseNFT
from web3 import Web3
import base64
import json

def test_tokenuri_after_mint_is_correct_what_true():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    
    contract.mint("WHAT", True, {'from': account})

    token_uri = contract.tokenURI(0)
    x = base64.b64decode(token_uri[29:])
    jsonobj = json.loads(x)
    img = jsonobj['image'][26:]
    svg_text = str(base64.b64decode(img))
    
    assert 'WHAT' in svg_text
    assert 'TRUE' in svg_text


def test_tokenuri_after_mint_is_correct_tesla_false():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    
    contract.mint("TESLA", False, {'from': account})

    token_uri = contract.tokenURI(0)
    x = base64.b64decode(token_uri[29:])
    jsonobj = json.loads(x)
    img = jsonobj['image'][26:]
    svg_text = str(base64.b64decode(img))
    
    assert 'TESLA' in svg_text
    assert 'FALSE' in svg_text

def test_tokenuri_after_mint_is_correct_bitcoin_true():
    account = accounts[0]
    contract = TrueFalseNFT.deploy({'from': account})
    
    contract.mint("Bitcoin", True, {'from': account})

    token_uri = contract.tokenURI(0)
    x = base64.b64decode(token_uri[29:])
    jsonobj = json.loads(x)
    img = jsonobj['image'][26:]
    svg_text = str(base64.b64decode(img))
    
    assert 'Bitcoin' in svg_text
    assert 'TRUE' in svg_text
