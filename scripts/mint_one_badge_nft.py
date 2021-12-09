import os
from brownie import OrNoBadgeNFT, OrNoBadgeSVGLib, accounts
# from tests.helpers import token_uri_to_svg

def main():
    owner = accounts[0]
    badgeSVGLib = OrNoBadgeSVGLib.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    badge.setSVGLibAddress(badgeSVGLib.address)
    badge.mint("QQRICA", 10, owner, {"from": owner})
    tokenUri = badge.tokenURI(0)
    print(tokenUri)
