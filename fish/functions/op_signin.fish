function op_signin -d "Signin to my 1Password account" --argument account
  eval (op signin $account)
end