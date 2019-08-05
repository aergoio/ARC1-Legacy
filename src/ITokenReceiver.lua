-- The ARC1 smart contract calls this function on the recipient after a 'transfer'
-- @param   operator    (address) a address which called token 'transfer' function
-- @param   from        (address) a sender's address
-- @param   value       (ubig) an amount of token to send
-- @param   ...         addtional data, by-passed from 'transfer' arguments
-- @type    call
function tokensReceived(operator, from, value, ...)
  -- add & implement this function to a token handler contract
end
