
\note{
Context: What is the broad context of the work? What is the importance of the general research area?
Inquiry: What problem or question does the paper address? How has this problem or question been addressed by others (if at all)?
Approach: What was done that unveiled new knowledge?
Knowledge: What new facts were uncovered? If the research was not results oriented, what new capabilities are enabled by the work?
Grounding: What argument, feasibility proof, artifacts, or results and evaluation support this work?
Importance: Why does this work matter?

NB: Can use 1st-person!
}

Self-Sustainability beyond textual substrates

# Abstract
Programming is usually based on a strict separation of *implementation* and *user* levels. *Self-sustaining* systems, those which can be reprogrammed from within, offer an interesting alternative to this. Descriptions of these systems and how they are created often relate to meta-circular compilers and "bootstrapping" of programming languages. However, this over-emphasis on languages makes it unclear how to transfer these ideas to programming beyond textual languages. In this paper, I propose some ideas about how to bootstrap more general self-sustaining systems, and reflect on my practical experience of doing so in a specific project. I discuss challenges relating to both the self-sustainability angle and the centrality of supporting notations beyond text. I suggest how to generalise what worked in this case to more general situations, such as other starting points. I conclude that, while experience revealed flaws in some of my initial ideas, others worked well for bootstrapping a self-sustaining programming system.

# Introduction and related work
\note{
TERMINOLOGY TO CLARIFY:
Producer / product
Platform, substrate
Product system
In-system / (within) in the system itself
Low-level / high-level
}

\note{point: programming produces separate application; application only reprogrammable via programming.}
Programming is pervaded by a producer/product separation. A program is generally *produced* by some other program or system as a separate artefact. The product might not have anything to do with programming at all (it might be a game or an office application), while the producer will of necessity be some programming language or system. In these cases, the product's user has little ability to re-program the product on its own, perhaps beyond some limited customisation options anticipated ahead of time. The user's only option is to go to the producer system and make the changes at this level.

\note{point: special-case this to implementation vs user level of programming langs.}
As a special case of this, it's worth observing that the same situation holds even for "programmer-oriented" products like programming languages. This is in a sense surprising, since we consider programming to be fully general for the purposes of creating or modifying software, unlike a customisation menu. Yet no matter what ingenious constructs one can come up with *atop* a programming language, how the language *itself* works is usually inaccessible from this "user" level, beyond any customisation points foreseen by the language designers. In order to change how the language works, the only avenue available, without arbitrary limitations, is to drop back to the *implementation* level (historically, C or C++) and work from there.

\note{point: there is an alternative}
This has several disadvantages. In order to re-program the producer, the user may well have to learn an entirely different language or development process for the producer, without being able to make use of skills or facilities learned in the context of the product. Suppose the product is a high-level language with expressive abstractions, so that the user might find it easy to express their desired changes in this language, or using its standard libraries. Too bad; these changes need to be made at the implementation level, without any of the benefits of the user-level language.

In a *self-sustainable* system, this category distinction between the "producer" or "implementation" level, and the "product" or "user" level, is intentionally diminished. Careful design is employed to avoid "baking in" behaviour as much as possible. The basic advantage of such an approach is that innovation and improvement in the system can feed back into its own development. For example, if one creates a useful library or domain-specific language, one can take advantage of these for modifying the system itself, not just the programs that run on it. We call this *innovation feedback*.

\note{point: but it's been explored in an artificially narrow scope}
Before we go into further detail, let us note that we shifted to talking about self-sustainable *systems*, rather than *languages*. As discussed in\ \cite{TechDims} (forthcoming), we take an interest in more general *programming systems*: these include not only programming languages but also IDEs, programming environments with non-textual notations, and other tools for creating software.

We see this as the appropriate default level of generality for studing programming ideas. Where an idea only applies to textual languages, it makes sense to restrict our attention to that scope. However, by default, we would do well to avoid prematurely committing to a narrower scope by accident. In this vein, the problem here is that the available literature on the topic of self-sustainability describes it in terms of languages, which we feel is an unnecessary narrowing of scope.

\note{Necessary things for self-sus include: able modify basic semantics, able to build useful HL abstractions for ex as illustrated by COLA}

Our main reference for self-sustainability is \cite{COLAs}. It discusses, at a high level, the design of a Combined Object Lambda Architecture or COLA. This is described as a mutually self-implementing pair of abstractions: a structural object model (the "Object" in the acronym) and a behavioural Lisp-like language (the "Lambda"). It is repeatedly emphasised that the system is maximally open to modification, down to the basic semantics of object messaging and Lisp expressions. The design also encourages pervasive use of domain-specific languages, to an extent that is infeasible in normal programming:

\note{Can quote more of COLAs paper prior to explaining the design, merits, demerits etc}
\note{Avoid writing such that reader feels need to understand COLA to continue}

> Applying it \[internal evolution\] locally provides scoped, domain-specific languages in which to express arbitrarily small parts of an application (these might be better called *mood-specific* languages). Implementing new syntax and semantics should be (and is) as simple as defining a new function or macro in a traditional language.

\note{In COLA, this is restricted to the form of textual DSLs, but it is also possible to imagine ... along the style of \cite{not-text-notation}}

While these points are highly appealing to us, their ambition is limited by the framing assumed in the paper. Even though the COLA is frequently described as a "system", it is primarily presented as supporting different languages via a pipeline of traditionally batch-mode transformations such as parsing, analysis, and code generation. The "bootstrapping" process of implementing such a design is, as far as we can tell, also cast in terms of batch-mode transformations of various source code files.

If we follow the COLA design rigidly, we risk spending too much attention on the accidental complexities of parsing and serialising text, rather than the interesting ideas at the core of the design. Furthermore, we would rather support domain-specific *notations* generally, not limited to languages, in the manner quoted above.

We would also rather build up such a system in a more interactive fashion than batch mode. Similarly to the point about notations, we have a desire for generality here. Batch mode could be summarised as simply going through the statements in a file too quickly for our eyes to follow. Yet, if each of those statements is supposed to represent some small change to the system, a human ought to be able to perform each step interactively. Concretely, this means that instead of the orignal recommendation to write C++ files for the initial object system, we would rather start from an interactive REPL-like blank slate and "sculpt" it into a self-sustainable state.

\todo{meta-circular, bootstrapping, smalltalk/lisp, alt notations}

In summary, we like self-sustainability but wish to study it in its proper context, unhampered with the accidental complexity of languages and parsing that lead us down red herrings / blind alleys like meta-circular compilers. What we're aiming for more resembles the bootstrapping process of computing itself: rewiring the plugboard gives way to machine code; machine code lets us write the first assembler; this in turn lets us create tools that allow us to express things in high-level languages, and so on.

It is not immediately clear how to port the COLA self-sustainability ideas to the more general realm of interactive programming systems. One thing we can say, right off the bat, is that agonising about what the "final design" would look like would go precisely against the spirit of a system designed to be arbitrarily evolvable, and in any case should be unnecessary. In fact, this suggests that it should be possible to gradually evolve *towards* a self-sustainable state.

A natural place to start, therefore, is with a "blank slate": an initial implementation platform, most likely a non-self-sustainable programming system, in their case C++. At each stage, we take stock of what changes can feasibly be achieved at the "user" level within the system, versus those that can only be achieved at the implementation level. We then ask ourselves: how can we imbue the user level with control over some of these aspects? The following sections propose key steps for evolving self-sustainability in this way, informed by our actual experience applying them in a protoype called *BootstrapLab*. We will examine the principles, heuristics, and hypotheses that motivated these steps, and reflect on their efficacy in light of actual practice.

\todo{generalised technique, escape text editor

This also seems to be gesturing about a more general *process* or *technique* that could be transferrable to different contexts.
}

# Choose a starting platform
At the risk of stating the obvious, the very first step in such a process is to select the "blank slate" to start from. This could be any existing programming language or system. Probably, the biggest factor determining this choice will be our familiarity and preferences for programming features. However, there is one other factor particularly worth drawing attention to.

Because the platform is non-self-sustainable, if we begin with a high-level platform with many convenient features, then we will have to regard them as black boxes *even from within the product system.* We might be able to expose them directly as primitives, but we will not be able to re-program them in-system as we cannot even re-program them from the platform! Alternatively, we could re-implement them in the product, but this will delay the point where we can work in-system. All this is to say that we should keep in mind that their development is not under our control, so nice features from the platform will only be able to attain opaque primitive status in the prodct system, if anything.

In BootstrapLab, the platform is JavaScript, built-in Web technologies and libraries (including graphics), and the browser developer tools.

In COLA, the platform is C \cite{OROM} or C++ \cite{COLAs} and the Unix command-line environment; in other words, the Unix programming system \cite{TechDims}.

# Design a substrate
With the *platform* defined as the already-existing programming system that we must start from, we define the *substrate* as the basic infrastructure, implemented via the platform, necessary for the product system. This substrate is the part of the system which we have control over (being programmed *by us*, unlike the platform itself) yet which we do not expect to expose from within the system. In other words, the substrate is the small non-self-sustainable core that supports the self-sustainable product on top of it.

Our division in a nutshell is as follows:
* *Platform*: not created by us, not self-sustainable.
* *Substrate*: created by us atop the platform, not self-sustainable.
* *Product*: created by us atop the substrate, self-sustainable.

The design of the substrate roughly follows the distinction between code and data. Firstly, we must decide how the *state* of the system will be represented. Then, we decide how *small changes* to that state can be described as pieces of state themselves. This condition, that primitive instructions live in the same ontology as the state, is essential: with it in place, code can be generated by programs and higher-level abstractions can be built up from the low level.

## Low-level flat byte arrays
In COLA, the substrate is quite minimal. The majority is inherited "for free" from the low-level programming environment provided by the operating system. At the bottom, state consists of a vast array of discrete bytes, addressed numerically. Some structure is imposed on this via C's standard memory allocation routines, refining the model of state to a graph of fixed-size memory blocks (plus the stack). Changes to this state are represented as machine instructions encoded as bytes. This is the basic state model of a C program; the sample code for COLA embellishes this with little more than a way to associate objects to their vtables, and a cache for method lookups.

This sort of bare-bones, low-level substrate is quicker to complete because there is very little actual work to do. The ontology of state is copied from the platform, and in this case the machine instructions can be inherited too. (In general, the internal representation of code in the platform will be unavailable to us when programming with it, so we expect not to be able to inherit it. This low-level platform is a special case.) Having a quicker implementation of the substrate means we can start working in-system sooner, but there is a downside: it may actually be tedious and slow to work with such minimal functionality. The unfortunate effect would be that we speed through a primitive substrate, only to suffer slow progress at the beginning of in-system development.

**Force 1: Push "boilerplate" into the substrate, to avoid wasting in-system development on it.**

This happened in our own experience following the sample C implementation of the object system for COLA. The code was easy enough to comprehend and compile, but what we were left with was a system living entirely in memory lacking even a command-line interface. In order to develop the system, it seemed necessary to run it in a machine-level debugger.

Even so, however, we would still be stuck in the low-level binary world which is unfriendly for humans to work with. Instead of names, we only have numbers for addressing things. Additionally, the state is *flat*. We cannot insert or grow something without physically moving other content to make space. Anything that can be called a structure (trees, graphs etc.) has to be faked as scattered memory blocks pointing to each other.

Historically, this was an unfortunate necessity. But nowadays, we have the opportunity to leave this behind, and instead build new systems on top of a "low level" that is nevertheless *minimally* human-friendly. In other words, even though it would be straightforward to port the above to JavaScript (just have a global array for system state), we feel it would miss an opportunity to benefit from its built-in naming and structuring facilities.

**Heuristic 1: Ensure the substrate natively supports string names and substructures.**

## Low-level nested property dictionaries
\todo{graphs vs trees?}
For BootstrapLab, starting from JavaScript, this low-level substrate would be a graph of plain JavaScript objects acting as property dictionaries. "Addresses" in this context consist of an object reference and a key name, so primitive instructions might look like this:

```
{
  operation: 'copy',
  from: [ alice, 'age' ],
  to: [ bob, 'age' ]
}
```

Note how, because such instructions are also plain JavaScript objects, they can be generated and manipulated just like other state, whether programmatically or manually. This is opposed to having "two types of thing"---ordinary data, and code---which must be edited, analysed, etc. using completely different tools. However, this example is not actually one of the instructions we included for BootstrapLab, as we will see shortly.

## Higher-level, smarter substrates
Even though JavaScript is a high-level language, we consider this substrate low-level *relative* to the platform below it. It largely inherits the model of state, only making simplifications. For example, JavaScript objects have prototypal inheritence, meaning that a simple "read" operation of a property requires potentially traversing a chain of objects. Our substrate here omits this, so a read is quite simple. Nevertheless, even though this substrate is minimally human-friendly, it still runs the risk that we end up lamenting its low-level state slowing down our in-system work.

There is no limit to how fancy we could make the substrate in terms of high-level abstractions and convenient features; interested readers may consult Appendix\ \ref{appendix-crf} for examples. However, these would take much longer to implement and delay in-system development. Moreover, this risks doing a lot of work that can never benefit from in-system innovation, because the substrate is not meant to be modifiable from within.

**Force 2: Push complex features in-system to avoid delaying in-system development and to allow them to benefit from in-system innovation.**
 
\note{Summary of the above: one question is whether to make the substrate bare-bones, with minimal functionality, or to make it very high-level with many features. Programming a bare substrate could be faster with less to implement, but it may make working within the system initially slow without convenient features. On the other hand, taking time to implement a very complicated all-dancing substrate risks spending too much time there before beginning to work in-system---and all the while excluding this functionality from user-level access!}

## Instruction set
While the "data" half of the substrate may be easy to inherit from the platform, the "code" half is not. Simply including an interpreter for source code in JavaScript is not an option, as this would embed a reliance on text and parsing in the core of the system. Slightly better would be an interpreter for the abstract syntax tree. However, Force 2 still pushes against this. A high-level language interpreter is still nontrivial even for ASTs and would delay our ability to work in-system. Also, an interpreter is a computer program; this program, or parts of it, might be best expressed or debugged via particular notations; by having it in the substrate, we restrict ourselves to the interface of JavaScript in our text editor.

Instead, consider what it takes to implement the interpreter for assembler, a.k.a. the Fetch-Decode-Execute cycle. We fetch the next small change to make to the state, i.e. instruction. We do a simple case-split on the opcode field; we carry out some small change to the state; rinse and repeat. With this, we can surely mirror the real-world development of higher-level languages from lower ones.

**Heuristic 2: Begin from imperative assembler, as this will be quickest to implement.**

Similar considerations lead us to aim for an instruction set that is quick to implement.

\todo{justify? / explain my choice of really minimalistic instruction set which I somewhat regret...
Import description and rationale from LIVE21 submission and followup; decide how much detail we really need to go into here}

**Heuristic 3: Go RISC rather than CISC, as this will be quickest to implement.**

In our case, we opted for instructions at the "microcode" level:

**Heuristic 4: Factor out instruction "parameters" into special state registers where possible.**

\todo{incl asm relativity}
**Hypothesis 1: For any given state ontology, the instruction set of small changes can be mechanically derived.**

## Graphics
\todo{import rationale from HaPoC slides, etc}

**Heuristic 4: Make graphical interfaces expressible as ordinary state in a special location.**

\todo{throwaway state editor}
\todo{How do interaction events trigger code execution?}

## Summary of the substrate

Graph of maps. Lists are just maps with number keys. Instructions `load`, `deref`, `store`, `index`, `js`. Special part of state `scene` containing top-level scene nodes. Each may use special keys like `text`, `width`, `height`, `color`, `position`, `children` as well as abritrary other keys for user data.

# Write key low-level programs
\todo{???}

# Implement a high-level language
It is still more attractive to work in our text editor with JavaScript than to work with BL-ASM. To rectify this, we need to bring high-level programming constructs in-system. This will still not be enough unless we have an acceptable editing interface, but we will revisit this later.

If we take JavaScript, and strip away the concrete syntax, we get a resulting tree structure of function definitions, object literals, and imperative statements. A similar structure with similar semantics would be obtained from other dynamic languages.

\note{informal conjecture - probably not appropriate for the paper: At the syntax level, dynamic languages are very different, but at the AST level, they're all just slight variations on Lisp!}

Because (???), it makes sense to implement a Lisp-like tree language in the substrate. However, ordinary Lisp is based on lists and relies on positional arguments, whereas ours will be based on maps and support named arguments---let us call it Masp!

Even though we will find it easiest to use JavaScript to write the interpreter code, the *state* used by the interpreter can still live in-system. This means we will have less to port from JavaScript once we are done.

A na\"ive approach would simply port the standard Lisp interpreter routines (`eval` and `apply`) to recursive JavaScript functions. However, this would miss an opportunity for visualization and debugging present in our substrate. 

Observe that Lisp evaluation, happily, is little more than a tree walk over the expression. At any point, we are looking at a subtree and will evaluate it until reaching a primitive value. Ordinarily, the "current subexpression" is an argument to `eval` at the top of the stack, while the stack records our path from the original top-level expression. Since we have a tree visualisation, we might as well use it instead of a stack. Furthermore, instead of destructively replacing tree nodes with their "more-evaluated" versions, let us simply "annotate" the tree instead. This way, we can easily trace the provenance of subexpressions.

We choose to evaluate Masp expressions *gradually* and *non-destructively* in a subtree of the state. 

...

Now we have JavaScript code for the interpretation steps, we can port it to BL-ASM.

Alternatively, we can write a compiler from Masp to BL-ASM in Masp, run this in the existing JavaScript interpreter to compile itself to BL-ASM?

\note{Perhaps the idea of bootstrapping abstractions from the low-level (Heuristic 2) has been refuted? Instead of writing BL-ASM in-system to build things up, it's been so tedious that I haven't touched it and instead leaped to Masp in JavaScript! It is of course still possible in principle, but the complex reality of how I did things and the design decisions I made, caused it to be uneconomical.}

# Provide for alternative notations
Now that we can run Masp programs in the substrate, we need a better way of entering and editing them in the first place. We will take this opportunity to put a state editor in-system which will make the existing state view obsolete. In-keeping with the proof-of-concept nature of this work, we will target a rudimentary tree editor that nevertheless surpasses the current method of issuing commands in the JavaScript console.

# Generalising and transferring the steps

## Example: the Unix filesystem

# Conclusions

# Appendix: The Cutting Room Floor
\todo{sketch tempting, discarded higher-level features e.g. state change listeners, meta-maps, inverse maps}
For example, it would be useful to attach state change listeners to keep parts of the state in sync with others. We could go further and include constraint-based programming features. On another note, our substrate is currently based on "maps" without a predefined ordering of the entries. However, there is always some order in which they will be displayed, so it might be nice to be able to set this on a per-map basis. 
