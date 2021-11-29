import pytest
from brownie import accounts, OrNoNFT, OrNoSVGLibReal, OrNoBadgeNFT, OrNoBadgeSVGLibReal


@pytest.fixture(scope="module")
def orno_nft_contract():
    owner = accounts[0]
    svgLib = OrNoSVGLibReal.deploy({"from": owner})
    orno = OrNoNFT.deploy({"from": owner})
    badgeSVGLib = OrNoBadgeSVGLibReal.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    badge.setSVGLibAddress(badgeSVGLib.address)
    badge.transferOwnership(orno.address)
    orno.setSVGLibAddress(svgLib.address)
    orno.setBadgeAddress(badge.address)

    return orno


@pytest.fixture(scope="module")
def orno_nft_contracts():
    owner = accounts[0]
    svgLib = OrNoSVGLibReal.deploy({"from": owner})
    orno = OrNoNFT.deploy({"from": owner})
    badgeSVGLib = OrNoBadgeSVGLibReal.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    badge.setSVGLibAddress(badgeSVGLib.address)
    badge.transferOwnership(orno.address)
    orno.setSVGLibAddress(svgLib.address)
    orno.setBadgeAddress(badge.address)

    return orno, badge


@pytest.fixture(scope="module")
def orno_badge_nft_contract():
    owner = accounts[0]
    badgeSVGLib = OrNoBadgeSVGLibReal.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    badge.setSVGLibAddress(badgeSVGLib.address)
    return badge
