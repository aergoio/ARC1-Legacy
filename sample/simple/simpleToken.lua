import "aergoio/ARC1Token"

function constructor()
 _init("simpleToken", "SYM", 18)
 -- mint initial supply to a contract owner 
 _mint(system.getSender(), bignum.number(500000000) * bignum.number("1000000000000000000"))
end
