import os
from brownie import OrNoBadgeNFT, OrNoBadgeSVGLib, accounts
# from tests.helpers import token_uri_to_svg


def main():
    owner = accounts[0]
    badgeSVGLib = OrNoBadgeSVGLib.deploy({"from": owner})
    badge = OrNoBadgeNFT.deploy({"from": owner})
    badge.setSVGLibAddress(badgeSVGLib.address)
    # levels = [10, 25, 50, 75, 100, 150, 200, 250, 350, 450, 550, 750, 950, 1250, 1600, 1950, 2400, 2850, 3350, 3850, 4500]
    levels = [10, 25, 2222, 3333, 4500]
    for i, level in enumerate(levels):
        badge.mint("QQRICA", level, owner, {"from": owner})
        tokenUri = badge.tokenURI(i)
        print(tokenUri)
