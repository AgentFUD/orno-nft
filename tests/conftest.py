import pytest
from brownie import accounts, OrNoNFT, SVGLibReal


@pytest.fixture(scope="module")
def contract():
    owner = accounts[0]
    SVGLibReal.deploy({"from": owner})
    contract = OrNoNFT.deploy(SVGLibReal[0].address, {"from": owner})
    return contract
