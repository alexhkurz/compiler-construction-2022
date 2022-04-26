(module
 (func 
  $main
  (result i32)
  (local $ii$0 i32)
  (i32.const 0)
  (local.set $ii$0)
  (block
   (loop
    (local.get $ii$0)
    (local.get $ii$0)
    (i32.const 1)
    i32.add
    (local.set $ii$0)
    (i32.const 5)
    i32.lt_s
    i32.eqz
    (br_if 1)
    (br 0)
   )
  )
  (local.get $ii$0)
  return
 )
 (export "main" (func $main))
)


