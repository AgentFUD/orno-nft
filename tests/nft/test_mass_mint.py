
def test_basic_properties(accounts, orno_nft_contract):
    owner = accounts[0]
    
    texts = ["AAA", "BBB", "CCC", "DDE", "ASD", "AAA", "BBBZ", "CCCT", "DDED", "ASDD","AAA", "BBB", "CCC", "DDE", "ASD", "AAA", "BBBZ", "CCCT", "DDED", "ASDD"]
    statuses = [True, False, False, False, True, True, True, True, True, False, True, False, False, False, True, True, True, True, True, False]

    orno_nft_contract.mintMany(texts, statuses, {"from": owner})
    
    for x in range(len(texts)):
        assert orno_nft_contract.tokenStates(x) == statuses[x]
        assert orno_nft_contract.tokenTexts(x) == texts[x]
    
    assert orno_nft_contract.flips(0) == 0
