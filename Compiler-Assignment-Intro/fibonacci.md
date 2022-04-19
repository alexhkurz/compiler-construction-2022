# Example: C++ to WAT

See also [wikipedia](https://en.wikipedia.org/wiki/WebAssembly#Code_representation) for another example.

## A C++ program compiled to Webassembly

We will compare line by line the C++ program

    int main () {
      int lo,hi,mx ;
      lo = 1 ;
      hi = lo ;
      mx = 5000000 ;
      printInt(lo) ;
      while (hi < mx) {
        printInt(hi) ;
        hi = lo + hi ;
        lo = hi - lo ;
      }
      return 0 ;
    
    }
    
and the compiled WAT program

    (module
     (import "env" "readInt" (func $readInt (result i32)))
     (import "env" "readDouble" (func $readDouble (result f64)))
     (import "env" "printInt" (func $printInt (param i32)))
     (import "env" "printDouble" (func $printDouble (param f64))    )
     (func
      $main
      (result i32)
      (local $ilo$0 i32)
      (local $ihi$0 i32)
      (local $imx$0 i32)
      (i32.const 1)
      (local.set $ilo$0)
      (local.get $ilo$0)
      (local.set $ihi$0)
      (i32.const 5000000)
      (local.set $imx$0)
      (local.get $ilo$0)
      (call $printInt)
      (block
       (loop
        (local.get $ihi$0)
        (local.get $imx$0)
        i32.lt_s
        i32.eqz
        (br_if 1)
        (local.get $ihi$0)
        (call $printInt)
        (local.get $ilo$0)
        (local.get $ihi$0)
        i32.add
        (local.set $ihi$0)
        (local.get $ihi$0)
        (local.get $ilo$0)
        i32.sub
        (local.set $ilo$0)
        (br 0)
       )
      )
      (i32.const 0)
      return
     )
     (export "main" (func $main))
    )

## Line by line comparison

|C++ | WAT |
|:---|:--- |
| | `(module`
||`(import "env" "readInt" (func $readInt (result i32)))`
||`(import "env" "readDouble" (func $readDouble (result f64)))`
||`(import "env" "printInt" (func $printInt (param i32)))`
|| `(import "env" "printDouble" (func $printDouble (param f64)))`
|`int main () {` |  `(func`
||  `$main`
||  `(result i32)`
|`int lo,hi,mx ;`|  `(local $ilo$0 i32)`
||      `(local $ihi$0 i32)`
||      `(local $imx$0 i32)`
|`lo = 1 ;`|`(i32.const 1)`
||`(local.set $ilo$0)`
|`hi = lo ;`|`(local.get $ilo$0)`
||`(local.set $ihi$0)`
|`mx = 5000000 ;`|`(i32.const 5000000)`
||`(local.set $imx$0)`
|`printInt(lo) ;`|`(local.get $ilo$0)`
||`(call $printInt)`
|`while (hi < mx) {`|`(block`
||`(loop`
||`(local.get $ihi$0)`
||`(local.get $imx$0)`
||`i32.lt_s`
||`i32.eqz`
||`(br_if 1)`
|`printInt(hi) ;`|`(local.get $ihi$0)`
||`(call $printInt)`
|`hi = lo + hi ;`|`(local.get $ilo$0)`
||`(local.get $ihi$0)`
||`i32.add`
||`(local.set $ihi$0)`
|`lo = hi - lo ;`|`(local.get $ihi$0)`
||`(local.get $ilo$0)`
||`i32.sub`
||`(local.set $ilo$0)`
|`}`|`(br 0)`
||`)`
||`)`
|`return 0 ;`|`(i32.const 0)`
||`return`
|`}`|`)`
||`(export "main" (func $main))`
||`)`
