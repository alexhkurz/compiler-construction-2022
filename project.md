# Project 

**Part 2 of the report**, worth 15%, will be a project. You can choose between any of the two projects below. If you have your own ideas about a project get in touch.

**Deadlines:** 
- Sunday March 20, by sending me an email with a link to the pdf of your report containing a description of your project. (I am happy to extend the deadline by one week, but I don't want to force you to work over the spring break.)
- Final deadline at the end of the exam's week **Friday, May 20**.

Also get in touch and show me your work between the two deadlines.

## Project: Explaining a Compiler

Choose a programming language (such as C) and a compiler (such as gcc) and compile example programs to assembly and explain in some detail
- how the compilation works and 
- how the assembly program is executed on the machine.

For the first deadline, you need to have made a choice of programming language and compiler and show me a program in the source language (C, Java, ...) and the target language (assembly, JVM, ...) that you want to explain. (What about Python?)

For the second deadline, you need to think how to best explain, at the hand of examples, which parts of the source code correspond to which part of the assembly code. *Remember that compilation works by recursion over abstract syntax.* You don't need to dig into how exactly the AST looks like, but your general knowledge about ASTs should help you to construct a high level mapping and explain it in your example.

My recommendation would be to find the source code example that gives the smallest assembly example. Starting from there then to incrementally look at more complicated examples. This should help with constructing and explaining the mapping from source code to assembly.

## Project: Creating Your Own Programming Language

Writing a compiler for a full scale programming language is out of the scope of this course. But it should be possible, for example, for you to invent your own [esoteric programming language](https://en.wikipedia.org/wiki/Esoteric_programming_language). You may also want to think about a domain specific language, for example, to mechanize some boring homework you may have got in some other class. The task then is to design a grammar for a language and write an interpreter.

For the first deadline, you need to describe to me the outlines of a language specification of your programming language. Start with a minimal language and plan for possible extensions.


