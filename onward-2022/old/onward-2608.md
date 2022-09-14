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
Programming is usually based on a strict separation of *implementation* and *user* levels. *Self-sustaining* systems where the user is also the programmer have the potential to transform the way we program, because they can be modified and improved from within. However, self-sustaining systems are few and tightly linked to advanced programming language notions of meta-circularity and bootstrapping. If we want to allow anyone to modify their programs from within, we need to step beyond programming languages and adopt more structured, visual ways of programming. How notions like meta-circularity might work in such context is an important unexplored territory.

This essay examines the problem of designing a graphical self-sustaining programming system. The essay is a critical reflection based on my first-hand experience of building one such system. I discuss challenges relating to self-sustainability and going beyond textual notations. I suggest how to generalize what worked in my particular case to more general situations. The essay reports both positive and negative results, but it makes the first step towards the design of a more accessible, open and powerful programming system for everyone.

# Introduction

#### NB - I get the distinction between product/producer (thing/meta-thing) but I think it is a bit confusing and it may work well to talk about source/product with producer as the "label on the arrow" between the two.

In most programming, there is a strict separation between the _product_ and its _source_. The product is created from the source by a _producer_. The producer is a compiler for a programming language or other similar programming system built for programmers, while the product may be any end-user application such as a game. In this arrangement, the user of the product has little ability to re-program the product, beyond setting configuration parameters anticipated ahead of time. The user's only option is to modify the source, if it is available.

Interestingly, the arrangement is the same for user-oriented products and _most_ programmer-oriented products, namely programming languages and systems. Most programming languages cannot be modified by the user. If the user wants to re-program the language beyond a customization anticipated by the language designer, they have to go and modify the compiler source code. If the compiler for a language is written using the language itself, the task is easier as the user is already familiar with the language, but they typically still have to make their modifications separately from their ordinary use of the system.

#### Maybe some reference to convivial tools (Ilich?) to make Stephen happy :)

In the context of programming languages and systems, the separation between the product and the source is particularly lamentable, as it makes it very hard for programmers to improve their tools. If the language ecosystem is not created using itself, a programmer who masters the language will not easily be able to improve it. Even if it is written using itself, the burden of getting the source code, recompiling and deploying it, and maintaining a separate version prevent most users from improving the language.

The alternative to the typical arrangement is to have *self-sustainable* systems, which are systems that diminish the distinction between the _product_, _source_ and _producer_. In a self-sustainable system, a single environment is used for using the product, but also for re-programming it and for re-programming the producer, i.e., the system itself that is used for the programming. Careful design is employed to avoid "baking in" behaviour as much as possible. The basic advantage of such an approach is that innovation and improvement in the system can feed back into its own development. For example, if one creates a useful library or domain-specific language, one can take advantage of these not just for building the product, but also for modifying the system itself. This *innovation feedback* can lead to a virtuous cycle of innovation.


# Contributions
The goal of this essay is to lay the foundations for the design of new self-sustainable programming systems that are more open and accessible. The user of such systems should be able to use the system for building new products and, along the way, gradually learn how to make increasingly complex improvements to the system itself using domain-appropriate, often graphical, notations.

To do so, the essay critically analyses the process of bootstrapping a single novel self-sustainable programming system, which I call BootstrapLab, and identifies ideas that may apply more generally. This essay presents a rational reconstruction of the ideal steps of the bootstrapping process. For each step, I describe the general task at hand, illustrate this with a concrete decision made in the implementation of BootstrapLab and, occasionally, sketch possible alternative decisions and their likel y consequences. In other words, this essay is a depth-first exploration with some alternative branches suggested along the way.

The essay can be read at three different levels:

* First, the essay tells the story of a concrete system development. BootstrapLab is a novel self-sustainable system, based on structured editing, built on top of the web platform.
* Second, the essay is organized as a rational reconstruction of the logical steps needed to bootstrap a self-sustainable programming system.
* Third, the essay identifies design forces and heuristics for resolving them that can be used by designers of future self-sustainable systems.

We conclude by identifying which parts of our journey ought to be transferrable to other contexts, suggesting a *general technique* for interactively bootstrapping a self-sustainable system from any starting platform.

# Related work

The notion of self-sustainable system is difficult to discuss purely at the programming language level, because it crucially depends on how program execution and production is interconnected. For this reason, we talk about *programming systems*, as discussed in\ \cite{TechDims}, which include not only programming languages, but also IDEs, programming environments with non-textual notations, and other tools for creating software.  

#### TODO: Add some references to bootstrapping (not much?), meta-circularity (some classing LISP things?)

In the context of programming languages, the compiler or an interpreter for a language can be implemented in the language itself. This is known as _bootstrapping_ and it allows the user to modify the compiler, but they typically have to do so outside of the environment used for building other products. A related concept is that of _meta-circular evaluator_, which is an interpreter for a language, written using the language, that utilizes capabilities of the language to implement many of the advanced concepts in the language. Typically, a meta-circular interpreter for LISP in LISP may implement `eval` by calling `eval`. This makes the task of writing the interpreter easier, but it does not eliminate the distinction between the product (application) source code and producer (interpreter) source code.

The two best-known self-sustainable programming systems are likely Smalltalk and Lisp. Both are typically discussed in programming language terms, but they are even more interesting as programming systems. In Smalltalk and many implementations of Lisp (e.g., Interlisp), the system itself (producer) can be modified from the same environment that is used for creating products. In other words, a Smalltalk image contains both the objects that make up the product one is building as well as the objects of the Smalltalk environment itself.

#### TODO: Include some references to the two Hirschfeld workshops here? For "structured" maybe refer to Varv?

Most literature discussing self-sustainability focuses on textual languages. We broaden the scope to programming systems, because this is necessary in order to talk about the interaction with the system. Moreover, we are interested in graphical or structured ways of expressing programs that go beyond text.

The one system that directly influenced our work is Combined Object Lambda Architecture (COLA)\ \cite{COLAs}. The system is described as a mutually self-implementing pair of abstractions: a structural object model (the "Object" in the acronym) and a behavioural Lisp-like language (the "Lambda"). The system aims for maximal openness to modification, down to the basic semantics of object messaging and Lisp expressions. The self-sustainability allows for innovation feedback that the authors refer to as _internal evolution_:

> Applying \[internal evolution\] locally provides scoped, domain-specific languages in which to express arbitrarily small parts of an application (these might be better called *mood-specific* languages). Implementing new syntax and semantics should be (and is) as simple as defining a new function or macro in a traditional language.

The aim of the COLA design is to create a maximally flexible self-sustaining system, but the design has three limitations. First, it restricts the form of notations and, consequently, the created domain-specific languages to textual. Second, COLA is primarily presented as a system supporting programming languages via a pipeline of traditional batch-mode transformations such as parsing, analysis, and code generation. Third, the bootstrapping process of implementing such a design is also cast in terms of batch-mode transformations of various source code files.

# Design objectives

The development of a self-sustainable system resembles the bootstrapping process of computing itself: machine code lets us write the first assembler; this is extended with special interpreted or compiled instructions; the system becomes expressive enough for creating high-level programming languages, and so on.

## Interactivity and notational pluralism

We follow the maximal customizability of COLAs, but we aim to bootstrap a graphical and interactive self-sustainable system instead of a textual one based on batch processing:

* We want to support not just textual domain-specific languages, but visual domain-specific notations. A user of the system should be able to express their thoughts in a diagrammatic form.
* We want to make the system more interactive. The user should be able to modify the state of the system during its execution through small independent steps.

This approach can better utilize the graphical and interactive capabilities of modern computing, but it also eliminates the accidental complexities of parsing and serialising text. Similarly, making the system interactive will allow the user to better understand the consequences of individual small changes to the system and, in turn, will support the virtuous cycle of self-improvements.

In technical terms, rather than writing the initial object system in a language like C++, we choose, as our starting point, a platform equipped with interactive REPL that makes it possible to start from a "blank slate" and gradually "sculpt" it into a self-sustainable state.

#### Reference something from Luke/Antranig/... on programming as sculpting - if there is something written down?

Our design can be seen as an interactive, structured port of the COLA architecture. This is an unexplored territory, but it is worth noting that finding the right "final design" upfront should not be necessary and is, in fact, against the spirit of the system. We aim to build an arbitrarily evolvable system that can be re-programmed and improved.

#### Alan Kay has the same vision for Smalltalk. Maybe note that, why we think his approach failed (smalltlak was too good?) and ours won't.

In order to support interactivity, structuredness and graphics, a natural place to start is a non-self-sustainable implementation platform that already conveniently supports those features. This will make it possible to start with a "blank slate" and, gradually, develop the system into a self-sustainable one. At each stage, we take stock of what changes can feasibly be achieved at the "user" level within the system, versus those that can only be achieved at the implementation level. We then ask ourselves: how can we imbue the user level with control over some of these aspects? The following sections propose key steps for evolving self-sustainability in this way, informed by our actual experience applying them in a protoype called *BootstrapLab*. We will examine the principles, heuristics, and hypotheses that motivated these steps, and reflect on their efficacy in light of actual practice.

## Concepts and terminology

#### I think "product system" is a bit confusing because we use the term "product" above to talk about end-user applications, so this can be confusing. Maybe we can refer to "end-user apps" above and keep "product" for here?

#### It would be nice to include the diagram I sketched here (if we think it can be useful for explaining things...)

To bootstrap a compiler for a programming language, one needs another programming language with a compiler before the new language compiler can be used to compile itself. With programming systems, the situation is more complicated, because we also need to consider the runtime environment.

In this essay, we use the term *product system* (or simply "the system") to refer to the programming system which we evolve towards self-sustainability. The programming system we use to get bootstrap the product system is the *producer system* (or simply "producer"). The producer system is divided into two layers; *platform* consists of all the pre-existing capabilities of the producer and *substrate* is the basis for the product system that we have to build. We use the term *in-system* to refer to changes made within the product system, by using it as a programming system at its user level.

We assume that the product system has a *state* that *changes over time*. This is necessarily the case for any interesting interactive programming system, regardless of its programming paradigm. Even in functional, declarative, reactive or logic paradigms, the evaluation or re-computation in response to interaction with a user produces a new (changed) state.

When discussing state, we refer to both the visible interface and the hidden internal state of the programming system. The state always consists of substructures such as byte arrays, object graphs or trees. Correspondingly, a change to the state can be decomposed into sub-changes that affect small part of the state. Changes to the primitive parts of the state give rise to primitive *instructions* that describe the change to the state at the finest level of granularity.

Much of this essay is concerned with choosing the right platform, designing the right substrate and choosing the notion of state and the primitive instruction. This determines how the product system can evolve, how soon can it become self-sustainable and to what extent. The design is shaped by *forces* that we aim to make explicit. We consider ways of resolving competing forces and attempt to capture the considerations in the form of *heuristics* that are pointed out throughout the essay.


# Journey itinerary
The rest of the essay documents the steps involved in designing a self-sustainable system. The sequence is a rational reconstruction. As discussed earlier, the implementation of BootstrapLab followed a more meandering path, but we believe that the following steps present an optimal pathway for bootstrapping a self-sustainable programming system:

1. **Choose a starting platform.** _The platform is a pre-existing programming system that we are happy to work in. The choice must balance one's familiarity with the platform and its distance from desired substrate features. By assumption, it is impossible or infeasible to re-program the platform at all (let alone to become self-sustainable.) Instead we will use it to create and run a product system that *is* self-sustainable._
2. **Design a substrate.** _The substrate is programmed by us on top of the platform. It defines the basic infrastructure supporting the product system: how the state is represented and changed. The design of a substrate re-uses parts of the platform where possible and extends it where necessary. We must decide which platform capabilities to use to represent the state and how to expose graphics and interaction. We design a minimal instruction set describing changes to the state, which can be represented using the state. We then use the platform to implement an engine that executes these instructions._
3. **Implement temporary infrastructure.** _Use the platform to implement tools for working with the substrate in-system, most importantly a state viewer and editor. These tools constitute the "ladder" that we will pull up behind us once it has led us to in-system implementations of these tools. Add a persistence mechanism if necessary so that progress can accumulate._
4. **Implement a high-level language.** _The substrate's instruction set (ASM) is cumbersome, so ensure programs can be expressed in-system via high-level constructs. Decide how to represent expressions as structured state and whether to interpret or compile them into ASM. Ideally, develop such an engine in ASM gradually and interactively. Alternatively, implement it at the platform level and later port it to ASM or the in-system high-level language itself._
5. **Provide for mood-specific notations.** _Port the existing state editor code to high-level in-system expressions. Use the newly-self-sustaining state editor to enter expressions for an interface optimised for editing high-level expressions. Connect this to the relevant event handlers and activate it._

What we have here looks like a Waterfall development plan, each step strictly following from the completion of the previous. This presentation is convenient as a summary, but in practice, the sequencing here need not be so rigid. Instead, adjacent steps may overlap, or we may need to prototype and revise a previous step in light of the result.

The general outline also deliberately resembles the historical development of computing's abstractions: beginning at the machine level and ascending through to higher-level languages, each time building the next stage in the current one. Indeed, our work can be seen as an attempt to reconstruct programming on top of a more structured, graphical substrate than arrays of bytes. With that in mind, let us now proceed to the first stage.

# Choose a starting platform

>The platform is a pre-existing programming system that we are happy to work in. The choice must balance one's familiarity with the platform and its distance from desired substrate features. By assumption, it is impossible or infeasible to re-program the platform at all (let alone to become self-sustainable.) Instead we will use it to create and run a product system that *is* self-sustainable.

#### I removed the "blank slate" phrase here, because the platform is not a blank slate at all (maybe - it is the "slate" itself? which is of course not blank because it is granite!)

The first step is to choose the platform that we will use as the basis for the product system. This could be any existing high-level or low-level programming language or system. There are two key factors for the choice.

First, a notable part of the bootstrapping process is done through programming features of the platform and so personal familiarity and preference is one factor. This factor plays a role during bootstrapping, but becomes irrelevant during the operation of the product system.

Second, the primitives provided by the platform influence how we can design the substrate on top of it in the next step. If we begin with a high-level platform with many convenient features, then we will have to regard them as black boxes. We may expose those as primitives in the product system, but we will not be able to re-program then in-system,  as we cannot re-program the platform! Alternatively, such imported convenient high-level features could later be re-implemented in the product using more basic primitives. This would, however, delay the point from which we can work fully in-system.

- In BootstrapLab, the platform is JavaScript, built-in Web technologies and libraries (including graphics), and the browser developer tools. The platform provides a range of convenient tools to assist bootstrapping, but we have to carefuly choose primitives to expose to the product system.
- In COLA, the platform is C \cite{OROM} or C++ \cite{COLAs} and the Unix command-line environment; in other words, the Unix programming system \cite{TechDims}.
- In early computing, e.g. Altair 8800, the platform was linear memory (state) and native CPU instruction (state change). The platform did not provide other tooling, aside from switches to manually set memory values.

*What can be changed at the user level?* At this point, there is no product system to speak of yet. This means that nothing can be changed in-system. The platform can, in principle, be modified, but we assume this is not done as part of the bootstrapping process.

# Design a substrate
>The substrate is programmed by us on top of the platform. It defines the basic infrastructure supporting the product system: how the state is represented and changed. The design of a substrate re-uses parts of the platform where possible and extends it where necessary. We must decide which platform capabilities to use to represent the state and how to expose graphics and interaction. We design a minimal instruction set describing changes to the state, which can be represented using the state. We then use the platform to implement an engine that executes these instructions.

With the *platform* defined as the already-existing programming system that we must start from, we define the *substrate* as the basic infrastructure, implemented via the platform, necessary for the product system. This substrate is the part of the system which we have control over (being programmed *by us*, unlike the platform itself) yet which we do not expect to expose from within the system. In other words, the substrate is the small non-self-sustainable core that supports the self-sustainable product on top of it.

To recap, our division is as follows:
* *Platform*: not created by us, not self-sustainable.
* *Substrate*: created by us atop the platform, not self-sustainable.
* *Product*: created by us atop the substrate, self-sustainable.

#### TODO: I think the following also needs to mention I/O which is a third thing aside from state & change that you talk about below.

The design of the substrate roughly follows the distinction between data and code, or _state_ and state _change_. Firstly, we must decide how the *state* of the system will be represented. Often, this is a matter of choosing appropriate subset of what the platform already provides. Then, we decide how primitive *changes* to that state can be described and define the instruction set.

The primitive instructions need to be themselves represented as pieces of state, a property conventionally known as homoiconicity. This condition, that primitive instructions live in the same ontology as the state, is essential: with it in place, code can be generated by programs and higher-level abstractions can be built up from the low level. This is captured by Force X below.

#### I though it would be nice to somehow pull-out this point about homoiconicity into a Force. It does not fit perfectly, but I think it is important enough. I call it Force X because I did not want to renumber all of them.

A chief consideration when designing the substrate, its state representation and instruction set is to minimize the friction between the representations. In other words, the substrate should leverage representations made possible by the platform, while the instruction representation should leverage the structuring of state provided by the substrate. For example, if the platform supports a structured representation of state, it seems appropriate to adopt structured representation for the substrate. Similarly, if the substrate represents state as trees, the instruction set should adopt hierarchical representation. This is expressed by Force 1.

**Force 0 (Compatibility): Everything should fit: instructions, high-level expressions, and graphics expressions should all it the substrate, and the substrate should fit the platform.**

**Force X (Homoiconicity): The instructions should be represented as a part of the state and should be modifiable through other instructions**

## COLA: Minimal bare-bones substrate
We first briefly discuss and evaluate the substrate design choices made in COLA, before discussing BootstrapLab in detail and briefly sketching further options. In COLA, the substrate is quite minimal and the majority is inherited "for free" from the low-level programming environment provided by the operating system.

### Low-level byte arrays
At the lowest level, state in COLA consists of an array of bytes, addressed numerically. Some structure is imposed on this via C's standard memory allocation routines, refining the model of state to a graph of fixed-size memory blocks (plus the stack). Changes to this state are represented as machine instructions encoded as bytes. This is the basic state model of a C program; the sample code for COLA embellishes this with little more than a way to associate objects to their vtables, and a cache for method lookups.

#### Explain what 'vtable' is in COLA

This bare-bones, low-level substrate does not require further development on top of the platform and so it is quicker to complete. The ontology of state is copied from the platform, and in this case the machine instructions can be inherited too. (In general, the internal representation of code in the platform will be unavailable to us when programming with it, so we expect not to be able to inherit it. This low-level platform is a special case, where we do have access to code if we are willing to write instructions using their numerical codes.) Having a quicker implementation of the substrate means we can start working in-system sooner, but there is a downside: it may be cumbersome to work with such minimal functionality. The unfortunate effect would be that we speed through a primitive substrate, only to suffer slow progress at the beginning of in-system development.
Force 1 and Force 2 capture the contrast between the two alternatives

**Force 1 (Effectiveness): Push complex features into the substrate, to avoid wasting in-system development time on them.**

**Force 2 (Simplicity): Push complex features in-system, to avoid delaying in-system development and to allow them to benefit from in-system innovation.**

#### I think it is nice to have these two forces side-by-side. We can refer to them from text later again (as I did above in the last sentence).

### Reflections on the bare-bones approach

We experienced the drawbacks of the overfocus on simplicity (Force 2) in COLA when following the sample C implementation of its object system. The code was easy enough to comprehend and compile, but what we were left with was a system living entirely in memory lacking even a command-line interface. In order to develop the system, it seemed necessary to run it in a machine-level debugger.

#### I wonder though if this is partly over-simplicity on the platform level, not substrate?

Even so, we would still be stuck in the low-level binary world which is unfriendly for humans to work with. Instead of names, we only have numbers for addressing things. Additionally, the state is *flat*. We cannot insert or grow something without physically moving other content to make space. Any structure, such as trees or graphs, has to be faked as memory blocks pointing to each other.

Historically, this was a necessity. But nowadays, we have the opportunity to leave this behind, and instead build new systems on top of a "low level" that is nevertheless *minimally* human-friendly. Even though it would be straightforward to port the above to JavaScript (just have a global array for system state), this would go against Force 0 as it would miss an opportunity to benefit from its built-in naming and structuring facilities.

**Heuristic 1 (Minimally human-friendly low-level): Ensure the substrate natively supports string names and substructures.**  
_Justification: Supporting names and substructures is a minimal response to Force 1 that still keeps the substrate simple enough and thus does not strongly conflict with Force 2._

## BootstrapLab: Simple structured substrate
For the design of BootstrapLab, we choose the Web platform and JavaScript for personal preference reasons. This imposes a number of design decisions on the substrate through the application of Force 0 and X. We then followed the Heuristic 1 when resolving Forces 1 and 2. The following presents the resulting substrate we choose for the system.

### Nested property dictionaries

The low-level state representation that satisfies Force 0 for BootstrapLab is a graph of plain JavaScript objects, acting as property dictionaries. Addresses in this context consist of an object reference and a key name. Primitive instructions are also represented as objects with properties and can leverage the structure of the state representation. A primitive instruction to copy a value of a property might look like this:

```
{
  operation: 'copy',
  from: [ alice, 'age' ],
  to: [ bob, 'age' ]
}
```

Because such instructions are also plain JavaScript objects, they can be generated and manipulated just like other state, whether programmatically or manually. This is opposed to having "two types of things"---ordinary data, and code---which must be edited, analysed, etc. using completely different tools. However, this example is not actually one of the instructions we included for BootstrapLab, as we will see shortly.

### Designing the instruction set

While the "data" half of the substrate may be easy to inherit from the platform, the "code" half is typically not. (Arrays of numerical instructions being the exception that confirms the rule.) Simply including an interpreter for source code in JavaScript is not an option, as this would embed a reliance on text and parsing in the core of the system. Slightly better would be an interpreter for the JavaScript abstract syntax tree. However, Force 2 pushes against this. A high-level language interpreter is nontrivial even without parsing and would delay our ability to work in-system. Also, an interpreter is a computer program; this program, or parts of it, might be best expressed or debugged via particular notations; by having it in the substrate, we restrict ourselves to the interface of JavaScript in our text editor.

Instead, consider what it takes to implement the interpreter for assembler, a.k.a. the Fetch-Decode-Execute cycle. We fetch the next small change to make to the state, i.e. instruction. We do a simple case-split on the opcode field; we carry out some small change to the state; rinse and repeat. With this, we can surely mirror the real-world development of higher-level languages from lower ones.

It is important to stress that this "assembler" is relative to the form of the substrate. If the substrate is binary memory, "assembler" will refer to machine instructions. But in our case of a minimally human-friendly low level (Heuristic 1), there is nothing binary about them. The instructions express operations on structured objects with names and are, themselves, represented as structured objects with names. Similarly, "imperative" just refers to the fact that the instructions are arranged in a sequence from the point of view of the interpreter, because it is easier to implement a fetch-execute cycle than, say, a resolver for a dependency graph. The above considerations lead us to Heuristics 2 and 3 as well as the speculative Hypothesis 1. The resulting instruction set for BootstrapLab, presented in Appendix\ \ref{minimal-instruc-set}, shows our execution of this heuristic.


**Heuristic 2 (Assembler paradigm): Begin from imperative assembler, as this will be quickest to implement.**
_Justification: Imperative assembler allows us to make arbitrary primitive changes to the state, using a minimal interpreter that is quick to implement.  Force 2 outweighs Force 1 here._

**Heuristic 3 (Assembler simplicity): Prefer fewer instruction types (RISC) over more instruction set (CISC), as this will be quickest to implement.**  
_Justification: Fewer instruction types reduces the size of the interpreter, making it quicker to implement. This makes programs longer, but this is soon mitigated by a high-level programming language. Force 2 outweighs Force 1 here too._

**Hypothesis 1 (Mechanicality): For any given state ontology, the instruction set of small changes can be mechanically derived.**  
_Justification: Given a state representation, it should be possible to follow Heuristics 2 and 3 to derive the minimal set of instructions that are capable of expressing all necessary primitive state changes._

#### \todo{So what's the necessary set of instruction types?} \todo{incl asm relativity} \note{If only 1 or 2, consider making anon}

### Graphics and interaction

Input and output capabilities form a third aspect of substrate design after state representation and the instruction set design. One way we wish to distinguish BootstrapLab from the related work is that graphical interfaces are present from the beginning and not just an afterthought. There are two factors here: how graphics are represented in the substrate, and how they are actually displayed. (This is analogous to the representation vs. execution of instructions.)

In fact, this is a microcosm of the entire journey: first we must select a graphics library available for our platform (i.e., the graphics *platform*.) Then we must decide how graphics are represented in our substrate (a graphics *sub-*substrate) and how these graphics actually end up on our screen.

In BootstrapLab, we chose to build off the THREE.js 3D graphics library as our platform. As for the substrate, we face an immediate choice between so-called "immediate mode" and "retained mode" conventions. In immediate mode, we draw and change graphics by issuing commands; a "code-like" approach. In retained mode, the state of the scene is represented as some structured arrangement of state. When we want to change something, we simply change the relevant part of the state and the display should automatically update.

Immediate-mode in this case could be realised by, say, exposing all the relevant THREE.js functions as special instruction types. In actuality, however, this sounded far too tedious to work with; Force 1 won out and we opted for retained mode instead. The compatibility requirement (Force 0) then dictates the rest of the design.

Consider the "flat bytes" substrate; such was the environment in which microcomputer games were programmed. In this world there is often a special region of memory, the *framebuffer*, which is treated as the ground truth of pixels displaying on the screen. To draw, programs rasterise shapes into pixels and write to the framebuffer (`POKE 1024,1` in Commodore 64 BASIC). The framebuffer has a flat structure---two-dimensional, yet not by any means nested---matching the substrate it sits within. A natural choice for retained-mode graphics representation can be found by inspecting the substrate. In case of BootstrapLab, a natural choice is not a flat "framebuffer" but a tree structure of data describing shapes and text---vector graphics.

In BootstrapLab, this is a sub*tree* of the state under the top-level name `scene`. Its content is freeform apart from several special keynames (e.g. `text` or `position`) which have graphical consequences.

Finally, to expose the platform's ability to listen for user input, a simple approach is to execute a named code sequence in the substrate from JavaScript event handlers (which now function as "device drivers"):

#### Turn this into LaTeX figure - it will look nicer than inline code.

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

**Heuristic 4 (In-state graphics): Make graphical interfaces expressible as ordinary state in a special location.**  
_Justification: Having graphics layer in substrate responds to Force 1 and Force 0 directs us to use graphical representation that fits the state representation._

#### (Example of how nested tree fields are represented vs. the visual output) TP: Does this mean "insert screenshot"? Might be a nice thing to do!
#### \todo{STILL NEED TO ACTUALLY DO THIS IN BOOTSTRAPLAB}

### BootstrapLab substrate summary

#### This needs some commentary or perhaps a figure with a table or something. It does not look like a text one can easily read...

Graph of maps. Lists are just maps with number keys. Instructions `load`, `deref`, `store`, `index`, `js`. Special part of state `scene` containing top-level scene nodes. Each may use special keys like `text`, `width`, `height`, `color`, `position`, `children` as well as abritrary other keys for user data.

*What can be changed at the user level?* System state can be modified and instructions can be executed, but only using the cumbersome capabilities of the platform. In case of BootstrapLab, this means using the JavaScript debugging console to edit object state and running a single-step function provided by the substrate. (We refer to this as the "Turing tarpit" level.)


## Smarter substrates

Even though JavaScript is a high-level language, we consider this substrate low-level *relative* to the platform below it. It largely inherits the model of state, only making simplifications. For example, JavaScript objects have prototypal inheritence, meaning that a simple "read" operation of a property requires potentially traversing a chain of objects. Our substrate here omits this, so a read is quite simple. Nevertheless, even though this substrate is minimally human-friendly, it still runs the risk that we end up lamenting its feature-light state slowing down our in-system work.

There is no limit to how fancy we could make the substrate in terms of high-level abstractions and convenient features; interested readers may consult Appendix\ \ref{appendix-crf} for examples. These would take much longer to implement and delay in-system development. Moreover, smarter substrates risk doing a lot of work that can never benefit from in-system innovation, because the substrate is not meant to be modifiable from within. (In the limit of this behaviour, we simply implement a boring old non-self-sustainable programming system with no ability to change any of its implementation!)

\note{Summary of the above: one question is whether to make the substrate bare-bones, with minimal functionality, or to make it very high-level with many features. Programming a bare substrate could be faster with less to implement, but it may make working within the system initially slow without convenient features. On the other hand, taking time to implement a very complicated all-dancing substrate risks spending too much time there before beginning to work in-system---and all the while excluding this functionality from user-level access!}


# Implement temporary infrastructure
#### \todo{asm edit? given EDSAC plaf, only option is to do this. shortcut: inherit platform interface.}

> Use the platform to implement tools for working with the substrate in-system, most importantly a state viewer and editor. These tools constitute the "ladder" that we will pull up behind us once it has led us to in-system implementations of these tools. Add a persistence mechanism if necessary so that progress can accumulate.

In most cases, the base platform will provide some way of viewing and modifying state, but this is typically inconvenient to use. The next step in bootstrapping of a self-sustainable system is thus implementing temporary infrastructure that enables us to modify the state, and develop *in-system* more conveniently.

## Early computing and COLAs

#### Maybe paste a Figure here from Wikipedia for fun: https://en.wikipedia.org/wiki/Altair_8800#/media/File:Altair_8800_and_Model_33_ASR_Teletype_.jpg

Temporary infrastructure to support in-system development can be found in many developments of self-sustainable systems. An example from the early history of computing is the Teletype loader for Altair 8800. In case of Altair, the base platform was the computer itself with its memory and native CPU instructions. The only way to modify state through the platform was through the use of hardware switches at the front of the computer, which could be used to read and set values in a given range of memory.

Programming _in-system_ by manually setting numerical instruction code via switches would be extremely tedious. To make entering programs easier, the typical first step when using the Altair 8800 was to manually input instructions for a boot loader that communicated over serial port and was able to load instructions from a paper tape. This allowed the programmers to write instructions more conveniently using a Teletype terminal and have them loaded into the Altair 8800 memory.

In COLA....

#### TODO: Say something about COLA for completeness here. I guess it does not really have much of a supporting infrastructure? If that's the case, we can say that and say that this is their fault :-) but I guess you can rely much more on the platform which has a lot of textual editing etc., so maybe you don't need more...


## BootstrapLab

On its own, our chosen platform for BootstrapLab only has one way to view parts of the state: issuing JavaScript commands via the developer console to poll a current value. This is as tedious as toggling switches on Altair. Being able to see a live view of all of the state would be a highly useful facility early on. In this case, Force 1 wins relative to Force 2 (captured by Heuristic 5) and we implemented a tree view in the substrate, based on an existing JavaScript library. State editing can continue to be done via the console (see Figure~X)

#### Reference to "Figure X" with a screenshot above.

The JavaScript tree view is a complex set of functionality set to work and display in one specific way, and all control over this resides at the platform level. The infrastructure cannot be modified from within the system. Therefore, we regard this situation as *temporary*. It is a ladder that we climb to end up in a state where we can implement a (better) state editor in-system. Once a suitable in-system editor exists, we can pull up the ladder---or as Piumarta says, "jettison\[ it\] without remorse".

#### Add a citation for Piumarta here

At this point of the bootstrapping process, the BootstrapLab's interface consists of three sections. (picture) On the right, we have the browser console, inherited through from the platform's interface. In the middle, we have the output of the platform's main graphics technology, the Document Object Model (DOM), displaying the temporary state viewer. Because we have not chosen to expose DOM control from within the system, the system only affects this area indirectly through ordinary state changes. Finally, on the left, we have the THREE.js-backed graphics window, where we will later build a state editor whose behaviour (including appearance) *will* be controlled from within the system.

Ideally, we would have actually supported interactive state *editing* in the temporary infrastructure, not just viewing. In our case, however, we accept state editing through the developer console until implementing a state editor in terms of the left-hand graphics window (see later.)

Another example of temporary infrastructure is zoom-and-pan in the graphics window. Working within a small box is very restrictive if we want to use it for viewing and editing the entirety of the system state. The finite region can be opened up into an infinite workspace by adding the ability to pan and zoom the camera with the mouse. In case of BootstrapLab, this was important to have early and so, again, Force 1 overrode Force 2 and we implemented this in JavaScript.

*What can be changed at the user level?* As before, state can be viewed and modified and instructions can be executed. This is made easier to the extent provided by the temporary infrastructure. In case of Altair 8800, instruction entry is made easier. In case of BootstrapLab, viewing the state is easier.

**Heuristic 5 (Platform editor): As soon as possible, use the platform to implement a temporary state viewer and/or editor.**  
_Justification: This temporary infrastructure will later be discarded, but given a capable enough platform, it is very easy to implement. For this reason, it is valuable to simplify further in-system development. Here, again, Force 1 outweighs Force 2._

# Implement a high-level language

> The substrate's instruction set (ASM) is cumbersome, so ensure programs can be expressed in-system via high-level constructs. Decide how to represent expressions as structured state and whether to interpret or compile them into ASM. Ideally, develop such an engine in ASM gradually and interactively. Alternatively, implement it at the platform level and later port it to ASM or the in-system high-level language itself.

The temporary infrastructure created in the preceding step may be enough to allow limited development in-system, but it does not yet provide a convenient programming environment for building a rich self-sustainable programming system that we desire. For this, one additional step is needed.

To make programming in-system truly convenient, we need a high-level programming language that executes on top of the system substrate. This means that programs and all their necessary runtime state will be stored in the system state and the execution will be done either by a compiler to the substrate's instruction set or an interpreter.

## Bare-bones self-sustainable systems

For a programming system built atop a limited platform (think Altair 8800), the temporary infrastructure may be the best tool that is available for programming. In that case, the compiler or an interpreter can be written directly using the instruction set of the substrate. However, as long as the platform has more capabilities or one has access to alternative platforms, this is not a necessity. For example, the famous high-level programming language BASIC for Altair 8800, written by Paul Allen and Bill Gates, was not written using Altair 8800, but using an Intel 8080 CPU emulator written and running on Harvard's PDP-10. The high-level language for Altair 8800 was thus developed outside the system.

In COLA...

#### Again, I think we need at least a brief paragraph on COLA

## Language for a structured substrate
If we take JavaScript, and strip away the concrete syntax, we get a resulting tree structure of function definitions, object literals, and imperative statements. A similar structure with similar semantics would be obtained from other dynamic languages. In fact, this would largely resemble Lisp S-expressions under Lisp semantics; hardly surprising considering Lisp's famously minimal syntax of expression trees. Furthermore, the evaluation procedure for Lisp is simple and well-established.

For these reasons, we design a Lisp-like tree language in the substrate. This way, we provide high-level constructs (`if-else`, loops, functions, recursion, etc.) for in-system programming. Force 0 guides us to revisit Lisp design to better fit with our substrate. Ordinary Lisp is based on lists whose entries have *implicit* meanings based on their positions. This fits with the substrate made of S-expressisons. Our substrate comes with named labels and suggests a language based around maps whose entries are explicitly *named*. We shall call it *Masp.* The following example contrasts Masp with Lisp:

#### Move this to a figure in LaTeX. I would also maybe use more verbos JSON like syntax, because figuring out the nesting rules below is not obvious. (Plus you need to have curly brackets if you want your language to take over the world, right??)

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

The equivalent Masp code is more verbose when rendered this way. However, one of our key goals is to enable the use of other, better notations if desired, which we will discuss in the next section. Here, we start from an internal representation that has *more* information (explicit named arguments) than Lisp, but we can choose to display this however we feel appropriate (perhaps by omitting name labels other than the entry being edited.)

## Choosing an appropriate implementation

There are two basic choices when implementing the high-level language. First, this can be done directly in-system using its instruction set or using richer capabilities provided by the platform (or externally). Second, the language can be either interpreted or compiled. The options are:

- **Platform interpreter** is the easiest one to implement, but it cannot be used to easily bootstrap itself. To "jettison" the platform implementation, we later need to port the interpreter to the ASM language. (Porting it to in-system high-level language would not suffice as we would still need the platform interpreter to run this.)
- **Platform compiler** is slightly harder to implement, but it is slightly easier to "jettison", because it only needs to be ported to the newly developed high-level language. (The platform implementation can compile that to ASM.)
- **In-system interpreter** is yet harder to implement, but it will exist in-system. The interpreter will, however, be less self-sustainable than if it was written in a high-level language and will likely need to be ported to a high-level language eventually. As the case of Altair 8800 BASIC shows, the implementation can leverage tools that exist outside of the system.
- **In-system compiler** is the most challenging to implement. It will allow the language to exist in-system sooner and possibly more efficiently but, as above, will likely need to be converted to a high-level programming language to allow in-system improvements.

When implementing the interpreter or compiler in-system, all its intermediate state will also be stored in-system. However, in-system state can be used even when implementing the interpreter or compiler using the platform capabilities. This is desirable as it leverages the product system for debugging and visualization and simplifies porting to in-system implementation (see Heuristic 6). The transition from platform implementation to in-system implementation can be even more gradual. Once the intermediate state is stored in-system, it becomes possible to port parts of the interpreter to in-system instructions, but invoke those from the remaining parts running outside the system.

**Heuristic 6 (In-state operation): Gradually move towards in-system representation and implementation.**  
_Justification: To ease the porting of components that exist outside of the system, the components should use the system for state representation, which allows gradual porting to in-system implementation._

#### Not sure if this resolves any forces. Maybe not? Or maybe we are missing a force...

## Implementing Masp for BootstrapLab

In BootstrapLab, we choose to implement Masp interpreter using JavaScript as this is the easiest option (following Force 2). A na\"ive implementation would simply implement the standard Lisp interpreter routines (`eval` and `apply`) to recursive JavaScript functions. However, this would miss an opportunity for visualization and debugging that is already present in our substrate. Instead, we follow Heuristic 6 and use the in-system state to store the intermediate state of the interpreter. This also makes the later in-system reimplementation of the interpreter easier as the in-system implementation will share the representation of intermediate interpreter state.

Lisp evaluation is done by walking over the expression tree. At any point, we are looking at a subtree and will evaluate it until reaching a primitive value. Ordinarily, the "current subexpression" is an argument to `eval` at the top of the stack, while the stack records our path from the original top-level expression. Since we have a tree visualisation, we use that instead of a stack. We do, however, need to maintain a reference to parent tree node in order to go back and locate the next unevaluated subexpression, once the current subexpression is evaluated. Furthermore, instead of destructively replacing tree nodes with their "more-evaluated" versions, we "annotate" the tree instead. This design choice follows Subtext\ \cite{XXX} and will make it possible to trace provenance and enable novel programming experiences.

\delete{
#### The following is sketchy and needs to be elaborated or deleted...

We choose to evaluate Masp expressions *gradually* and *non-destructively* in a subtree of the state.

...

Now we have JavaScript code for the interpretation steps, we can port it to BL-ASM.

Alternatively, we can write a compiler from Masp to BL-ASM in Masp, run this in the existing JavaScript interpreter to compile itself to BL-ASM?
}

\note{Perhaps the idea of bootstrapping abstractions from the low-level (Heuristic 2) has been refuted? Instead of writing BL-ASM in-system to build things up, it's been so tedious that I haven't touched it and instead leaped to Masp in JavaScript! It is of course still possible in principle, but the complex reality of how I did things and the design decisions I made, caused it to be uneconomical.}

*What can be changed at the user level?* At this point, the user can use a high-level language in-system for convenient programming.

#### At this point, we still have lots of things outside the system - including the tree editing and the interpreter/compiler. Do we need some extra step here to "port" everything into the system now that we have a good in-system language?? I think the "what can be changed" above is basically that you can program new things, but you cannot modify all those remaining things that exist outside of the system and that needs to be changed (possibly before alternative notations?)

# Pay off any outstanding Force 2 Debt (Substrate Debt?)
In the ideal development journey, it would feel sensible to implement the HLL and basic state editor in-system as soon as they were needed. This did not happen for BootstrapLab.

At this stage, we had a Masp interpreter using system state from JavaScript code and our temporary JavaScript state viewer. Editing took place through the console. While it would have been technically possible to achieve Masp interpretation and a state editing interface via in-system ASM, the latter was prohibitively tedious in both interface and content. In any case, it was certainly still far from supplanting the existing platform interface of JavaScript in the text editor. Continuing to use the latter was, therefore, the only sensible choice to make progress.

This did not change the fact that these features' implementation belonged in-system. That would simply have to happen later, in a bulk port from JavaScript to Masp. Thus a *substrate debt* was incurred to Force 2 which we would need to pay off.^[Conversely, if we had implemented boilerplate in-system hoping to move it to JavaScript later, this would be a debt to Force 1, but it is doubtful that this would ever happen in practice.] In general, it seems prudent to pay off such substrate debt as soon as the indebted implementation is complete. In total, we had three to pay off:

* The temporary state viewer, to be superseded
* Its replacement state editor, to be ported
* The Masp interpreter, to be ported

## Supplanting the temporary state viewer
Once we could run Masp programs in the substrate, we needed a better way of entering and editing them in the first place. We desired a state editor in the graphics window to make the existing state view obsolete. In-keeping with the proof-of-concept nature of this work, we targeted a rudimentary tree editor that nevertheless surpassed the existing practice of issuing commands in the JavaScript console. For the latter, in order to edit state, we needed to either address its parent with a full path from root, or to have previously done so and cached the result. To set a primitive value, we would type a JavaScript command including the key name and the value. This was not a high bar to clear! Evidently, we could greatly improve the experience by simply clicking on the relevant key name and typing.

We implemented a basic tree view in the graphics window; details can be found in Appendix\ \ref{treeview}. Nodes can be expanded and collapsed, and entries can be changed by clicking and typing. The display is "on-demand" and breadth-first: map entries are read upon expanding a node. This means that cycles in our graph substrate do not pose a fatal problem, as they did in the temporary state view (see Appendix \ \ref{trees-vs-graphs}). The basic CRUD operations are accounted for as follows:

* Update (primitive): The `Tab` key commits the value and selects the next entry. 
* Create: If the above runs past the end of the map, special "new entry" fields for entering a new key and value are created. These disappear if abandoned without committing.
* Update (composite): `Enter` commits a new, empty map and selects the "new entry" field within it.
* Delete: `Backspace` on an empty value will delete the entry. If it was the only entry, it will be replaced with the "new entry" field.
* Read: The display of the entry in the graphics window provides this.

It is worth noting that the Matching Principle (Force 0) applies here too: the structure of the substrate clearly has implications for the structure of the editing interface. If our substrate consisted of low-level bytes, the traditional hex editor interface would be an immediate requirement. Such an interface could plausibly be simpler to implement than the complex nested tree editing we needed for BootstrapLab. This suggests a potential feedback into the choice of substrate: a more complex substrate will require a more complex editor. We might even be tempted to conclude that it only makes sense to use a low-level substrate, since we can complete a basic editor sooner and subsequently work in-system. This neglects the fact, however, that the higher-level structures of our substrate would inevitably be required at some point. Thus we would have to do the same work anyway, but only once we had suffered through the human-unfriendly low-level substrate.

It is also remarkable that, in this restricted interaction domain, we finally *did* manage to surpass our default JavaScript text editor. There is a cost to typing out concrete syntax like `:` and `{}` for JavaScript map structures, as well as ensuring indentation is correct. For entering state structures, we found the structured editing style to be quicker. As a result, where previously we might have added new persistent state in our JavaScript startup code, we now directly entered it into the system and persisted it manually.

There is a caveat to all this. The whole exercise was in the service of paying our substrate debt from earlier---pulling up the state viewer "ladder" that had gotten us to this point. Ideally, we would have built up its replacement in-system. Yet as pointed out, JavaScript was still the most appealing way to program at this stage, so we used it for this editor as well. In other words, we took on a new debt in order to pay off the first one! To resolve it, we would port the JavaScript to Masp---a process which is underway at the time of writing for both the Masp interpreter and the state editor.

In general, at the end of this stage the substrate should not contain anything that we wanted to be modifiable in-system. Thus:

*What can be changed at the user level?* The structural "syntax" and semantics of the HLL can be changed. The graphical interface of the system can also be changed, including the concrete notation for programs and data, which we turn to next.

# Provide for alternative notations
With the editor implementation now part of the product system, we can now modify it from within to our heart's content. We admitted earlier how, in BootstrapLab, we had not managed to bring the system interface up to a level where it became more effective than JavaScript. With the implementation of a state editor, we came closer. Indeed, for entering general state structures, it is not obvious how to improve on it. Yet when it comes specifically to Masp expression structures, we must enter their verbose details even though they are highly regular and could be captured through fewer interactions. If we streamline this *subdomain* of the BootstrapLab interface, it would make Masp programming just as if not more convenient than typing JavaScript, and we could finally escape the text editor entirely.

For reasons of scope, we can only provide a restricted proof-of-concept of notational variation from within the system. We choose to target a small part of the problem: the Masp `apply` node, a frequent enough occurence that a small improvement will be helpful.

In the general state editor, one must type each of these key-value pairs for a function application:

```
apply: foo
param1: arg1
param2: arg2
param3: arg3
```

Instead, we desire something like autocomplete. Instead of typing `apply`, we press `a` and enter `foo`. Subsequent tabbing should fill in the parameter names automatically and let us type the arguments. Furthermore, as a small notational difference we will omit the word `apply`:

```
foo
param1: arg1
param2: arg2
param3: arg3
```

\todo{implement this? Speculate on how it would be achieved by poking the in-system code?}

In COLA, notational variation appears to be limited to variation in concrete syntax. Our uncompromising insistence on *graph structure* at the core of BootstrapLab, while costly in terms of interface implementation, was precisely in order to be free of such a restriction in the end. While one *could* implement a multiline text field with syntax highlighting in BootstrapLab, it is at least crystal-clear that a vast array of other interfaces are possible, unimpeded by any privileging of text strings.

# Generalising and transferring the steps

## Example: the Unix filesystem

# Conclusions \& Future Work

\note{TP: Possibly draw a diagram of what are all the things that have to match? Like code-data in substrate, substrate-highLevelLanguage etc.}

\note{TP: Also, what were the alternative routes not taken}

\weekend{Alt notations, remove temp infra, stretch: conclusion}

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

# Appendix: Tree editor
One interesting issue is the "display update" problem. For the JS tree view, we simply intercept all state updates and use `querySelector` to lookup the DOM node with the map's internal ID. Internal IDs are not currently accessible in-system, though we could provide instructions for this purpose. How, then, can we ensure that the relevant "display state" for a map entry is updated when it changes?

Even if we had an answer for this, there is a bigger problem. The DOM state is not part of the "state" of our substrate. When our state changes, this triggers a DOM state change. But the system's graphics are based on a special region of ordinary system state. Therefore, a state change will trigger another state change (to the graphics state.) What if the "graphics state" is being visualised in the tree editor? It will need to change too! And so on.

State change should cause state change (finite extent) in scene tree, if that state is visualised there.

In other words, there exists some address -> graphics node mapping (e.g. in map metadata) inside the substrate.

Analogous to Virtual Memory Management GDT, LDT descriptor tables.

Yet, this makes too much complexity e.g. the graphics tree format part of the substrate!!

Alternatively: consider the humble hex editor. It doesn't change memory, trigger a hardware interrupt, and then sync the display data to match. Causality goes not:

Edit --> Mem --> OnMemChange --> Display

But:

Edit ---> Mem
     \--> Display
     
Aha! But how do machine-level debugger GUIs work? When instructions, the OS, or whatever ... change memory, how does it notice and display the changes??

It must either re-poll everything after a run/step, or get a changelog from OS...?

Changelog could be a special part of state expected to change constantly, so we just poll it on demand. We assume it's stale by default when looking at its visual representation.
