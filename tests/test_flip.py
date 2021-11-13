import brownie


def test_owner_can_flip_state_multiple_times(accounts, web3, contract):
    owner = accounts[0]
    contract.mint("First", True)

    assert contract.tokenStates(0) == True

    contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(0) == False

    contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(0) == True

    contract.flip(0, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(0) == False


def test_non_owners_can_flip_state_multiple_times(accounts, web3, contract):
    owner = accounts[0]
    account1 = accounts[1]
    account2 = accounts[2]

    contract.mint("Second", True)

    assert contract.tokenStates(1) == True

    contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(1) == False

    contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(1) == True

    contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(1) == False

    contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(1) == True

    contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(1) == False

    assert contract.flips(1) == 5


def test_total_flips_calculated_correctly(accounts, web3, contract):
    owner = accounts[0]
    account1 = accounts[1]
    account2 = accounts[2]

    contract.mint("Third", True)
    contract.mint("Fourth", True)
    assert contract.totalFlips() == 8

    contract.flip(0, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.totalFlips() == 9

    contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert contract.totalFlips() == 10

    contract.flip(1, {"from": account2, "value": web3.toWei(0.01, "ether")})
    assert contract.totalFlips() == 11

    contract.flip(0, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.totalFlips() == 12

    contract.flip(1, {"from": account1, "value": web3.toWei(0.01, "ether")})
    assert contract.totalFlips() == 13


def test_flip_cannot_be_sent_with_less_than_required_ethers(accounts, web3, contract):
    account = accounts[0]
    contract.mint("Fifth", True)
    with brownie.reverts("OrNoNFT: Flip error, unsufficient funds"):
        contract.flip(4, {"from": account, "value": web3.toWei(0.009, "ether")})


def test_flip_can_be_done_by_owner(accounts, web3, contract):
    owner = accounts[0]
    contract.mint("Sixth", True, {"from": owner})
    contract.flip(5, {"from": owner, "value": web3.toWei(0.01, "ether")})
    assert contract.tokenStates(5) == False
