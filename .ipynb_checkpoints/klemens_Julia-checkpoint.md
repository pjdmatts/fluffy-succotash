# How To Learn A Programming Language

## Questions For The Julia Programming Language

### How do I print “Hello world” to the screen?

In the REPL:

```
Julia> println("Hello World")
```

Or in a file called hello.jl and from the command line:

```
$ julia hello.jl
```

Or in the repl, using hello.jl:

```
julia> include("hello.jl")
```

### How do I insert comments?

```
#Like This
```

### Where's the documentation?

https://docs.julialang.org/en/v1/

### What are numbers like?

There are Complex and there are Real
Under Real

- Irrational
- Rational
- Integer
- AbstractFloat

### What are the lists like?

Tuples, which are are immutable sequences indexed from 1

```
()              # an empty tuple
(1,)            # a one element tuple
("a", 1)        # a two element tuple
('a', false)::Tuple{Char, Bool} # tuple type assertion
x = (1, 2, 3)
x[1]            # 1 (element)
x[1:2]          # (1, 2) (tuple)
x[4]            # bounds error
x[1] = 1        # error - a tuple is not mutable
a, b = x        # tuple unpacking a==1, b==2
```

Arrays are mutable and passed by reference

```
Array{Char}(undef, 2, 3, 4) # uninitialized 2x3x4 array of Chars
Array{Int64}(undef, 0, 0)   # degenerate 0x0 array of Int64
zeros(5)                    # vector of Float64 zeros
ones(5)                     # vector of Float64 ones
ones(Int64, 2, 1)           # 2x1 array of Int64 ones
trues(3), falses(3)         # a tuple of a vector of trues and a vector of falses
Matrix(I, 3, 3)             # 3x3 Bool identity matrix, requires to run first: using LinearAlgebra
x = range(0, stop=1, length=11) # an iterator having 11 equally spaced elements
collect(x)                  # converts an iterator to vector
1:10                        # iterable from 1 to 10
1:2:10                      # iterable from 1 to 9 with 2 skip
reshape(1:12, 3, 4)         # a 3x4 matrix like object filled columnwise with values from 1 to 12
fill("a", 2, 2)             # a 2x2 array filled with "a"
repeat(rand(2,2), 3, 2)     # a 2x2 random matrix repeated 3x2 times
x = [1, 2]                  # a two element vector
resize!(x, 5)               # resize x in place to hold 5 values (filled with garbage)
[1]                         # a vector with one element (not a scalar)
[x * y for x in 1:2, y in 1:3] # a comprehension generating 2x3 array
Float64[x^2 for x in 1:4]   # casting comprehension result element type to Float64
[1 2]                       # 1x2 matrix (hcat function)
[1 2]'                      # 2x1 Adjoint matrix (reuses memory)
permutedims([1 2])          # 2x1 matrix (permuted dimensions, new memory)
[1, 2]                      # vector (concatenation)
[1; 2]                      # vector (vcat function)
[1 2 3; 1 2 3]              # 2x3 matrix (hvcat function)
```

### How do I declare a new variable?

The simplest way to bind a value to a new variable is by an assignment:

```
x = 1.0 # x is bound to Float64 value
x = 1 # now x is bound to value Int32 on 32 bit machine and Int64 on 64 bit machine
```

### How are references handled?

Julia values are passed and assigned by reference. If a function modifies an array, the changes will be visible in the caller.

### How do I handle strings of text?

String operations:

```
"Hi " * "there!"
"Ho " ^ 3                   # string concatenation
string("a = ", 123.3)       # create using print function
repr(123.3)                 # fetch value of show function to a string
occursin("CD", "ABCD")      # check if the second string contains the first
"\"\n\t\$"                  # C-like escaping in strings, new \$ escape
x = 123
"$x + 3 = $(x+3)"           # unescaped $ is used for interpolation
"\$199"                     # to get a $ symbol you must escape it
raw"D:\path"                # a raw string literal; useful for paths under Windows
s = "abc"                   # a string of type String
chop(s)                     # remove last character from s, returns a SubString
```

### What are the structs like?

You can define and access composite types. Here is an example of a mutable composite type:

```
mutable struct Point
x::Int64
y::Float64
meta
end
p = Point(0, 0.0, "Origin")
p.x                         # access field
p.meta = 2                  # change field value
p.x = 1.5                   # error, wrong data type
p.z = 1                     # error - no such field
fieldnames(Point)           # get names of type fields
```

There are also Dictionaries:
Associative collections (key-value dictionaries):

```
x = Dict{Float64, Int64}()  # an empty dictionary mapping floats to integers
y = Dict("a"=>1, "b"=>2)    # a filled dictionary
y["a"]                      # element retrieval
y["c"]                      # error
y["c"] = 3                  # added element
haskey(y, "b")              # check if y contains key "b"
keys(y), values(y)          # tuple of collections returning keys and values in y
delete!(y, "b")             # delete a key from a collection, see also: pop!
get(y,"c","default")        # return y["c"] or "default" if not haskey(y,"c")
```

### How do I write and call a function? Are function arguments copied in or pointed to?

You can define your own functions:

```
f(x, y = 10) = x + y        # one line definition of a new function f with y defaulting to 10
                            # last expression result returned
function f(x, y=10)         # the same as above but allowing multiple expressions
    x + y                   # in the body of the function
end
f(3, 2)                     # a simple call, 5 returned
f(3)                        # 13 returned
(x -> x^2)(3)               # an anonymous function with a call example
() -> 0                     # an anonymous function with no arguments
h(x...) = sum(x)/length(x) - mean(x)    # a vararg function; x is a tuple; call first: using Statistics
h(1, 2, 3)                  # the result is 0
x = (2, 3)                  # a tuple
f(x)                        # error - we try to add 10 to (2,3)
f(x...)                     # OK - tuple unpacking
s(x; a = 1, b = 1) = x * a / b          # function with keyword arguments a and b
s(3, b = 2)                 # call with a keyword argument
q(f::Function, x) = 2 * f(x)            # a function can be passed around; here we require that f is a Function
q(x -> 2x, 10)              # 40 returned, no need to use * in 2x (means 2*x)
q(10) do x                  # creation of an anonymous function by do construct, useful eg. in IO
    2 * x
end
m = reshape(1:12, 3, 4)
map(x -> x ^ 2, m)          # 3x4 array returned with transformed data
filter(x -> bitstring(x)[end] == '0', 1:12)  # a fancy way to choose even integers from the range
==(1)                       # returns a function that tests for equality to 1
findall(==(1), 1:10)        # find indices of all elements equal to 1, similar: findfirst, findlast
```

### How do I debug a function?

https://julialang.org/blog/2019/03/debuggers/

Debugger is a REPL level debugger just like gdb

https://github.com/JuliaDebug/Debugger.jl

### What are the scoping rules?

https://docs.julialang.org/en/v1/manual/variables-and-scoping/

Julia uses lexical scoping, meaning that a function's scope does not inherit from its caller's scope, but from the scope in which the function was defined. For example, in the following code the x inside foo refers to the x in the global scope of its module Bar:

```
julia> module Bar
           x = 1
           foo() = x
       end;
```

and not a x in the scope where foo is used:

```
julia> import .Bar

julia> x = -1;

julia> Bar.foo()
1
```

### How do I maintain continuity across function calls?

Global variables

### Can I do text substitutions (i.e., macros)?

Yes:

https://docs.julialang.org/en/v1/manual/metaprogramming/#man-macros

Macros provide a mechanism to include generated code in the final body of a program. A macro maps a tuple of arguments to a returned expression, and the resulting expression is compiled directly rather than requiring a runtime eval call. Macro arguments may include expressions, literal values, and symbols.

Basics

Here is an extraordinarily simple macro:

```
julia> macro sayhello()
           return :( println("Hello, world!") )
       end
@sayhello (macro with 1 method)
```

When @sayhello is entered in the REPL, the expression executes immediately, thus we only see the evaluation result:

```
julia> @sayhello()
Hello, world!
```

### How do I load libraries/packages so I don't have to reinvent wheels?

There are julia packages

https://docs.julialang.org/en/v1/manual/faq/#Packages-and-Modules

In REPL or Jupyter:

```
using Pkg
Pkg.add("DataFrames")
```

https://docs.julialang.org/en/v1/manual/code-loading/

### How do I set up functions that act on a specific structure?

See composite types (structs) above:

```
mutable struct Point
    x::Int64
    y::Float64
    meta
end
p = Point(0, 0.0, "Origin")
p.x                 # access field
p.meta = 2          # change field value
p.x = 1.5           # error, wrong data type
p.z = 1             # error - no such field
fieldnames(Point)   # get names of type fields
```

Constructors are functions that create new objects – specifically, instances of Composite Types. In Julia, type objects also serve as constructor functions: they create new instances of themselves when applied to an argument tuple as a function. This much was already mentioned briefly when composite types were introduced. For example:

```
julia> struct Foo
           bar
           baz
       end

julia> foo = Foo(1, 2)
Foo(1, 2)

julia> foo.bar
1

julia> foo.baz
2
```

Case Study: Rational

Perhaps the best way to tie all these pieces together is to present a real world example of a parametric composite type and its constructor methods. To that end, we implement our own rational number type OurRational, similar to Julia's built-in Rational type, defined in rational.jl:

### Function-like objects

Methods are associated with types, so it is possible to make any arbitrary Julia object "callable" by adding methods to its type. (Such "callable" objects are sometimes called "functors.")

For example, you can define a type that stores the coefficients of a polynomial, but behaves like a function evaluating the polynomial:

```
julia> struct Polynomial{R}
           coeffs::Vector{R}
       end

julia> function (p::Polynomial)(x)
           v = p.coeffs[end]
           for i = (length(p.coeffs)-1):-1:1
               v = v*x + p.coeffs[i]
           end
           return v
       end

julia> (p::Polynomial)() = p(5)
```

https://docs.julialang.org/en/v1/manual/methods/

### How do I get an auxiliary structure that builds upon a base structure?

Julia not OOP.

### How do I package my own stuff?

https://pkgdocs.julialang.org/v1/creating-packages/

https://github.com/invenia/PkgTemplates.jl 

### Other Sources Of Documentation

https://juliabyexample.helpmanual.io/

https://learnxinyminutes.com/docs/julia/

https://en.wikibooks.org/wiki/Introducing_Julia

http://bogumilkaminski.pl/files/julia_express.pdf

http://bit-player.org/2016/getting-to-know-julia 