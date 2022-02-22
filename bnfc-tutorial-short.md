# BNFC Tutorial Short Version

See [here](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) for the official tutorial with more information.
    
## Creating a parser with BNFC
    
When you have BNFC in place (i.e. on your path), you can all it by `bnfc`. This gives you a list of available options. The most common choice is:
    
    bnfc -m --haskell grammar.cf      

The <code>-m</code> flag makes BNFC to generate a <code>Makefile</code>. This means that, after running <code>bnfc</code>, you can create an executable parser by

    make

Now you created a parser for the grammar in `grammar.cf`. This parser is called `TestGrammar`. You can call the parser on a programm by

    ./TestGrammar program

## My first compiler: calculator

We start with everyone's favourite: the desktop calculator.

To make it as simple as possible, we restrict ourselves to integers, with addition, subtraction, multiplication, and (lossy) division.

The input language is defined with the following BNFC grammar.

    EAdd. Exp  ::= Exp  "+" Exp1 ;
    ESub. Exp  ::= Exp  "-" Exp1 ;
    EMul. Exp1 ::= Exp1 "*" Exp2 ;
    EDiv. Exp1 ::= Exp1 "/" Exp2 ;
    EInt. Exp2 ::= Integer ;
  
    coercions Exp 2 ;

Copy this code into a file called <code>Calc.cf</code>.

## Compiling the compiler in Haskell

Assuming you want to work in Haskell, do the following.

    bnfc -m --haskell Calc.cf
    make

If everything goes fine, this will create a parser testexecutable, which you can try out in the following way:

    echo "23 + 4 * 70" | ./TestCalc 
  
    Parse Successful!
    [Abstract Syntax]
    EAdd (EInt 23) (EMul (EInt 4) (EInt 70))
    [Linearized tree]
    23 + 4 * 70

The tools that you need to have installed are

- <a href="http://www.haskell.org/ghc/">GHC</a>, the Glasgow Haskell compiler
- <a href="http://www.haskell.org/alex/">Alex</a>, a lexer generator for Haskell
- <a href="http://www.haskell.org/happy/">Happy</a>, a parser generator for Haskell

## What there is in a BNFC file

A BNFC source file is a sequence of <strong>rules</strong>,where most rules have the format

    LABEL . VALUE_CATEGORY ::= PRODUCTION ;

<p>The <code>LABEL</code> and <code>VALUE_CATEGORY</code> are <strong>identifiers</strong> (without quotes).</p>
<p>The <code>PRODUCTION</code> is a sequence of</p>
<ul>
  <li>identifiers, called <strong>nonterminals</strong></li>
  <li><strong>string literals</strong> (with quotes), called<strong>terminals</strong></li>
</ul>
<p>The rule has the following semantics:</p>
<ul>
  <li>a <strong>tree</strong> of type <code>VALUE_CATEGORY</code>can be built with <code>LABEL</code> as the topmost node, fromany sequence specified by the production, so that whosenonterminals give the subtrees of this new tree</li>
</ul>
<p>Types of trees are the <strong>categories</strong> of thegrammar. Tree labels are the <strong>constructors</strong> of thosecategories.

## Common problems with identifiers

<p>All categories and constructors should</p>

- begin with a capital letter
- contain only ASCII letters, digits, and underscores (`_`)
- be distinct from each other

<p>These three conditions guarantee that the grammar will work on <em>all</em> platforms.

## Example of a tree

<p><img style="float: right;" src="Sources/tuttree.png" alt="Example tree showing precedence levels"></p>

<p>In the examples above, the string</p>

    23 + 4 * 70

<p>was compiled into a tree displayed as follows:</p>

    EAdd (EInt 23) (EMul (EInt 4) (EInt 70))

<p>This is just a handy (machine-readable!) notation for the "real" tree</p>

<p>(You may also notice that it is <em>exactly</em> the notation Haskell programmers use for specifying trees.)</p>

## Precedence levels 

<p>How does BNFC know that addition is above multiplication? I.e., why isn't the tree</p>

    EMul (EAdd (EInt 23) (EInt 4)) (EInt 70)

<p>This is due to the fact that multiplication expressions are given <strong>higher precedence</strong>.</p>
<p>The nonterminal <code>Exp</code> has <strong>precedence level</strong> 0 (actually, we could write <code>Exp0</code> to mean the same), <code>Exp1</code> has precedence level 1, etc.</p>
      <p>The rule</p>

    EAdd. Exp  ::= Exp  "+" Exp1 ;

<p>says: <code>EAdd</code> forms an expression of level 0 from an expression of level 0 on the left of <code>+</code> and of level 1 on the right.</p>
      <p>Likewise, the rule</p>

    EMul. Exp1 ::= Exp1 "*" Exp2 ;

<p>says: <code>EMul</code> form an expression of level 1 from an expression of level 1 on the left of <code>*</code> and of level 2 on the right.

## Semantics of precedence levels

<p>An expression of higher level can always be used on lower levels as well.</p>

- <code>2 + 3</code> is OK: level 2 is used on levels 0 and 1, respectively

<p>An expression of any level can be lifted to the highest level by putting it in parentheses.</p>
      <ul>
        <li><code>(5 + 6)</code> is an expression of level 2</li>
      </ul>
      <p>The rule <code>coercions Exp 2</code> says that 2 is the highest level for <code>Exp</code>.</p>
      <p>All precedence variants of a nonterminal denote the same type.</p>
      <ul>
        <li><code>2</code>, <code>2 + 2</code>, and <code>2 * 2</code> are of the same type, <code>Exp</code>.</li>
      </ul>
      <p>This means that a type-correct tree remains type-correct, if a subtree of category <code>Exp</code><em>i</em> is changed into a subtree of <code>Exp</code><em>j</em>.</p>

## The deeper semantics of precedence levels: dummy labels

<p>BNFC permits a <strong>dummy label</strong>, which does not construct a new tree but just returns the old one (which must be of same type):</p>

    _. Exp2 ::= "(" Exp ")" ;

<p>The rule (<code>coercions Exp 2</code>) is a shorthand for a group of dummy rules:</p>

    _. Exp  ::= Exp1 ;
    _. Exp1 ::= Exp2 ;
    _. Exp2 ::= "(" Exp ")" ;


## Compiler components
<p>BNFC generates the following components:</p>
<ul>
        <li>lexer: the JLex/Alex/Flex file</li>
        <li>parser: the Cup/Happy/Bison file</li>
        <li>abstract syntax: a bunch of Java/Haskell/C/C++ files</li>
        <li>pretty printer: a Java/Haskell/C/C++ file</li>
        <li>back end skeleton: a Java/Haskell/C/C++ file</li>
        <li>grammar document: a Latex file</li>
      </ul>
      <p>The first three belong to a <strong>compiler front end</strong>, analysing the source code.</p>
      <p>The <strong>compiler back end</strong> can either</p>
      <ul>
        <li>generate some target code (compiler)</li>
        <li>run the source code tree directly (interpreter)</li>
      </ul>

## Abstract syntax
<p>The hub of a modern compiler:</p>
      <ul>
        <li>target of the front end</li>
        <li>starting point of the back end</li>
      </ul>
      <p>In the middle of the front end and back end, there is manipulation of abstract syntax, such as type checking and optimizations.</p>
      <p>Abstract syntax representations in programming languages (as generated by BNFC):</p>
      <ul>
        <li>Haskell: algebraic datatypes</li>
        <li>Java and C++: classes and subclasses</li>
        <li>C: unions of structures</li>
      </ul>

## Abstract syntax in Haskell

<p>This is the most straightforward, so we start from it.</p>
      <p>For every type in the grammar, a <code>data</code> definition is produced:</p>

    data Exp =
       EAdd Exp Exp
     | ESub Exp Exp
     | EMul Exp Exp
     | EDiv Exp Exp
     | EInt Integer
      deriving (Eq,Ord,Show)

<p>The <code>deriving</code> part says that the type <code>Exp</code> has equality and order predicates, and its objects can be shown as strings.</p>

<p>The complete code is in the file <a href="tutorial/calc/haskell/AbsCalc.hs"><code>AbsCalc.hs</code></a>.</p>

## An interpreter in Haskell: the tree traversal
      
<p>We write a program that parses an arithmetic expression and returns a numeric value.</p>
<p>Here is the tree traversal: pattern matching on the type <code>Exp</code>.</p>

    module Interpreter where
  
    import AbsCalc
  
    interpret :: Exp -> Integer
    interpret x = case x of
      EAdd exp0 exp  -> interpret exp0 + interpret exp
      ESub exp0 exp  -> interpret exp0 - interpret exp
      EMul exp0 exp  -> interpret exp0 * interpret exp
      EDiv exp0 exp  -> interpret exp0 `div` interpret exp
      EInt n  -> n

<p>The complete code is in the file <a href="tutorial/calc/haskell/Interpreter.hs"><code>Interpreter.hs</code></a>.</p>

## An interpreter in Haskell: the main function

<p>We write a module reading string input calling <code>Interpreter.interpret</code>.</p>
<p>The string is first lexed and parsed. The file <a href="tutorial/calc/haskell/Interpret.hs"><code>Interpret.hs</code></a>. is modified from <a href="tutorial/calc/haskell/TestCalc.hs"><code>TestCalc.hs</code></a>.</p>

    module Main where
  
    import LexCalc
    import ParCalc
    import AbsCalc
    import Interpreter
  
    import ErrM
  
    main = do
      interact calc
      putStrLn ""
  
    calc s = 
      let Ok e = pExp (myLexer s) 
      in show (interpret e)

## Compiling and running the interpreter in Haskell
<p>Compile with GHC:</p>

    ghc --make Interpreter.hs

<p>Run on command-line input:</p>

    echo "1 + 2 * 3" | ./Interpreter 
    7

<p>Run on file input (<a href="tutorial/calc/ex1.calc"><code>ex1.calc</code></a>):</p>

    ./Interpret < ex1.calc
    9102


