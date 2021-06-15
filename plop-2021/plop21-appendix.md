# Appendix
The rest of our current set of technical dimensions are less complete than the three we selected above. We list them here to give an impression of the wider space we have hinted at.

## Information Loss
### Summary
At which points in the system is information irreversibly destroyed or scrambled, and which operations are reversible?

### Description
A piece of computer memory can typically be overwritten any number of times. Such writes, by default, do not set aside and save the old value beforehand; thus, information destruction is the norm. Conceptually, each cell has a history of different values, but practically only its latest value exists.

Destructive overwrites occur frequently, from ordinary incrementation of a counter to re-use of garbage-collected or freed memory blocks.

#### Provenance
When data is computed by code, a user stepping through in a debugger might know what code computed the data, but otherwise this is unknowable from the data itself. A time when this might be useful would be tracking down a bug in procedurally drawn graphics. If a shape is being drawn in the wrong way, it would be convenient if each shape had been tagged with, say, the line number of its draw call. Then one could click on the shape and immediately narrow down the relevant code.

#### Bi-directionality
Computation ordinarily proceeds uni-directionally: complex expressions are gradually reduced down to simpler values, or subroutines are invoked on input parameters to produce an output. Furthermore, intermediate values are quickly destroyed as in discarded stack frames or heap blocks.

\tp{
#### "Back button"
In HyperCard and Web.

Research idea (mention in conclusions?) motivated by this dimension is "Python with Back button"
}

## Customizability

### Summary
Considering an existing program created using the programming system, what aspects of the program can be extended and modified and in what ways is this achieved?

### Description
Programming is a gradual process. We start either from nothing or from an existing program and gradually extend and refine it until it serves a given purpose. Programs created using different programming systems can be refined to a different extent, in different ways, at different stages of their existence.

Consider three different examples. First, a program in a conventional programming language like Java can be only refined by modifying its source code. However, you may be able to do so by just adding new code, for example a new interface implementation. Second, a spreadsheet can be modified at any time by modifying the formulas or data it contains. There is no separate programming phase. However, you have to modify the formulas directly in the cell---there is no way of modifying it by specifying a change in a way that is external to the cell. Third, a programmable editor such as Emacs can be extended at runtime by writing extensions that are separate from the core system but that extend its functionality through various provided extension points.

The way a program created using a particular programming system is customizable can be illuminated through the following three characteristics.

#### Staging of customization
For programming systems that distinguish between different stages, e.g. writing source code and running a program, the ways in which a program can be customized may be different for each stage. In traditional programming languages, customization is done by modifying or adding source code at the programming stage, but there is no (automatically provided) way of customizing the created programs once they are running.

In systems where a (strict) stage distinction does not exist, programs can be customized not just during development, but also while running. For example, when running a Smalltalk program from an image that includes the programming environment, users of a program can open this and customize the program by modifying the logic behind it.

There are a number of interesting questions related to staging of customization. First, what is the notation used for customization? This may be the notation in which a program was initially created, but a system may also use a secondary notation for customization (e.g., Emacs using Emacs Lisp). For systems with a stage distinction, an important question is whether such changes are *persistent*. For example, modifying a DOM of a web page returned from a web application through Developer Tools is not normally a persistent change. Webstrates \cite{Webstrates}, however, makes exactly this kind of modification persistent by synchronizing the DOM between the server and the client. Teitelman's PILOT system for LISP \cite{Pilot} offers an interactive way of correcting errors when a program fails. Such corrections are then applied to the source code of the running program.

#### Externalizability and addressibility
A program is typically represented through some structure. This may be its source code (in conventional programming languages), a graph structure in memory (e.g., object graph in a Smalltalk image) or perhaps a document (as in spreadsheet or a Boxer program). When customizing a program, an interesting question is whether a customization needs to be done by modifying the original structure (*internally*) or whether it can be done by *adding* something alongside the original structure (*externally* \cite{Externalize}).

Examples of the former abound. A case of the latter is, for example, the Cascading Style Sheets (CSS) mechanism on the web. Given a web page, it is possible to modify (almost) any aspects of its look simply by *adding* additional rules to a CSS file. A similar effect is achieved in object-oriented programming where functionality can be added to a system by defining a new class (although injecting the new class into existing code without modification requires some form of configuration such as a dependency injection container).

When customizing programs through *external* means, the customization is done by *addressing* some aspect in the existing program and specifying additional or replacement behaviour. An important issue is how are such addresses specified and what extension points in the program can they refer to. The programming system may offer an automatic mechanism that makes certain parts of a program addressable or this task may be delegated to the programmer. In Aspect Oriented Programming (AOP) systems such as AspectJ, it is possible to add functionality to the invocation of a specific method (among other options) by using the *method call pointcut*.

### Examples

**Smalltalk, Newspeak and similar**: in programming systems derived from Smalltalk, there is generally no strict distinction between stages and so a program can be customized during execution in the same way as during development. This is typically done *internally*, i.e., by navigating to a suitable object or a class (which serve as the addressable extension points) and modifying that. LISP-based systems such as **Interlisp** follow a similar model.

**Extensible text editors** including vim, emacs and Atom: although those are not (exactly) programming systems, they serve as an interesting example. They can be modified during execution. In some, this is done using a secondary notation (explicitly designed for this purpose), but e.g., in Atom the customization is done through the same mechanism in which it is implemented (JavaScript). The customization is done *externally* by writing an extension separate from the editor itself and it can address extension points offered by the editor. For example, in case of Atom, this is an explicitly defined API, although the dynamic nature of JavaScript (and CSS) makes it possible to address other (less directly exposed) aspects of the system.

**Cascading Style Sheets**: Although not a programming system, CSS is a prime example of a system that offers external customizability with rich addressability mechanisms that is partly automatic (e.g., when referring to tag names) and partly manual (e.g., when using element IDs and class names). The Infusion project^[https://fluidproject.org/infusion.html] is a research programming system that offers similar customizability mechanism, but for behaviour rather than just styling.

**Document Object Model (DOM) and Webstrates**: In the context of web programming, there is traditionally a stage distinction between programming (writing the code and markup) and running (displaying a page). However, the DOM can be also modified by browser Developer Tools---either manually, by running scripts in a console, or by using a userscript manager such as Greasemonkey. Such changes are not persistent except in Webstrates \cite{Webstrates}, which automatically synchronizes DOM edits to the server and to all other clients viewing the page/application.

**Object and Aspect Oriented Programming**: in conventional programming languages, customization is done by modifying the code itself. OOP and AOP make it possible to do so *externally* by adding code independently of existing program code. In OOP, this requires manual definition of extension points; AOP improves on this by providing a richer addressing mechanism.

**Subtext \cite{Subtext} and Boxer \cite{Boxer}** are two example research programming systems that do not have explicit stage distinctions. Both of them represent programs as a document that is visible to the user in its entirety (called *naive realism* in Boxer), allowing the user to customize the program by finding the relevant aspect in the document and modifying it.

### Relations
*Factoring of Complexity* (Section \ref{factoring-of-complexity}): related in that "customizability" is a form of creating new programs from existing ones; factoring repetitive aspects into a reusable standard component library facilitates the same thing.
*Uniformity (Uniformity of interaction) and Feedback Loops* (Section \ref{feedback-loops}): the two of these determine whether there are separate stages for running and writing programs and may thus influence what kind of customizability is possible.

## Level of Automation

### Summary
To what extent and in what ways does the programming system remove the need to specify the program implementation in minute detail?

### Description
In order to execute a computer program, computers require a full and exact specificiation of the instructions to run. Ever since the 1940s, programmers envisioned that some form of "automatic programming" will alleviate the need for repeatedly specifying all details. The computer still requires full details today, but many aspects of the task of programming can be automated.

Automation can take a number of forms. Extracting common functionality into a library may be merely good use of *Factoring of Complexity* (Section \ref{factoring-of-complexity}), but to the user of the library, this may appear as automation. In high-level programming languages, many details are also omitted; those are filled-in by the compiler. Finally, the program may also be executed by a more sophisticated runtime that fills in details not specified explicitly, such as when running an SQL query.

#### Notations
Even with high-level of automation, programming involves manipulating some program notation. In high-level functional or imperative programming languages, the programmer writes code that typically has clear operational meaning. When using more declarative programming like SQL, Prolog or Datalog, the meaning of a program is still unambiguous, but it is not defined operationally---there is a (more or less deterministic) inference engine that solves the problem based on the provided program. Finally, systems based on programming by example step even further away from having clear operational meaning---the program may be simply a collection of sample inputs and outputs and a (typically non-deterministic) engine infers the minute details of a program based on those.

#### Degrees of automation
This analysis suggests that there are many degrees of automation in programming systems. The basic mechanism is however always the same---given a program, some logic is specified explicitly and some is left to a reusable component that can specify the details. In the case of library reuse, the reusable component is just the library. In the case of higher-level programming languages, the reusable component may include a memory allocator or a garbage collector. In case of declarative languages or programming by example, the reusable component is a general purpose inference engine.

It is worth noting that higher levels of automation require significantly more complex *reusable components* than lower levels. This is a difference between *Level of Automation* and *Factoring of Complexity*---producing systems with higher level of automation requires more than simply extracting (factoring) existing code into a reusable component. Instead, it requires doing more work and introducing a higher level of indirection between the program and the reusable component.

There is also an interesting (and perhaps inevitable?) trade-off. The higher the level of automation, the less explicit the operational meaning of a program. This has a wide range of implications. Smaragdakis \cite{NextGen} notes, for example, that this means the implementation can significantly change the performance of a program.

#### Fragmentation
An interesting issue is that reusable components that enable higher levels of automation are often specific to each system. This, arguably, limits what we can achieve as components that enable higher-levels of automation are increasingly complex to implement. As noted by Kell \cite{KellOS} \cite{Mythical}, incompatible reusable components that exist for multiple systems also limit compositionality. One possible exception from the rule is the Z3 theorem prover, which is used as an implementation mechanism by multiple programming systems including F\#.

#### Next-level automation
Throughout history, programmers have always hoped for the next level of "automatic programming". As observed by Parnas \cite{Euphemism}, "automatic programming has always been a euphemism for programming in a higher-level language than was then available to the programmer".

We may speculate whether Deep Learning will enable the next step of automation. However, this would not be different in principle from existing developments. We can see any level of automation as using *artificial intelligence* methods. This is the case for declarative languages or constraint-based languages---where the inference engine implements a traditional AI method (GOFAI, i.e., Good Old Fashioned AI).

\joel{include a definition and discussion of "boilerplate" code!}

### Relations
*Factoring of Complexity*: One typically automates the thing at the lowest level in one's factoring (by making the lowest level a thing that exists outside of the program---in a system or a library)

## Handling of errors

### Summary
What does the system consider to be an error, and how does it approach their prevention and handling?

### Description

In general, a *program error* is when the system cannot run in a normal way and needs to resolve the situation. This raises a number of questions for system design: What can cause a program error? Which program errors can be prevented from happening? How should the system react to a program error?

A computer system is not aware of human intentions. There will always be human mistakes that the system cannot recognize as errors. However, there are many human mistakes that a system can recognize. The design of a system can determine what human mistakes can be detectable program errors.

We distinguish between four kinds of errors: slips, lapses, mistakes and failures. A *slip* is a unintended error caused by a human attention failure such as a typo in source code. A *lapse* is also an unintended error, but caused e.g., by a memory failure such as an incorrectly remembered method name. A *mistake* is a logic error of the human such as bad design of an algorithm. Finally, a *failure* is a system error caused by the system itself that the programmer has no control over, e.g. a hardware or a virtual machine failure.

#### Detecting and preventing errors

Errors can be identified in any of the *feedback loops* that the system implements. This can be done either by a human or the system itself, depending on the nature of the feedback loop. Consider three examples. First, in live programming systems, the programmer immediately sees the result of their code changes. Error detection is done by a human and the system can assist this by visualizing as many consequences of a code change as possible. Second, in a system with static checking feedback loop (e.g. syntax checking, static type system), potential errors are reported as the result of the analysis. Third, errors can be detected when the developed software is run, either when it is tested by the programmer or when it is run by a user.

Error detection in different feedback loops is suitable for detecting different kinds of errors. Many slips and lapses can be detected by the static checking feedback loop, although this is not always the case. For example, a more compact *expression geography* can make it easier for slips and lapses to produce hard to detect errors. Mistakes are easier to detect through live feedback loop, but they can also be partly detected by more advanced static checking.

A common aim is to eliminate *latent errors*, i.e. errors that occur at some earlier point during execution, but will manifest themselves through an unexpected behaviour later (for example, dereferencing an incorrect memory address to obtain a value that will be stored in a database and accessed later). Latent errors can be prevented differently in different feedback loops. In the live feedback loop, this can be done by visualizing effects that would normaly remain hidden. When running software, latent errors can be prevented through a mechanism that detects errors as early as possible (e.g. initializing pointers to `null` and stopping on `null` dereferencing).

#### Responding to errors

When an error is detected by a system, there are a number of typical ways in which the system can respond. The following applies to systems that admit some kind of error detection during execution.

- A system may attempt to automatically recover from the error as best as possible. This may be possible for simpler errors (slips and lapses), but also for certain mistakes (e.g., a mistake in concurrency logic of an algorithm may often be resolved by restarting the code).
- A system may proceed as if the error did not happen. This may lead to latent errors later, but the approach may, for example, eliminate expensive checks.
- A system may ask a human how to resolve the issue. This can be done interactively, by entering into a mode where the code can be corrected, or non-interactively by stopping the system.

Orthogonally to the above options, a system may also have a way for recovering from latent errors by being able to trace back through the execution in order to find the root cause for the error. It may also have a mechanism for undoing all actions that occurred in the meantime, e.g. through transactional processing.

\note{
### Examples

- Haskell - (static loop) static checking, errors (of the slip or lapse variety) should never happen
- Sonic PI - (live loop) you get live feedback, human may choose to accept mistake and play different music; the music continues to play uninterrupted until code is changed in a valid way
- Interlisp + DWIM - (running loop) ask human what to do and let them correct things - also similar thing in Smalltalk
- Elm time traveling debugger - (running loop) tracing back through event log
- Something transactional - databases, but also the STEPS transactional thing (Warth's worlds)
- Antifragile software

### Relations
- Error detection happens at different *feedback loops*
- A system can recognize slips and lapses as errors if you have wide *expression geography*

### Papers
- Tomas - input/output error paper: https://web.eecs.umich.edu/~weimerw/2006-615/reading/goodenough-exceptions.pdf (introduced idea of exceptions i think)
- miscomputation philosophy papers, Human Error book
}

## Background Knowledge
### Summary
What background knowledge does the system demand in order to be judged on its own merit?

### Description
Every system rests on some requirement of background knowledge in order to be *learnable* in the first place. Some requirements, like literacy in a written natural language or familiarity with the de facto GUI conventions of modern computing, are easy to miss because they are so ubiquitous. But above the bare necessities for software-in-general, each system will sit on its own specific foundations that are deemed *outside of its scope* for teaching the user. These can range from widely known skills like the above, to specialist topics in mathematics, sciences or the unnamed cultural history of the system itself.

Background knowledge is not only necessary to get *benefit* from *using* the system; it is also necessary to be able to give it a truly fair *evaluation*. If someone without the necessary background attempts and fails to get the use promised by the system, this is not a point against the system (although the fact that it *does* depend on this prerequisite may be criticised). On the other hand, someone who is familiar with the background is in a position to judge the learnability of the system.

The matter is complicated, however, by the fact that a system may not give any clear outward indication of what it expects users to already know. Instead this will have to be *inferred* along the way, making it unclear whether difficulties should be attributed to newly revealed prerequisites, or to shortcomings of the system design.

Thus, to the extent that a system explicitly sets out its background knowledge, it may be judged on whether it works "as advertised". In the more common case of this being implicit, this will invite a complex debate involving what the system is for and what can be inferred about its prerequisites.

### Examples
As mentioned, familiarity with GUI items like windows, menus, buttons and text fields and their use via keyboard and mouse (or touch) is so ubiquitous a requirement for software that one may wish to declare it *universal*. The only possible exception to this may be Bret Victor's DynamicLand, which relies primarily on everyday motor skills and familiarity with physical objects. However, it appears DynamicLand is programmed in a textual programming language, so keyboard (as well as programming) familiarity may be required even there.

While the GUI is the ubiquitous background requirement for most "end-user"-facing software and also much "programming" software, programming has its own ubiquitous assumed base: the concepts and conventions of the **UNIX operating system** (more precisely, of UNIX *at the latest*---no doubt, it imported many concepts and conventions from its predecessors and contemporaries): hierarchical file systems; files as streams and vice versa; command-line argument spelling conventions; parsing and serialising of ASCII renderings of structured data.

**Spreadsheets** are notable for embodying a dataflow computation model on a greater proportion of GUI background to traditional programming:

- Instead of a textual rendering of symbolic names for variables, spreadsheets present a 2D matrix analogous to computer memory, with spatially "addressed" locations instead of named ones. This substitutes vision and spatial reasoning for abstract name management.
- Formulas, at their simplest, rest on basic arithmetical knowledge along with two extras: the de-facto ASCII names for multiplication and division (`*` and `/`), and the syntax parsing rules of traditional programming.
- More complex formulas require using functions in a semi-mathematical notation; this leverages the mathematical concept of functions and its typical notation. However, as tasks move beyond the arithmetically simple, even spreadsheets cannot avoid gradually importing more and more concepts of traditional programming (conditionals, sequencing, arrays, etc.)

\note{
More:
- Space / **Boxer** uses space because people are already familiar with space.
    - See "A principled design for an integrated computational environment" paper
    - Spreadsheets also use space.
    - Jupyter notebooks kind of do this too (not that great, but you have 1D space)
    - HyperCard is also space (stacks of cards)
    - Subtext has tree structures
    - wires - it's a graph, rendered in a space - not using the space, but graph is also ok
- Physical tools / physics metaphors
    - Springs, etc. in user interface programming
    - ToonTalk
    - Rigid bodies - Scratch shapes that you can put together in only certain ways
- Colors?
    - Used in Scratch for different types of expressions?
- Spreadsheets, Hypercard - easy to learn in a staged way; gentle learning curve
- Haskell - "after you finish your phd in category theory, join us"
- APL
- LOGO, Boxer - aimed at non-experts (trying to fit fewer things in your brain)
- BASIC / Visual Basic - encourages quick exploration
- Dan Ingal's Smalltalk (vs. Alan Kay's Smalltalk)
- akkartik's Mu: https://github.com/akkartik/mu
- STEPS project - tries to have few enough lines of code so that you can understand it. Mention the "churn" of pointless boilerplate "background knowledge" of how the overcomplicated code is organised and architected, and how STEPS seeks to reduce this


### Relations
- Learnability
- "Does it fit a single brain" (if we decide to keep that as a dimension)

### References
- ["A principled design for an integrated computational environment" (Boxer paper)](https://sci-hub.se/https://www.tandfonline.com/doi/abs/10.1207/s15327051hci0101_1?journalCode=hhci20)

}

## Factoring of complexity
### Summary
What are the primitives? How can they be combined? How is *common structure* recognised and utilised?

### Description
There is a large space of possible things we might want to do with a system. The question is, how do we "get" to all the possible locations in this space? We can have a very flat structure where different tools, methods or features are used to reach individual points in this space. We can also have a more structured approach where we need to compose individual components to "get" to individual locations.

#### Composability
In short, *you can get anywhere by putting together a number of smaller steps.* There exist building blocks which span a range of useful combinations. Such a property can be analogised to *linear independence* in mathematical vector spaces: a number of primitives (basis vectors) whose possible combinations span a meaningful space. Composability is, in a sense, key to the notion of "programmability" and every programmable system will have some level of composability (e.g. in the scripting language.)

#### Convenience
In short, *you can get to X, Y or Z via one single step.* There are ready-made solutions to specific problems, not necessarily generalisable or composable. Convenience often manifests as "canonical" solutions and utilities in the form of an expansive standard library.

Composability without convenience is a set of atoms or gears; theoretically, anything one wants could be built out of them, but one must do that work.

Composability *with* convenience is a set of convenient specific tools *along with* enough components to construct new ones. The specific tools themselves could be transparently composed of these building blocks, but this is not essential. They save users the time and effort it would take to "roll their own" solutions to common tasks.

#### Commonality
Humans can see Arrays, Strings, Dicts and Sets all have a “size”, but the software needs to be *told* that they are the “same”. Commonality like this can be factored out into an explicit structure (a “Collection” class), analogous to database *normalization*. This way, an entity's size can be queried without reference to its particular details: if `c` is declared to be a Collection, then one can straightforwardly access `c.size`.

Alternatively, it can be left implicit. This is less upfront work, but permits instances to **diverge**, analogous to *redundancy* in databases. For example, Arrays and Strings might end up with “length”, while Dict and Set call it “size”. This means that, to query the size of an entity, it is necessary to perform a case split according to its concrete type, solely to funnel the diverging paths back to the commonality they represent:

```
if (entity is Array or String)  size := entity.length
else if (entity is Dict or Set) size := entity.size
```

#### Flattening and Factoring
Data structures usually have several "moving parts" that can vary independently. For example, a simple pair of “vehicle type” and “colour” might have all combinations of (Car, Van, Train) and (Red, Blue). Here, we can programmatically change the colour directly: `pair.second = Red` or `vehicle.colour = Red`.

In some contexts, such as class names, a system might only permit such multi-dimensional structure as an *exhaustive enumeration*: RedCar, BlueCar, RedVan, BlueVan, RedTrain, BlueTrain, etc. The system sees a flat list of atoms, whereas the user can see the sub-structure encoded in the string. Now we cannot just “change the colour to Red” programmatically; we would need to case-split as follows:

```
if (type is BlueCar) type := RedCar
else if (type is BlueVan) type := RedVan
else if (type is BlueTrain) type := RedTrain
...
```

Thus we say there is implicit structure here that remains *un-factored*, similar to how numbers can be expressed as singular expressions (16) or as factor products (2,2,2,2).

### Examples
In relational databases, there is an opposition between *normalization* and *redundancy*. When data is duplicated in order to fit into a flat table structure, there is the corresponding redundancy. When data is factored into small tables as much as possible, such that there is only one place each piece of data "lives", the database is in *normal form* or *normalized*. Redundancy is useful for read-only processes, because you do not need joins. But it makes writing risky, because you need to modify one thing in multiple places.

\note{
In some sense every "library" is at the very least a collection of "diagonals", which may in some cases also be orthogonal/independent in a higher-dimensional space! :)
     - Here is how something can be both orthogonal and diagonal at different levels:
     - The system gives us the vector (4, 3). On its own, the only "configuration" it has is that it can be scaled by a single parameter.
     - The system gives us (4,3) and (-1, 7). These aren't "orthogonal", but they are *independent* and they do span the 2D space; they can be configured and combined to jointly produce any point in the space.
     - The system gives us (4,3,0) and (0,0,1). The original 2D space (x-y plane) is still off-limits to us, so (4,3,0) is still "diagonal" in that space. However, these two do span a different plane in the larger space; they are *independent* here and can combine here if not in the xy plane.
 - UNIX tools: Orthogonal (tools), compositional (pipes), diagonal (aliases, individual command-line args)
 - Programming languages
     - perl (diagonal only)
     - python (aims to be normalized ["TOOWTDI"](https://wiki.python.org/moin/TOOWTDI))
     - Haskell
         - this is an effect of not just a programming language, but also culture. E.g. there is no reason why Haskell needs to be so orthogonal - you could design core libraries to be much more redundant and the language would allow for that. (Because of the maths influence, and maths / logic is highly normalized)
 - Hypercard
     - At the level just before writing code, it has a diagonal (noncomposable) structure - you can choose from a long list of commands that you can assign to a button.
 - Web APIs e.g. onmousedown/onmouseup, imperative onmousemove instead of reified mouse pointer observable (this belongs more in a Factoring of Structure / Complexity dimension...)
   - tbh this is also a "machine legibility" issue; a human can recognise onmousemove and onmousedown as having something in common -- "mouse" -- but the computer just sees two non-equal strings as different as zQx6= and omlette.
   - onmousedown further makes the *mouse* part explicit, but the sub-device -- the button -- is passed as a numerical argument. ...
   - What really annoyed me, and seems most relevant, is that mouse buttons and keyboard keys the same in a very significant way -- they're binary-state buttons -- which means they ought to "implement the same interface", so the system will let me treat them the same insofar as they have commonalities like this. It should be trivial to rebind keyboard keys to the mouse buttons or vice versa, but this "poor factoring" obstructs this.
   - viz. OOP interfaces and abstraction, this factoring is forcing you to rely on irrelevant concrete details of the object. Instead of `if (isMouseButton) listenMouseButton(fn) else if (isKey) listenKey(fn)`, it should just be `listen(fn)`.
   - Contra FRP.
 - Visual substrates
     - Sketch-n-sketch - redundancy (you have both UI and code view, synchronized)
     - Flash - no redundancy (you have UI and code, but they are about different things)
 - Smalltalk
    - non-diagonality - everything is an object, e.g. Booleans having ifTrue, ifFalse?


### Relations
- Substrates text/vis - see flash & sketch-n-sketch example
- Expressive power - orthogonality is key
- Uniformity of representation
- Background knowledge - if we assume some, we can use it in a metaphor
- Notational structure - you can have different approaches for different notational levels

### References
- http://www.cs.bc.edu/~muller/teaching/cs102/s06/lib/pdf/api-design?spm=ata.13261165.0.0.38067cd1w5lGp5
- notes on post-modern programming
- Organizing metaphors -> Lakoff
- Inductive Combination in Olsen 2007 UIST paper
}

## Abstraction mechanisms

### Summary
What is the relationship between concrete and abstract in the system? What are the different abstraction mechanisms supported by the system? How are abstract entities created from concrete things and vice versa?

### Description
Abstraction refers to deriving general concepts from specific examples. An *abstraction* is the result of such process. Almost all programming systems support some kind of abstraction. This is necessary, because we often want to instruct the computer to perform the same operation on multiple different inputs or produce many things using the same schema. This dimension captures what is the nature of *abstractions* used in the programming system, how are they created, modified and used.

#### Constructing abstractions
As suggested above, abstractions can be constructed from concrete examples, first principles or through other methods. A part of the process may happen in the programmer's brain---for example, they can think of concrete cases and use that to come up with an abstract concept and then directly encode the abstract concept in the programming system. But a programming system can directly support different ways of producing abstractions.

One option is to construct abstractions *from first principles*. Here, the programmer starts by defining an abstract entity such as an interface in object-oriented programming languages. To do this, they have to think what the required abstraction will be (in the brain) and then encode it (in the system).

Another option is to construct abstractions *from concrete cases*. Here, the programmer uses the system to solve one or more concrete problems and, when they are satisfied, the system guides them in creating an abstraction based on their concrete case(s). This can be done in a programming language (e.g., through refactoring like extract function & adding a parameter), but also through other approaches (e.g., a form of macro recording)

\note{
#### Encapsulation or transparency
To what extent are abstract things hidden and protected from being manipulated?

> This is going to be a reference to "addressability" (or whatever we call it) dimension
>
#### Higher-order

> TODO: Merge important bits from "higher-order" in self-sufficiency into this
> (clear in PLs, but no obvious representation of higher-order in visual systems)
> Also hard to reason about this statically (c.f. thegamma)
}

### Examples

**Pygmalion**: In Pygmalion \cite{Pygmalion}, all programming is done by manipulating concrete icons that represent concrete things. To create an abstraction, you can use "Remember mode", which records the operations done on icons and makes it possible to bind this recording to a new icon.

**Jupyter notebook**: In Jupyter notebooks, you are inclined to work with concrete things, because you see previews after individual cells. This discourages creating abstractions, because then you would not be able to look inside at such a fine grained level.

**Spreadsheets**: Up until the recent introduction of lambda expressions into Excel, spreadsheets have been relentlessly concrete, without any way to abstract and reuse patterns of computation other than copy-and-paste.

\note{
### Relations
- Factoring of Complexity: abstractions are key for enabling normalization (unless it's all built in)
- notational strucutre - abstractions are typically done at a level of individual notations
- self-sufficiency cluster - provides ways for building abstractions (like higher-order, maybe reflection, etc.)

### References
- Abstraction gradient cognitive dimension
}

## Learnability and Sociability

### Summary
How does the system facilitate or obstruct adoption by both individuals and communities? Individual adoption is facilitated by designing the system to be easily learned by a targeted audience. Community adoption is less about technical issues and more about economic/social/cultural factors that are harder to design for. One important factor is the tenor of online communities, whose norms are best established at the start.

### Description
Human and social factors greatly affect the extent to which a technology is used. Even the simplest software technologies require substantial effort to learn. All else equal, a technology that is easier to learn is more likely to be adopted. Individuals with free choice will decide whether the learning investment is worth the benefits. We can make a technology more learnable in several ways:

- Specialize to a specific domain of usage or population of users.
- Design for teaching beginners rather than professional usage.
- Stage levels for learners to advance through.
- Provide more scaffolding and faster feedback in the programming experience.
- Reduce the number of things that need to be learned by unifying concepts (See Orderliness, Section \ref{orderliness}).

However social factors can easily override individual ones. Our increasing appreciation of the importance of social factors leads us to discuss software technolgies in terms of communities. The nature of the community can be the decisive factor in adopting a technology. How big and old is the community? Do we feel safe that future problems will be solved and new requirements will be met? Do we feel the community shares our values and that we belong in it? Does it give us purpose and meaning? We cannot claim to have a good understanding of how to design a sociable programming systerm, but we do observe a number of factors that have been important historically:

- Easy integration into existing technology stacks, allowing incremental adoption, and also easy exit if needed.
- Contrary to the previous point, a cloistered community that turns its back on the wider world can give its members string feelings of belonging and purpose. Examples are Smalltalk, Racket, Clojure, Haskell. These communities bear some resemblance to cults, including guru-like leaders. As such we can expect them to last a long time, but to always remain a fringe counter-culture to the mainstream.
- Backing by large corporations or large capital investments to ensure longevity.
- Making the limits of the technology clear up front, so that adopters are not led astray. For example, no one expects spreadsheets to create web apps. On the other hand, many “no-code” systems have vague and shifting limits.
- Easy sharing of code via package repositories or open exchanges. Prior to the open source era, commercial marketplaces were important, like VBX components for VisualBasic.
- Avoiding fragmentation into sub-communities by establishing standard libraries and practices. Scheme and Haskell are counter-examples. See the Lisp Curse \cite{LispCurse}.
- Establishing an online community that is welcoming and supportive of newcomers. This is best done by setting community norms from the beginning, as they can be intractable to change later. A good example of this is Elm.

### Examples
- Spreadsheets, HyperCar:- Small self-sufficient systems that can be mastered in a matter of months.
- Logo, Boxer, Basic, Pascal, Scratch: Designed primarily for teaching, prioritizing simplicity.
- HyperCard, Racket: Levels of progressively increasing complexity to assist learning
- Live programming research: offload programmers from having to simulate execution in their head. See Bret Victor, Christopher Fry
- Python, Ruby, Elm: PLs that prioritize friendliness to beginners, both technically and in community norms. Leadership that is self-effacing.
- LISP, Scheme, Haskell: Math-like languages appealing strongly to certain people but repelling the general public, along with a culture that celebrates the divide.
- Software ecosystems: VisualBasic VBX marketplace. Package managers: CPAN, RubyGems, npm. Scratch website.
- Elm: an intentionally sociable PL. Friendly error messages, a dramatic usability improvement over other ML-like languages - not technically hard, but the other language communities never cared enough to fix it. Principled exclusion of unsafe features that can cause runtime errors, to the point of breaking external interoperability. Prioritized establishing friendly community norms from the beginning.

\note{
### Relations
Coherence vs Compatibility and Pluralism
Feedback Loops


### References
- Myerovich & Rabkin: Socio-PLT: Principles for Programming Language Adoption   https://parlab.eecs.berkeley.edu/sites/all/parlab/files/Socio-PLT.pdf
- Lisp Curse [http://www.winestockwebdesign.com/Essays/Lisp\_Curse.html]
- Evan Czaplicki “What is Success” [https://www.youtube.com/watch?v=uGlzRt-FYto]
- [Programming on an already full brain](https://dl.acm.org/doi/10.1145/248448.248459)
- Bret Victor Learnable Programming
}
