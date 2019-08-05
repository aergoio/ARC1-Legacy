import "aergoio/ARC1Token"

function constructor()
  _init("mintableToken", "MINT", 18)
  _mint(system.getSender(), bignum.number(500000000) * bignum.number("1000000000000000000"))
end

-- Mint new tokens at a contract creator's account
-- @type    call
-- @param   value  (ubig) an amount of token to mint
-- @event   transfer("1111111111111111111111111111111111111111111111111111", <creator's address>, value)
function mint(value)
  assert(system.getSender() == system.getCreator(), "only contract owner can mint")

  _mint(system.getSender(), value)
end

-- Burn tx sender's tokens
-- @type    call
-- @param   value  (ubig) an amount of token to burn
-- @event   transfer(<sender's address>, "1111111111111111111111111111111111111111111111111111", value)
function burn(value)
  _burn(system.getSender(), value)
end

-- Burn given from account's tokens
-- @type    call
-- @param   from  (address) a target address
-- @param   value (ubig) an amount of token to burn
-- @event   transfer(from, "1111111111111111111111111111111111111111111111111111", value)
function burnFrom(from, value)
  assert(isApprovedForAll(from, system.getSender()), "caller is not approved for holder")

  _burn(from, value)
end

abi.register(mint, burn, burnFrom)
