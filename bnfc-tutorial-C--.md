# The BNFC Tutorial: C--

See [here](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) for the official long version. This is part 2 of the short version, continuing [part 1](bnfc-tutorial-short.md).

## A larger source language</h2>

<p>We want to build a grammar of "C--", a fragment of C sufficient for parsing the following Fibonacci program:</p>

    // a fibonacci function showing most features of the CMM language
  
    int mx () 
    {
      return 5000000 ;
    }
  
    int main () 
    {
      int lo ; 
      int hi ;
      lo = 1 ;
      hi = lo ;
      printf("%d",lo) ;
      while (hi &lt; mx()) {
        printf("%d",hi) ;
        hi = lo + hi ;
        lo = hi - lo ;
      }
      return 0 ;
    }

## List categories

Lists are used everywhere in grammars. In BNFC one can write <code>[C]</code> for a list of <code>C</code>s.</p>

**Activity:** The program `fibonacci` above consists of two functions. How should we formalise this observation as a rule of the grammar of `C--`?

*Answer:* To say that a program is a list of functions we write:

    Prog. Program ::= [Function] ;

**Activity:** How can we formalise the syntax of a function definition as a list of declarations and a list of statements?

*Answer:*

    Fun. Function ::= Type Ident "(" [Decl] ")" "{" [Stm] "}" ;

## Terminators and separators

Lists have terminators and separators:

    terminator Function "" ;
    terminator Stm "" ;
    separator Decl "," ;

<p>The empty terminator <code>""</code> means the elements are just written next to each other.</p>
<p>A list can be forced to have at least one element:</p>

    separator nonempty Ident "," ;

## Comments 
<p>Comments are parts of source codes that the compiler ignores.</p>
<p>BNFC permits the definition of two kinds of comments: one-line and enclosed.</p>
<p>They are defined in the following ways for C--:</p>

    comment "//" ;
    comment "/*" "*/" ;

<p>Thus one-line comment definitions define the beginning of a comment, and enclosed comment definitions the beginning and the end.</p>
<p>Commends are resolved by the lexer, using a finite automaton. Therefore nested comments are not possible.</p>

## Complete grammar for C--

    comment "//" ;
    comment "/*" "*/" ;
    
    Prog. Program  ::= [Function] ;
    Fun.  Function ::= Type Ident "(" [Decl] ")" "{" [Stm] "}" ;
    Dec.  Decl     ::= Type [Ident] ;
    
    terminator Function "" ;
    terminator Stm "" ;
    separator  Decl "," ;
    separator  nonempty Ident "," ;
    
    SDecl.   Stm ::= Decl ";"  ;
    SExp.    Stm ::= Exp ";" ;
    SBlock.  Stm ::= "{" [Stm] "}" ;
    SWhile.  Stm ::= "while" "(" Exp ")" Stm ;
    SReturn. Stm ::= "return" Exp  ";" ;
    
    EAss.    Exp  ::= Ident "=" Exp ;
    ELt.     Exp1 ::= Exp2 "&lt;" Exp2 ;
    EAdd.    Exp2 ::= Exp2 "+" Exp3 ;
    ESub.    Exp2 ::= Exp2 "-" Exp3 ;
    EMul.    Exp3 ::= Exp3 "*" Exp4 ;
    Call.    Exp4 ::= Ident "(" [Exp] ")" ;
    EVar.    Exp4 ::= Ident ;
    EStr.    Exp4 ::= String ;
    EInt.    Exp4 ::= Integer ;
    EDouble. Exp4 ::= Double ;
    
    coercions Exp 4 ;
    
    separator Exp "," ;
    
    TInt.    Type ::= "int" ;
    TDouble. Type ::= "double" ;

## Built-in token types
<p>These types are hard-coded and cannot be value types of rules:</p>
      <ul>
        <li><code>Integer</code>: sequence of digits, e.g. <code>123445425425436</code></li>
        <li><code>Double</code>: two sequences of digits with a decimal point in between, and an optional exponent, e.g. <code>7.098e-7</code></li>
        <li><code>String</code>: any characters between double quotes, e.g. <code>"hello world"</code></li>
        <li><code>Char</code>: any character between single quotes, e.g. <code>'7'</code></li>
        <li><code>Ident</code>: a letter followed by letters, digits, and characters <code>-'</code>, e.g. <code>r2_out'</code></li>
      </ul>
      <p>Precise definitions are given in the LBNF report.</p>

## Token definitions
<p>A grammar can define new token types by using regular expressions. Here is an example of the format:</p>

    token CIdent (letter | (letter | digit | '_')*) ;

<p>See LBNF report for more information.</p>

## Remembering the position of a token

<p>The position of a token can be passed to the syntax tree:</p>

    position token CIdent (letter | (letter | digit | '_')*) ;

<p>See LBNF report for more information.</p>

<h2>Further reading</h2>
      <p>BNFC homepage: <a href="http://bnfc.digitalgrammars.com/">http://bnfc.digitalgrammars.com/</a></p>
      <p>The <a href="./LBNF-report.pdf">LBNF report</a>, covering the whole Labelled BNF grammar language used in BNFC:</p>
      <p>Appel's book series <em>Modern Compiler Implementation in ML/C/Java</em>. BNFC generates abstract syntax representations as used in these books.</p>
      <p>Dragon book: Aho, Lam, Sethi, Ullman, <em>Compilers Principles, Techniques and Tools</em>, 2007.</p>
  </div>
</body>
</html>