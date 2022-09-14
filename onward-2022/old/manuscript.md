
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

\paragraph{Terminology used.} The programming system which we evolve towards self-sustainability we call the *product system* or simply "the system" where convenient. The programming system we use to get it started is the *producer* system divided into *platform* and *substrate* which we will define shortly. Changes can be made either at the producer / implementation level, or *in-system*, meaning within the product system by using it as a programming system at its user level. Design *forces* will be distilled from the discussion and *heuristics* will be identified that resolve competing forces in a plausible way.

## Contributions
\{For Tomas: Isn't this section just the "blank slate" paragraph above? Hard to separate, as I feel it ties off the Introduction section nicely and it flows naturally from the COLA motivation.}

\note{TP: This is depth-first exploration with some branching suggested}
This essay presents a rational reconstruction of the ideal steps.

This essay documents the process of bootstrapping a self-sustainable programming system using a chosen platform. I describe the process through a sequence of steps. These steps can be followed in different ways for different platforms, but their structure is likely necessary. For each step, I describe the general task at hand and illustrate this with a concrete decision made in the implementation of BootstrapLab. 

* Story of a concrete system development
* Rational reconstruction of the logical steps needed to bootstrap a self-sustainable programming system
* Design heuristics that can be used by designers along the way

We conclude by identifying which parts of our journey ought to be transferrable to other contexts, suggesting a *general technique* for interactively bootstrapping a self-sustainable system from any starting platform.

## Philosophical premise of the work
\note{This was generated from the todo "introduce state/change separation", I moved it here from the "Journey itinerary" section. Seems sufficiently general and didn't feel like it belongs there.}
In what follows, we find it usefully general to approach the product system as a physical system in the sense of analytical mechanics. There is always a current *state* of the system, and this will necessarily *change over time*. We stress that this is the case regardless of whether the underlying programming metaphor is imperative, purely functional, logic-based, or otherwise eschews a notion of "state" in its conceptual model. This is perhaps vacuously true in the following way. In working with a declarative or functional programming system, the expression you are currently editing or the output you are seeing at a given moment is, by definition, a single state, and this changes whether you interact or simply wait for progress. In other words, anything to which this view is not applicable will not be interactive or interesting.

We include both the visible interface and the "hidden" internal state of the system in this model. Such an all-encompassing "state", of course, isn't comprehensible atomically but is always broken down into substructures (whether byte lists, object graphs, trees or otherwise). Likewise, the actual change from one state to another usually does not involve all of the state but only a small part of it. In the limit, there is usually some smallest unit of state (a byte, dictionary entry, tree node) and this gives rise naturally to primitive *instructions* describing a change to such a small unit. Different choices for how to represent the instructions have implications for where it is possible to take the evolution of a system. We will see that some choices are more appropriate than others for ensuring a system can be made self-sustainable. 

# Journey itinerary
Here is a preview of our journey towards a self-sustaining system:

\note{repeat each of these at the top of its section?}

1. **Choose a starting platform.** _The platform is a pre-existing programming system that we are happy to work in. The choice must balance one's familiarity with the platform and its distance from desired substrate features. By assumption, it is impossible or infeasible to re-program the platform at all (let alone to become self-sustainable.) Instead we will use it to create and run a product system that *is* self-sustainable._
2. **Design a substrate.** _The substrate is programmed by us via the platform. It defines the basic infrastructure supporting the product system: how the state is represented and changed. The design of a substrate re-uses parts of the platform where possible and extends it where necessary. We must decide which platform capabilities to use to represent the state and how to expose graphics and interaction. We design a minimal instruction set describing changes to the state, which can be represented using the state. We then use the platform to implement an engine that executes these instructions._
3. **Implement temporary infrastructure.** _Use the platform to implement interfaces for working with the substrate in-system, such as a state viewer or editor. They constitute the "ladder" that we will pull up behind us once it has led to in-system implementations of these tools. Add a persistence mechanism if necessary so that progress can accumulate._
4. **Implement a high-level language.** _The substrate's ASM is cumbersome, so ensure programs can be expressed in-system via high-level constructs. Decide how to represent expressions as structured state and whether to interpret or compile them into ASM. Ideally, gradually develop such an engine in ASM interactively. Alternatively, implement it at the platform level and port it to ASM._
5. **Provide for alternative notations.** _Port the existing state editor code to high-level in-system expressions. Use the newly-self-sustaining state editor to enter expressions for an interface optimised for editing high-level expressions. Connect this to the relevant event handlers and activate it._

What we have here looks like a Waterfall development plan, each step strictly following from the completion of the previous. This presentation is convenient as a summary, but in practice, the sequencing here need not be so rigid. Instead, adjacent steps may overlap, or we may need to prototype and revise a previous step in light of the result. The general outline deliberately resembles the historical development of computing's abstractions: beginning at the machine level and ascending through to higher-level languages, each time building the next stage in the current one. With that in mind, let us now proceed to the first stage.

# Choose a starting platform
At the risk of stating the obvious, the very first step in such a process is to select the "blank slate" to start from. This could be any existing programming language or system. Probably, the biggest factor determining this choice will be our familiarity and preferences for programming features. However, there is one other factor particularly worth drawing attention to.

Because the platform is non-self-sustainable, if we begin with a high-level platform with many convenient features, then we will have to regard them as black boxes *even from within the product system.* We might be able to expose them directly as primitives, but we will not be able to re-program them in-system as we cannot even re-program them from the platform! Alternatively, we could re-implement them in the product, but this will delay the point where we can work in-system. All this is to say that we should keep in mind that their development is not under our control, so nice features from the platform will only be able to attain opaque primitive status in the product system, if anything.

- In BootstrapLab, the platform is JavaScript, built-in Web technologies and libraries (including graphics), and the browser developer tools.
- In COLA, the platform is C \cite{OROM} or C++ \cite{COLAs} and the Unix command-line environment; in other words, the Unix programming system \cite{TechDims}.

*What can be changed at the user level?* We are at the null base case here; there is not yet a product system to speak of, so all change is in the programmer's hands.

# Design a substrate
With the *platform* defined as the already-existing programming system that we must start from, we define the *substrate* as the basic infrastructure, implemented via the platform, necessary for the product system. This substrate is the part of the system which we have control over (being programmed *by us*, unlike the platform itself) yet which we do not expect to expose from within the system. In other words, the substrate is the small non-self-sustainable core that supports the self-sustainable product on top of it.

Our division in a nutshell is as follows:
* *Platform*: not created by us, not self-sustainable.
* *Substrate*: created by us atop the platform, not self-sustainable.
* *Product*: created by us atop the substrate, self-sustainable.

The design of the substrate roughly follows the distinction between code and data. Firstly, we must decide how the *state* of the system will be represented. Then, we decide how *small changes* to that state can be described as pieces of state themselves. This condition, that primitive instructions live in the same ontology as the state, is essential: with it in place, code can be generated by programs and higher-level abstractions can be built up from the low level.

## Low-level flat byte arrays
In COLA, the substrate is quite minimal. The majority is inherited "for free" from the low-level programming environment provided by the operating system. At the bottom, state consists of a vast array of discrete bytes, addressed numerically. Some structure is imposed on this via C's standard memory allocation routines, refining the model of state to a graph of fixed-size memory blocks (plus the stack). Changes to this state are represented as machine instructions encoded as bytes. This is the basic state model of a C program; the sample code for COLA embellishes this with little more than a way to associate objects to their vtables, and a cache for method lookups.

This sort of bare-bones, low-level substrate is quicker to complete because there is very little actual work to do. The ontology of state is copied from the platform, and in this case the machine instructions can be inherited too. (In general, the internal representation of code in the platform will be unavailable to us when programming with it, so we expect not to be able to inherit it. This low-level platform is a special case, where we do have access to code if we are willing to write hex instructions.) Having a quicker implementation of the substrate means we can start working in-system sooner, but there is a downside: it may actually be tedious and slow to work with such minimal functionality. The unfortunate effect would be that we speed through a primitive substrate, only to suffer slow progress at the beginning of in-system development.

**Force 1: Push "boilerplate" into the substrate, to avoid wasting in-system development on it.**

This happened in our own experience following the sample C implementation of the object system for COLA. The code was easy enough to comprehend and compile, but what we were left with was a system living entirely in memory lacking even a command-line interface. In order to develop the system, it seemed necessary to run it in a machine-level debugger.

Even so, however, we would still be stuck in the low-level binary world which is unfriendly for humans to work with. Instead of names, we only have numbers for addressing things. Additionally, the state is *flat*. We cannot insert or grow something without physically moving other content to make space. Anything that can be called a structure (trees, graphs etc.) has to be faked as scattered memory blocks pointing to each other.

Historically, this was an unfortunate necessity. But nowadays, we have the opportunity to leave this behind, and instead build new systems on top of a "low level" that is nevertheless *minimally* human-friendly. In other words, even though it would be straightforward to port the above to JavaScript (just have a global array for system state), we feel it would miss an opportunity to benefit from its built-in naming and structuring facilities.

**Force 0: Everything should "fit": instructions, high-level expressions, and graphics expressions should all it the substrate, and the substrate should fit the platform.**

**Heuristic 1: Ensure the substrate natively supports string names and substructures.** (minimal, cautious application of Force 1)

## Low-level nested property dictionaries
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
Even though JavaScript is a high-level language, we consider this substrate low-level *relative* to the platform below it. It largely inherits the model of state, only making simplifications. For example, JavaScript objects have prototypal inheritence, meaning that a simple "read" operation of a property requires potentially traversing a chain of objects. Our substrate here omits this, so a read is quite simple. Nevertheless, even though this substrate is minimally human-friendly, it still runs the risk that we end up lamenting its feature-light state slowing down our in-system work.

There is no limit to how fancy we could make the substrate in terms of high-level abstractions and convenient features; interested readers may consult Appendix\ \ref{appendix-crf} for examples. However, these would take much longer to implement and delay in-system development. Moreover, this risks doing a lot of work that can never benefit from in-system innovation, because the substrate is not meant to be modifiable from within. (In the limit of this behaviour, we simply implement a boring old non-self-sustainable programming system with no ability to change any of its implementation!)

**Force 2: Push complex features in-system to avoid delaying in-system development and to allow them to benefit from in-system innovation.**
 
\note{Summary of the above: one question is whether to make the substrate bare-bones, with minimal functionality, or to make it very high-level with many features. Programming a bare substrate could be faster with less to implement, but it may make working within the system initially slow without convenient features. On the other hand, taking time to implement a very complicated all-dancing substrate risks spending too much time there before beginning to work in-system---and all the while excluding this functionality from user-level access!}

## Instruction set
While the "data" half of the substrate may be easy to inherit from the platform, the "code" half is not. Simply including an interpreter for source code in JavaScript is not an option, as this would embed a reliance on text and parsing in the core of the system. Slightly better would be an interpreter for the abstract syntax tree. However, Force 2 still pushes against this. A high-level language interpreter is still nontrivial even for ASTs and would delay our ability to work in-system. Also, an interpreter is a computer program; this program, or parts of it, might be best expressed or debugged via particular notations; by having it in the substrate, we restrict ourselves to the interface of JavaScript in our text editor.

Instead, consider what it takes to implement the interpreter for assembler, a.k.a. the Fetch-Decode-Execute cycle. We fetch the next small change to make to the state, i.e. instruction. We do a simple case-split on the opcode field; we carry out some small change to the state; rinse and repeat. With this, we can surely mirror the real-world development of higher-level languages from lower ones.

**Heuristic 2: Begin from imperative assembler, as this will be quickest to implement.**
Justification: _Imperative assembler allows us to make arbitrary primitive changes to the state, using a minimal interpreter that is quick to implement._ (Force 2 > Force 1)

\note{Good time to practice preventing Richard Jones' assumption that I wanted to put x86 assembler in everything}
It is important to stress that this "assembler" is relative to the form of the substrate. If the substrate is binary memory, "assembler" will refer to machine instructions. But in our case of a minimally human-friendly low level, there is nothing binary about them. Similarly, "imperative" just refers to the fact that the instructions are arranged in a sequence from the point of view of the interpreter, because it is easier to implement a fetch-execute cycle than, say, a resolver for a dependency graph.

\todo{So what's the necessary set of instruction types?}
\todo{incl asm relativity}
\note{If only 1 or 2, consider making anon}
**Hypothesis 1: For any given state ontology, the instruction set of small changes can be mechanically derived.**

Similar considerations lead us to aim for an instruction set that is quick to implement.

**Heuristic 3: Go RISC (fewer instruction types) rather than CISC (more types), as this will be quickest to implement.**
Justification: _Fewer instruction types reduces the size of the interpreter, making it quicker to implement._ (Force 2 > Force 1)

See Appendix\ \ref{minimal-instruc-set} for the gory details of how we executed this heuristic.

## Graphics and interaction
One way we wish to distinguish this work from the related work is that graphical interfaces are present from the beginning and not just an afterthought. There are two factors here: how graphics are represented in the substrate, and how they are actually displayed (analogous to the representation vs. execution of instructions.)

In fact, this is a microcosm of the entire journey: first we must select a graphics library available for our platform (i.e., the graphics *platform*.) Then we must decide how graphics are represented in our substrate (a graphics *sub-*substrate, if you will) and how these graphics actually end up on our screen.

In BootstrapLab, we chose to build off the THREE.js 3D graphics library as our platform. As for the substrate, we face an immediate choice between so-called "immediate mode" and "retained mode" conventions. In immediate mode, we draw and change graphics by issuing commands; a "code-like" approach. In retained mode, the state of the scene is represented as some structured arrangement of state. When we want to change something, we simply change the relevant part of the state and the display should automatically update.

Immediate-mode in this case could be realised by, say, exposing all the relevant THREE.js functions as special instruction types. In actuality, however, this sounded far too tedious to work with; Force 1 won out and we opted for retained mode instead.

And it was here that the Matching / Fit Principle (Force 0) directed us again. Consider the "flat bytes" substrate; such was the environment in which games were once programmed, for performance reasons. In this world there is often a special region of memory, the *framebuffer*, which is treated as the ground truth of pixels displaying on the screen. To draw, programs rasterise shapes into pixels and write to the framebuffer. The framebuffer has a flat structure---two-dimensional, yet not by any means nested---matching the substrate it sits within. We propose that a natural choice for retained-mode graphics representation can be found by inspecting the substrate. In our case, a natural choice is not a flat "framebuffer" but instead a tree structure of data describing shapes and text---vector graphics.

In BootstrapLab, this is a sub*tree* of the state under the top-level name `scene`. Its content is freeform apart from several special keynames (e.g. `text` or `position`) which have graphical consequences.

**Heuristic 4: Make graphical interfaces expressible as ordinary state in a special location.** (Force 0 and 1 somehow?)

(Example of how nested tree fields are represented vs. the visual output)

\todo{STILL NEED TO ACTUALLY DO THIS IN BOOTSTRAPLAB}
Finally, to expose the platform's ability to listen for user input, a simple approach is to execute a named code sequence in the substrate from JavaScript event handlers (which now function as "device drivers"):

```javascript
// NB: aesthetically smoothed BL code for ease of understanding (naming, classes, etc)
window.onkeydown = e => {
  state.set('input', 'type', 'keydown');
  state.set('input', 'key', e.key);
  let input_handler_code = state.get('input', 'handler');
  /*
    ... TODO: save interrupted context...?
  */
  state.set('next_instruction', new state.Map({
    map: input_handler_code, key: 1
  }));
  asm.execute_till_completion();
  /*
    ... TODO: restore interrupted context...
    ... TODO: what happens when input happens while stepping through this code?
  */
};
```

## Summary of the substrate

Graph of maps. Lists are just maps with number keys. Instructions `load`, `deref`, `store`, `index`, `js`. Special part of state `scene` containing top-level scene nodes. Each may use special keys like `text`, `width`, `height`, `color`, `position`, `children` as well as abritrary other keys for user data.

*What can be changed at the user level?* Via the cumbersome JavaScript console: system state, and instructions can be executed (even more tediously.) We're talking "Turing tarpit" level.

# Implement temporary infrastructure
\todo{asm edit? given EDSAC plaf, only option is to do this. shortcut: inherit platform interface.}

On its own, the chosen platform only has one way to view parts of the state: issuing JavaScript commands via the developer console to poll a current value. This is tedious. Instead, we consider the ability to see a live view of all of the state to be a highly useful facility early on. Force 1 wins relative to Force 2 and we spend some time implementing a tree view in the substrate, based on an existing JavaScript library. State editing can continue to be done via the console.

**Heuristic 5: As soon as possible, use the platform to implement a temporary state viewer.** (Force 1 > Force 2)

Nevertheless, the consequences remain: this is a complex set of functionality set to work and display in one specific way, and all control over this resides at the platform level. We can exercise no control over any of this from within the system. Therefore, we regard this situation as *temporary* or *throwaway*; it is a ladder that we climb to end up in a state where we can implement a (better) state editor in-system. Once we are happy with that, we can pull up the ladder---or as Piumarta says, "jettison\[ it\] without remorse".

This meant that BootstrapLab's interface consists of three sections. (picture) On the right, we have the browser console, inherited through from the platform's interface. In the middle, we have the output of the platform's main graphics technology, DOM, displaying the temporary state viewer. Because we have not chosen to expose DOM control from within the system, the system only affects this area indirectly through ordinary state changes. Finally, on the left, we have the THREE.js-backed graphics window, where we will later build a state editor whose behaviour (including appearance) *will* be controlled from within the system.

Ideally, we would have actually supported interactive state *editing*, not just viewing. In our case, however, we just put up with console state editing until implementing a state editor in terms of the left-hand graphics window (see later.)

Another example of temporary infrastructure is zoom-and-pan in the graphics window. Working within a small box is very restrictive, but this finite region can be opened up into an infinite workspace by adding the ability to pan and zoom the camera with the mouse. We felt this was so important that, again, Force 1 overrode Force 2 and we implemented this in JavaScript.

*What can be changed at the user level?* Same as before, but accelerated due to being able to see a live view of state.

# Implement a high-level language
It is still more attractive to work in our text editor with JavaScript than to work with BL-ASM. To rectify this, we need to bring high-level programming constructs in-system. This will still not be enough unless we have an acceptable editing interface, but we will revisit this later.

If we take JavaScript, and strip away the concrete syntax, we get a resulting tree structure of function definitions, object literals, and imperative statements. A similar structure with similar semantics would be obtained from other dynamic languages. In fact, this would largely resemble Lisp S-expressions under Lisp semantics; hardly surprising considering Lisp's famously minimal syntax of expression trees. Furthermore, the evaluation procedure for Lisp is simple and well-established.

Thus it makes sense to implement a Lisp-like tree language in the substrate. This way, we can import useful JavaScript constructs (`if-else`, loops, functions, recursion, etc.) for in-system programming. Note, however, that ordinary Lisp is based on lists whose entries have *implicit* meanings based on their positions. This is a fairly straightforward "fit" to its substrate made of S-expressisons. Our substrate, on the other hand, suggests a language based around maps whose entries are explicitly *named*. We shall call it *Masp.*

Lisp:
```
(define fac
  (lambda (n)
    (if (= n 0)
      1
      (* n (fac (decr n)))))
(fac 3)
```

Masp:
```
apply: define,  name: fac,  as:
  apply: lambda,  arg_names: { 1: n },  body:
    to: n,  apply:
      0: 1,  _:
        apply: *,  1: n,  2:
          apply: fac,  n:
            apply: decr,  1: n
apply: fac,  n: 3
```

It is true that the equivalent Masp code is more verbose when rendered this way. However, one of our key goals is to enable the use of other, better notations if desired, which we will discuss in the next section. Here, we start from an internal representation that has *more* information (explicit named arguments) than Lisp, but can choose to display this however we feel appropriate (perhaps by omitting name labels other than the entry being edited.)

Even though we will find it easiest to use JavaScript to write the interpreter code, the *state* used by the interpreter can still live in-system. This means we will have less to port from JavaScript once we are done.

\note{Again, because this is "in the weeds" of implementation details, might be better to just state *what* I did and leave the "how" to an appendix}
A na\"ive approach would simply port the standard Lisp interpreter routines (`eval` and `apply`) to recursive JavaScript functions. However, this would miss an opportunity for visualization and debugging present in our substrate. 

Observe that Lisp evaluation, happily, is little more than a tree walk over the expression. At any point, we are looking at a subtree and will evaluate it until reaching a primitive value. Ordinarily, the "current subexpression" is an argument to `eval` at the top of the stack, while the stack records our path from the original top-level expression. Since we have a tree visualisation, we might as well use it instead of a stack. Furthermore, instead of destructively replacing tree nodes with their "more-evaluated" versions, let us simply "annotate" the tree instead. This way, we can easily trace the provenance of subexpressions.

We choose to evaluate Masp expressions *gradually* and *non-destructively* in a subtree of the state. 

...

Now we have JavaScript code for the interpretation steps, we can port it to BL-ASM.

Alternatively, we can write a compiler from Masp to BL-ASM in Masp, run this in the existing JavaScript interpreter to compile itself to BL-ASM?

\note{Perhaps the idea of bootstrapping abstractions from the low-level (Heuristic 2) has been refuted? Instead of writing BL-ASM in-system to build things up, it's been so tedious that I haven't touched it and instead leaped to Masp in JavaScript! It is of course still possible in principle, but the complex reality of how I did things and the design decisions I made, caused it to be uneconomical.}

*What can be changed at the user level?* The structural "syntax" and semantics of the high-level language.

# Provide for alternative notations
Now that we can run Masp programs in the substrate, we need a better way of entering and editing them in the first place. We will take this opportunity to put a state editor in-system which will make the existing state view obsolete. In-keeping with the proof-of-concept nature of this work, we will target a rudimentary tree editor that nevertheless surpasses the current method of issuing commands in the JavaScript console.

*What can be changed at the user level?* The graphical interface of the system! (Including the concrete notation for programs and data)

# Generalising and transferring the steps

## Example: the Unix filesystem

# Conclusions \& Future Work

\note{TP: Possibly draw a diagram of what are all the things that have to match? Like code-data in substrate, substrate-highLevelLanguage etc.}

\note{TP: Also, what were the alternative routes not taken}

# Appendix: The Cutting Room Floor
\todo{sketch tempting, discarded higher-level features e.g. state change listeners, meta-maps, inverse maps}
For example, it would be useful to attach state change listeners to keep parts of the state in sync with others. We could go further and include constraint-based programming features. On another note, our substrate is currently based on "maps" without a predefined ordering of the entries. However, there is always some order in which they will be displayed, so it might be nice to be able to set this on a per-map basis.

# Appendix: graphs vs trees
\todo{graphs vs trees}

# Appendix: Minimal random-access instruction set
\todo{justify? / explain my choice of really minimalistic instruction set which I somewhat regret...
Import description and rationale from LIVE21 submission and followup}

In our case, we opted for instructions at the "microcode" level:

**Heuristic 4: Factor out instruction "parameters" into special state registers where possible.**
