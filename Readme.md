CS152 Lab: A Calculator Example
===================================

[home page for lab1](https://www.cs.ucr.edu/~dtan004/proj1/lab01_lexer.html)

[home page for lab2](https://www.cs.ucr.edu/~dtan004/proj2/lab02_parser.html)


## Tools preparation

Make sure you have a Linux environment for this project. You can use 'bolt', your own Linux machine, or Windows Subsystem for Linux(WSL). I highly recommend you directly use 'bolt' since it contains all the necessary tools preinstalled. 

```sh
ssh <your-net-id>@bolt.cs.ucr.edu
```

Make sure you have the following tools installed and check the version:
1. flex -V       (>=2.5)
2. bison -V      (>=3.0)
3. git --version (>=1.8)
4. make -v       (>=3.8)
5. gcc -v        (>=4.8)
6. g++ -v        (>=4.8 optional if you wish to use C++)

## Clone and Copy Lab1 Code

Use 'git' to clone the project template:

```sh
    git clone <your-repo-link> lab2
```

Move your code in Lab1 into this new repository. Please do not directly overwrite the calc.lex file.
Change the rules based on the knowledge your learnt in Lab 2.

## Check Your Tasks for Lab 2

Read the documentation of Lab2 and your tasks in [home page for lab2](https://www.cs.ucr.edu/~dtan004/proj2/lab02_parser.html). 

## Using Bison to generate C source code of Parser

Modify both calc.lex and calc.y to create the parser of calculator. Run the following command to generate a header which contains all the token definitions and a piece of C source code of the parser.

```sh
    bison -v -g -d -o parser.c calc.y  # it generates parser.h, parser.c, parser.output and parser.dot
```

* `-d` option will let bison generate the header file `parser.h`, contains token and function definitions 
* `-v` option will generate `parser.output` which is a debugging file shows the inner states and rules
* `-g` option generate a GraphViz dot file `parser.dot` which represents the pushdown automaton generated.


## Keep your progress by uploading to Github

After you finish all 4 tasks, you are done the second part of this lab. You don't need to submit the code.
Similalily, uploading to Github can keep your progress:

```sh
git add .  # add all files under current folder to staged changes
git commit -m "lab2 - parser"  # create a new commit
git push   # upload to Github, it may requires your username and password of Github
```

