function constructor(tokenContractAddress)
  assert(tokenContractAddress ~= nil)
  system.setItem("tokenCtr", tokenContractAddress)
end

function default()
  -- send same amount of token to tx sender
  contract.call(system.getItem("tokenCtr"), "transfer", system.getSender(), system.getAmount(), "send token back")
end

-- ************************************************
-- This function is token receive hook
function tokensReceived(operator, from, value, success, ...)
  if success ~= true then
    error("contract is fail")
  end
  -- print memo
  for k, v in pairs({...}) do system.print("Arg#"..k.."="..tostring(v)) end

  -- send same amount of aergo to token sender
  contract.send(from, value)
end
-- ************************************************

function contractTransferFrom(to, value, ...)
  contract.call(system.getItem("tokenCtr"), "transferFrom", system.getSender(), to, value, ...)
end

function contractBurnFrom(value)
  contract.call(system.getItem("tokenCtr"), "burnFrom", system.getSender(), value)
end

abi.register(contractTransferFrom, contractBurnFrom, tokensReceived)
abi.payable(default)
