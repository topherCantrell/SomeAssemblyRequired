.PROCESSOR 6502

main:
  A = #'.'
  CALL IsValidHexKey
  A = #'0'
  CALL IsValidHexKey
  A = #'9'
  CALL IsValidHexKey
  A = #'A'
  CALL IsValidHexKey
  A = #'a'
  CALL IsValidHexKey
  GOTO main

;---------------------
IsValidHexKey:

  A to #'0'
  GO(<) NoGood
  A to #'9'+1
  GO(<) Good

  A to #'A'
  GO(<) NoGood
  A to #'F'+1
  GO(<) Good

  A to #'a'
  GO(<) NoGood
  A to #'f'+1
  GO(<) GoodLower

NoGood:
  A = #0
Good:
  RETURN

GoodLower:
  A = A - #('a'-'A')
  RETURN
