/// Testing Pegged modifications.
module test;

import std.algorithm;
import std.array;
import std.conv;
import std.datetime;
import std.range;
import std.stdio;
import std.typecons;
import std.typetuple;

import pegged.grammar;
import pegged.grammartester;

import std.uni: isAlpha;

ParseTree log(ParseTree p)
{
    writeln("called on ", p.name);
    return p;
}

mixin(grammar(`Test:
    A <{log, log} 'a' { log }
    `));

mixin(grammar(
`
Palindromes:
A <- '0' B '0' / '1' B '1'
B <- A / '00' / '11' / '0' / '1'
`));

void main()
{
    writeln(Test("abc"));
    writeln(Palindromes.A("0110"));
    writeln(Palindromes.A("0000001000000"));
    writeln(Palindromes.A("00000010000000"));
    writeln(Palindromes.A("000001100000"));
}

