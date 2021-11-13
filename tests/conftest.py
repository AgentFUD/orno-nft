import pytest
from brownie import accounts, OrNoNFT, SVGLibReal

@pytest.fixture(scope='session')
def accountz():
    return accounts

@pytest.fixture(scope='module')
def contract(accountz):
    owner = accountz[0]
    SVGLibReal.deploy({'from': owner})
    contract = OrNoNFT.deploy(SVGLibReal[0].address, {'from': owner})
    return contract

