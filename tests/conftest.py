import pytest
from brownie import accounts, OrNoNFT, OrNoSVGLibReal, OrNoBadgeNFT, OrNoBadgeSVGLibReal


@pytest.fixture(scope="module")
def contract():
    owner = accounts[0]
    svgLib = OrNoSVGLibReal.deploy({"from": owner})
    orno = OrNoNFT.deploy({"from": owner})
    badgeSVGLib = OrNoBadgeSVGLibReal.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    
    badge.setSVGLibAddress(badgeSVGLib.address)
    orno.setSVGLibAddress(svgLib.address)
    orno.setBadgeAddress(badge.address)

    return orno
