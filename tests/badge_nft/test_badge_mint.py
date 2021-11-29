from helpers import token_uri_to_svg


def test_badge_mint_levels(accounts, orno_badge_nft_contract):
    owner = accounts[0]
    # levels = [10, 25, 50, 75, 100, 150, 200, 250, 350, 450, 550, 750, 950, 1250, 1600, 1950, 2400, 2850, 3350, 3850, 4500]
    levels = [10, 25, 641]
    for i, level in enumerate(levels):
        orno_badge_nft_contract.mint("ORYES", level, owner, {"from": owner})
        tokenUri = orno_badge_nft_contract.tokenURI(i)
        svg = token_uri_to_svg(tokenUri)
        assert "ORYES" in svg
        assert "orNo LVL #" + str(level) in svg
        print(f"ORYES and orNo LVL #{level} found!")
