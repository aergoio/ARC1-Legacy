# Aergo Standard Token Contract, ARC-1 (Legacy)

This repository contains the first steps in the development of the ARC1 standard

It is no longer maintained

For the updated version of the ARC1 standard, check here: https://github.com/aergoio/ARC1


## Abstract

ARC-1 is a technical standard used for smart contracts on the Aergo blockchain for implementing tokens.

Compared to the widely known ERC-20, the interface is somewhat different. The following points were improved. If the target to receive the token is a contract, check that the corresponding contract manages the token by checking for a predefined function (`tokenReceived`). This can prevent token loss. It is also possible to transfer tokens and perform contracts by calling a predefined function directly in one transaction.

After a single delegation of authority (`setApprovedForAll`) to a trusted contract, the contract will be able to manage my tokens. For example, if you approve tokens to a Distributed Exchange (Dex) contract, you can trade directly without having to deposit and withdraw your token before trading.


## Specification

### Token

Following is an interface contract declaring the required functions to meet the ARC-1 standard. Issuers can add functions like name(), symbol(), and burn() as needed.

``` lua
-- Get a total token supply.
-- @type    query
-- @return  (ubig) total supply of this token
function totalSupply() end

-- Get a balance of an owner.
-- @type    query
-- @param   owner  (address) a target address
-- @return  (ubig) balance of owner
function balanceOf(owner) end

-- Transfer sender's token to target 'to'
-- @type    call
-- @param   to      (address) a target address
-- @param   value   (ubig) an amount of token to send
-- @param   ...     addtional data, MUST be sent unaltered in call to 'tokensReceived' on 'to'
-- @event   transfer(from, to, value)
function transfer(to, value, ...) end

-- Get allowance from owner to spender
-- @type    query
-- @param   owner       (address) owner's address
-- @param   operator    (address) allowed address
-- @return  (bool) true/false
function isApprovedForAll(owner, operator) end

-- Allow operator to use all sender's token
-- @type    call
-- @param   operator  (address) a operator's address
-- @param   approved  (boolean) true/false
-- @event   approve(owner, operator, approved)
function setApprovalForAll(operator, approved) end

-- Transfer 'from's token to target 'to'.
-- Tx sender have to be approved to spend from 'from'
-- @type    call
-- @param   from    (address) a sender's address
-- @param   to      (address) a receiver's address
-- @param   value   (ubig) an amount of token to send
-- @param   ...     addtional data, MUST be sent unaltered in call to 'tokensReceived' on 'to'
-- @event   transfer(from, to, value)
function transferFrom(from, to, value, ...) end
```

### Hook

Contracts, that want to handle tokens, must implement the following functions to define how to handle the tokens they receive. If this function is not implemented, the token transfer will fail. Therefore, it is possible to prevent the token from being lost.

``` lua
-- The ARC1 smart contract calls this function on the recipient after a 'transfer'
-- @param   operator    (address) a address which called token 'transfer' function
-- @param   from        (address) a sender's address
-- @param   value       (ubig) an amount of token to send
-- @param   ...         addtional data, by-passed from 'transfer' arguments
-- @type    call
function tokensReceived(operator, from, value, ...) end
```
