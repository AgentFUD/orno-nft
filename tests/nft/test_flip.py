import brownie


def test_owner_can_flip_state_multiple_times(accounts, web3, orno_nft_contract):
    owner = accounts[0]
    orno_nft_contract.mint("First", True)

    assert orno_nft_contract.tokenStates(0) == True

    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(0) == False

    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(0) == True

    orno_nft_contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(0) == False


def test_non_owners_can_flip_state_multiple_times(accounts, web3, orno_nft_contract):
    owner = accounts[0]
    account1 = accounts[1]
    account2 = accounts[2]

    orno_nft_contract.mint("Second", True)

    assert orno_nft_contract.tokenStates(1) == True

    orno_nft_contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(1) == False

    orno_nft_contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(1) == True

    orno_nft_contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(1) == False

    orno_nft_contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(1) == True

    orno_nft_contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(1) == False

    assert orno_nft_contract.flips(1) == 5


def test_total_flips_calculated_correctly(accounts, web3, orno_nft_contract):
    owner = accounts[0]
    account1 = accounts[1]
    account2 = accounts[2]

    orno_nft_contract.mint("Third", True)
    orno_nft_contract.mint("Fourth", True)
    assert orno_nft_contract.totalFlips() == 8

    orno_nft_contract.flip(0, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.totalFlips() == 9

    orno_nft_contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.totalFlips() == 10

    orno_nft_contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.totalFlips() == 11

    orno_nft_contract.flip(0, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.totalFlips() == 12

    orno_nft_contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.totalFlips() == 13


def test_flip_cannot_be_sent_with_less_than_required_ethers(
    accounts, web3, orno_nft_contract
):
    account = accounts[0]
    orno_nft_contract.mint("Fifth", True)
    with brownie.reverts("OrNoNFT: Flip error, unsufficient funds"):
        orno_nft_contract.flip(
            4, {"from": account, "value": web3.toWei(0.009, "ether")}
        )


def test_flip_can_be_done_by_owner(accounts, web3, orno_nft_contract):
    owner = accounts[0]
    orno_nft_contract.mint("Sixth", True, {"from": owner})
    orno_nft_contract.flip(5, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert orno_nft_contract.tokenStates(5) == False
