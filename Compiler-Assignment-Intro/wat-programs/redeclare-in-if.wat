(module
 (func
  $main
  (result i32)
  (local $ix0$0 i32)
  (local $bx0$1 i32)
  (i32.const 32)
  (local.set $ix0$0)
  (i32.const 0)
  (i32.const 0)
  (i32.const 0)
  i32.sub
  i32.lt_s
  (if (then (i32.const 1) (local.set $bx0$1)) (else (i32.const 0) (local.set $bx0$1)))
  (local.get $ix0$0)
  return
 )
 (export "main" (func $main))
)