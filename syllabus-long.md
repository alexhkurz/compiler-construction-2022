# Syllabus

## Course Description 

Prerequisites, MATH 250, CPSC 350, CPSC 354. Students will learn the software tools and programming techniques needed to design and build a prototype implementation of a domain specific language. On the theoretical side, students will learn enough of the mathematical underpinnings of the tools to apply them with confidence. On the practical side, students will write a grammar and build a lexer, parser, typechecker and interpreter for a fragment of C++.

## Course Learning Outcomes

See also the [Fowler School of Engineering Program Learning Outcomes](https://docs.google.com/document/d/1OESCtPUolnWFV_qRFuRzNrzxmUtYr5H-dFaYVmPUKY0/edit?usp=sharing).

This course teaches compiler construction not as a low level machine language oriented course but as a high level software engineering course. The aim is to give students the means to design and implement their own domain specific language (DSL). The [quote](http://wiki.c2.com/?DomainSpecificLanguage)

        Any sufficiently large software project becomes a DSL by virtue of the
        library of functions built up to implement the solution to the specific
        problem the project was concieved to address. 

indicates how DSLs are related to software engineering in general.

While writing a fully fledged compiler is a big task beyond what we can do in a one semester course, with a good mix of theory based software engineering tools, it is well in the scope of a semester to learn how to create a grammar, parser, typechecker and interpreter for a small but realistic programming language. In our case, we choose a fragment of C++, which should be familiar to many students and emphasises that the taught methods apply to real existing mainstream programming languages.

The course is structured around the assignments which should give students the practical skills needed to create their own domain specific language. These include how to 

- define a language by writing a grammar
- create a lexer and parser using a "compiler compiler"
- write a type checker  
- write an interpreter  
- write a code generator   

On the way, students will learn more about theory and practice of programming. For example, students will 

- learn how to use the principles of compositionality and separation of concerns in order to structure a major software engineering project such as a compiler (example: the use of abstract syntax trees to separate parser, typechecker, interpreter, code generation)

- learn to use software engineering tools such as compiler-compilers

- deepen their knowledge of recursive programming (a technique without which the assignments would be infeasible to do in the given time)

- learn more about a range of programming languages such as C++, Haskell, Java, Scala  (for example, we will see to use the algebraic data types of Haskell and Scala and indicate how to work around the fact that they do not exist in Java)

- see examples of domain specific programming languages (such as regular expressions and BNF, but see also Chapter 8 of the book *Implementing Programming Languages* for more) 

- learn how to read and write context free grammars of a programming language  

- learn about some of the intricacies of parsing and understand how the design of languages is influenced and constrained by available parsing techniques

- understand more about the history of programming languages, in particular about the debate surrounding the software crisis of the 1960ies and how it gave birth to structured programming and the field of software engineering  

Moreover, students will encounter and understand important algorithms such as 

- regular expression search
- transforming NFAs to DFAs
- recursive tree traversals 
- typechecking
- typeinference

We will also understand how compiler construction relies crucially on important topics in the theory of programming languages such as

- the distinction between syntax and semantics  
- finite automata (DFA, NFA, ...)  
- regular expressions  
- context free grammars  
- pushdown automata  
- LL and LR parsing, shift reduce parsing  
- abstract syntax
- type theory (judgements, rules, type checking, type inference, context/environments, ...)  
- operational semantics  
- ...

Finally, students will learn to appreciate that mathematics is not only important for developers who create the tools used in everyday engineering practice, but that knowledge of the mathematical concepts and results underpinning these engineering tools also have a positive impact on engineering practice (and increase your chances to pass a coding interview). I discuss some aspects of this in a these notes on [mathematics as a programming language](https://hackmd.io/s/ByGLTvFDE).

## Overview

The course is a sequel of last semester's course on Programming Languages. Nevertheless, with some extra effort, it can also be followed independently as everything will be explained. Last semester, among other things, we
- explained the basic ideas of parsing,
- saw some simple context free grammars in BNFC,
- wrote some functional programs (in Haskell and LambdNat)
- modified an interpreter written in Haskell to implement new language features.

This semester, we move from building our own toy language to a challenging fragment of C++. This means that we will study the following classic compiler topics:
- lexing/finite automata
- parsing/context free grammars/pushdown automata
- type checking/type theory
- interpretation/operational semantics
- code generation 

In more practical terms, we will have assignments on creating the following for a fragment of C++:

- a grammar
- a typechecker 
- an interpreter 
- a compiler to Webassembly

In particular there will be an opportunity to learn about Webassembly.


These topics have a practical and a theoretical side. The practical side consists in implementing lexers, parsers, type checkers, interpreters, etc. The theoretical side abstracts away from the implementation details and allows to specify and verify the algorithms that need to be implemented. We will not go into the mathematical aspects of the theory, which proves theorems about the correctness or complexity of the algorithms or also sometimes proves the non-existence of algorithms for certain classes of problems. But we will need to learn enough theory, so that we understand how it helps us to specify and to correctly implement the algorithms in questions.

If I had to summarise the course in one slogan, I would say

    compilers translates languages by induction on the abstract syntax tree.

The first part of the course on lexing and parsing is about how to construct the abstract syntax tree. The second part on type checking, interpretation and code generation is about the inverse, namely about how to go from an abstract syntax tree to another language.


## Required Text

We will follow the book Implementing Programming Languages by Aarne Ranta. The plan is to work through Chapters 2 - 6, which are available online.

## Course Materials

For DFA, NFA, etc I will use the classic book Introduction to Automata Theory, Languages, and Computation.

Quick links to BNFC installation instructions and other documentation, to be used in addition to the official [BNFC tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) and the  book [Implementing Programming Languages](http://www.grammaticalframework.org/ipl-book/):

- BNFC: [basic installation instructions](https://github.com/alexhkurz/compiler-construction-2020/blob/master/BNFC-installation.md)
- BNFC: [self check](https://github.com/alexhkurz/compiler-construction-2020/blob/master/BNFC-example.md)
- BNFC/Happy parser:
  - The BNFC/Happy [`.info`-files](https://hackmd.io/s/ryllVQdIN#How-to-create-the-info-file-of-a-Happy-parser) and an example of [shift-reduce parsing](https://hackmd.io/s/ryllVQdIN).
  - How to eliminate [shift/reduce and reduce/reduce](https://hackmd.io/s/rJoVGDh84) conflicts.
  - Understanding [LALR(1) parsing](https://hackmd.io/s/S11sLzo84) with a worked example.
- [LBNF](https://hackmd.io/s/SyJowOgD4): Some tips on the language in which a BNF-grammar is written.

## Assessment

- 4% of the course: Participation in lectures and office hours as well as asking, discussing, and answering questions on the discussion forum.

- 56% of the course: 4 assignments, worth 14% each. 

- 40% of the course on theoretical aspects such as automata, grammars, type inference, etc: 
  - 1 midterm worth 10%. 
  - Final exam worth 30%. The final exam will cover the same material as the tests. 

  
## Assignments

The programming assignments
- can be done in groups of up to 2 students.
- must be submitted via a private GitHub repository shared with me (send me an email when you submit).
- are  typically due at 11:59 pm on the given date. 

Moreover, 
- all programs must be tested.
- no points for programs that do not run.
- grading will be based on correctness, but elegance of solution and style (comments, naming conventions, etc.) are also taken into consideration

There will be the following assignments. Deadlines, links, instructions will be added in due course.

  - Assignment: Grammar and Parser for C++. Deadline tba. 
  - Assignment: Type Checker for CPP. Deadline tba.    
  - Assignment: Interpreter for CPP. Deadline tba.       
  - Assignment: Code Generator for CPP. Deadline tba

## Course Grade Breakdown

Grading scale used for the course:


| Percentage | Letter |
|---|---|
| 90 |	A |
| 80-89 | 	B |
| 70-79	| C |
| 60-69	| D |
| < 60 |	F |

You must score a 70 or above to receive a P when taking the course P/NP.



## Late Policy
If you need more time for an assignment that may be possible if
- you can prove to me that you already have done serious work on the assignment (for example by showing me the code in your GitHub repository);
- you can explain the special circumstances that make you think that you should get more time for the assignment than the other students.

## Participation

- It is expected that students attend every lecture and participate in the Discussion Forum. 
- I also appreciate if students make use of the office hours, which gives me valuable feedback on how the class is going.
- Participation will contribute 5% to the final course grade, see [Assessment](assessment.md).

## Exams

See Assessment. 

## Grading Percentages Breakdown

See Assessment. 

## Final Exam Time
Please double check the [Final Exam Schedule ](https://www.chapman.edu/students/academic-resources/registrar/student-services/final-exam-schedule.aspx).


## Policies required to be listed via University guidelines

#### Chapman University’s Academic Integrity Policy

Chapman University is a community of scholars that emphasizes the mutual responsibility of all members to seek knowledge honestly and in good faith.  Students are responsible for doing their own work and academic dishonesty of any kind will be subject to sanction by the instructor/administrator and referral to the university Academic Integrity Committee, which may impose additional sanctions including expulsion.  Please see the full description of Chapman University's policy on Academic Integrity.

#### Chapman University’s Students with Disabilities Policy

In compliance with ADA guidelines, students who have any condition, either permanent or temporary, that might affect their ability to perform in this class are encouraged to contact the Office of Disability Services.  If you will need to utilize your approved accommodations in this class, please follow the proper notification procedure for informing your professor(s).  This notification process must occur more than a week before any accommodation can be utilized.  Please contact Disability Services at (714) 516–4520 if you have questions regarding this procedure or for information or to make an appointment to discuss and/or request potential accommodations based on documentation of your disability.  Once formal approval of your need for an accommodation has been granted, you are encouraged to talk with your professor(s) about your accommodation options.  The granting of any accommodation will not be retroactive and cannot jeopardize the academic standards or integrity of the course.

#### Chapman University’s Equity and Diversity Policy

Chapman University is committed to ensuring equality and valuing diversity.  Students and professors are reminded to show respect at all times as outlined in Chapman’s Harassment and Discrimination Policy.  Please review the full description of Harassment and Discrimination Policy.  Any violations of this policy should be discussed with the professor, the Dean of Students and/or otherwise reported in accordance with this policy.”

#### Student Support at Chapman University

Over the course of the semester, you may experience a range of challenges that interfere with your learning, such as problems with friend, family, and or significant other relationships; substance use; concerns about personal adequacy; feeling overwhelmed; or feeling sad or anxious without knowing why.  These mental health concerns or stressful events may diminish your academic performance and/or reduce your ability to participate in daily activities.  You can learn more about the resources available through Chapman University’s Student Psychological Counseling Services.

Fostering a community of care that supports the success of students is essential to the values of Chapman University.  Occasionally, you may come across a student whose personal behavior concerns or worries you, either for the student’s well-being or yours.  In these instances, you are encouraged to contact the Chapman University Student Concern Intervention Team who can respond to these concerns and offer assistance. While it is preferred that you include your contact information so this team can follow up with you, you can submit a report anonymously.  24-hour emergency help is also available through Public Safety at 714-997-6763.

#### Religious Accommodation

Religious Accommodation at Chapman University Consistent with our commitment of creating an academic community that is respectful of and welcoming to persons of differing backgrounds, we believe that every reasonable effort should be made to allow members of the university community to fulfill their obligations to the university without jeopardizing the fulfillment of their sincerely held religious obligations. Please review the syllabus early in the semester and consult with your faculty member promptly regarding any possible conflicts with major religious holidays, being as specific as possible regarding when those holidays are scheduled in advance and where those holidays constitute the fulfillment of your sincerely held religious beliefs.

#### Changes
This syllabus is subject to change. Updates will be posted on the course website.


