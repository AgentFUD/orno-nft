import pytest
from brownie import accounts, OrNoNFT, SVGLib

@pytest.fixture(scope='session')
def accountz():
    return accounts

@pytest.fixture(scope='module')
def contract(accountz):
    owner = accountz[0]
    SVGLib.deploy({'from': owner})
    contract = OrNoNFT.deploy({'from': owner})
    return contract

