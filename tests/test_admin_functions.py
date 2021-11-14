import brownie


def test_owner_can_set_flip_price(accounts, web3, contract):
    owner = accounts[0]
    contract.setFlipPrice(web3.toWei(0.02, "ether"), {"from": owner})
    assert contract.flipPrice() == web3.toWei(0.02, "ether")


def test_non_owner_cant_set_flip_price(accounts, web3, contract):
    owner = accounts[0]
    account1 = accounts[1]
    with brownie.reverts("Ownable: caller is not the owner"):
        contract.setFlipPrice(web3.toWei(0.02, "ether"), {"from": account1})
