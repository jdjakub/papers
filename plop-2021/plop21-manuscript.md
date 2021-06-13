The Technical Dimensions of Programming Systems

\begin{abstract}
Programming systems often go beyond programming languages. Programming is often done in the context of a stateful environment, through graphical user interface, by interacting with the system rather than just by writing code. Much research effort focuses on building programming systems that are easier to use, accessible to non-experts, moldable and/or powerful, but such efforts are often disconnected. They are informal, guided by the personal vision of the authors and thus are only evaluable and comparable on the basis of individual experience using them. In other words, they fail to form a coherent body of research. It isn't clear how to build on what has been done. Much has been said and done that allows comparison of _programming languages_, yet no similar theories exist for _programming systems_. We believe that programming systems deserve a theory too. We examine some influential past programming systems and review their stated design principles, technical capabilities and styles of user interaction. We propose a framework of _technical dimensions_, which captures the underlying system characteristics and provide a means for conceptualising and comparing programming systems. We thus break the holistic view of programming systems down into characteristics that can be compared or advanced independently. It makes it possible to talk about programming systems in a way that can be shared and agreed or constructively disagreed upon, rather than relying just on individual experience of using them. The aim is to bring programming systems into the focus of programming research by providing the foundations that allow such research to proceed in a more systematic way. In other words, we want to allow the designers of future programming systems to (finally) stand on the shoulders of the giants.

\end{abstract}

# Introduction

\note{We should also make sure "programming system" includes the whole lifecycle (think UNIX but also magic deploy-to-cloud-apps)}

Many forms of software have been developed to enable "programming". The classic form is *programming languages*, differentiated by syntax, semantics of abstract tree transformations, and implementation techniques. Since the advent of the GUI, languages can often be found embedded within a graphical "application" and dependent on its context, but the GUI also permits the novelty of "visual" programming (non-)languages. We call examples of any of these forms, or combinations thereof, *Programming Systems*. Evidently, the tools and interfaces supporting languages form a part of such a landscape, and the languages "themselves"---abstracted from this implementation context---a still smaller part.

There is an increasing interest in (non-language) programming systems. Researchers are increasingly studying topics such as _programming experience_ and _live programming tools_, as instances like Replit and Dark become more popular. Yet, this line of research remains on the side. While PLs are a well-established area, analysed and compared in a common vocabulary, no similar foundation exists for the wider range of programming systems.

## What is the problem
As soon as we add interaction (command-line or otherwise) or graphics to these objects of study, all we can say is that they are vaguely "cool" or "interesting". When designing new systems, inspiration is often drawn from same few somewhat disconnected sources of ideas. These include programming systems from the 1970s such as Smalltalk, programmable end-user applications like spreadsheets, and motivational illustrations by Bret Victor. Instead of forming a solid body of work, the ideas that emerge are difficult to relate to each other. Similarly, the research methods used to study programming systems lack the more rigorous structure of programming language research methods. They often rely on singleton examples that may demonstrate the ideas of the author, but make it impossible to compare their work to that of the others and advance the state of the art by building on it.

## Contributions
We propose a new common language as an initial, tentative step towards more progressive research on programming systems. Our pattern language of "Design Dimensions for Programming Systems" seeks to break down the holistic view of systems along various specific "axes": verbal conceptual prompts inspired by the Cognitive Dimensions of Notation \cite{CogDims}. While not strictly quantitative, we have designed them to be narrow enough to be comparable, so that we may say one system has more or less of a property than another. Generally, we see the various possibilities as tradeoffs and are reluctant to assign them "good" or "bad" status. If the framework is to be useful then it must encourage some sort of rough consensus on how to apply it; we expect it will be more helpful to agree on descriptions of systems first, and settle normative judgements later.

The set of dimensions can be understood as a map of the design space of programming systems. Past and present systems will serve as landmarks, and with enough of them, unexplored or overlooked possibilities will reveal themselves. So far, the field has not been able to establish a virtuous cycle of feedback where practitioners are able to situate their work in the context of others' for subsequent work to improve on. Our aim is to provide foundations for the study of programming systems that would allow such development.

1. We propose an initial set of design dimensions of programming systems, and discuss in detail three: Feedback Loops, Notational Structure, and Coherence vs. Compatibility and Pluralism.
2. We define these dimensions by reference to landmark programming systems of the past, and discuss the tradeoffs between them.
3. We evaluate the salience of these dimensions by applying them to example systems from both the past and present. We situate some experimental systems as explorations at the frontier of certain dimensions.
  - Pygmalion \cite{Pygmalion}, Dark, Glide, Sketch-n-sketch \cite{SnS}, Subtext \cite{Subtext}, Boxer \cite{Boxer} and Flash (both mostly similar to HyperCard)

\note{5. We identify limitations and needed future work.}

# Related work

## Which "systems" are we talking about?

The programming systems that shape our framework come from a few recognisable clusters:
- "Platforms" supporting arbitrary software ecosystems: UNIX, Lisp, Smalltalk, the Web
- "Applications" targeted to a specific domain: spreadsheets
- Mixed aspects of platform and application: HyperCard, Boxer, Flash, and PL workflows

Richard Gabriel noted a "paradigm shift" \cite{PLrev} from the study of systems to the study of languages in computer science, which informs our distinction here. One consequence of the change is that a *language* is often formally specified apart from any specific implementations, while *systems* resist formal specification and are often *defined by* an implementation. We do, however, intend to recognise programming languages as a small part of the space of possible systems. Hence we refer to the *interactive programming system* aspects of languages, such as text editing and command-line workflow.

Our "system" concept is mostly technical in scope, with occasional excursions as in "Learnability & Sociability" (#). This contrasts with the more socio-political focus found in \cite{TcherDiss}. It overlaps with the conceptualization in \cite{KellOS}, including UNIX within its remit. We do not extend it to systems distributed over networks, although our framework may still be applicable there.

## Industry and research interest in programming systems
There is renewed interest in programming systems in both industry and research. In industry we see:
- Computational notebooks such as [Jupyter](https://jupyter.org/) that make data analysis more amenable to scientists by combining code snippets and their numerical or graphical output in a convenient document format.
- “Low code” end-user programming systems that present a simplified GUI for developing applications. One example is [Coda](https://coda.io/welcome), which combines tables, formulas, and scripts to allow non-technical people to build “applications as a document”.
- Specialized programming systems that augment a specific domain. For example [Dark](https://darklang.com/), which creates cloud API services with a “holistic” programming experience including a language and direct manipulation editor with near-instantaneous building and deployment.
- Even for general purpose programming with conventional tools, systems like [Replit](https://replit.com/) have demonstrated the benefits of integrating all needed languages, tools, and user interfaces into a seamless experience available from a browser with no setup.

In research there are an increasing number of explorations of the possibilities of full programming systems:
- Subtext \cite{Subtext}, which combines code with its live execution in a single editable representation
- Sketch-n-sketch \cite{SnS}, which can synthesize code by direct manipulation of its outputs
- Hazel \cite{Hazel}, a live functional programming environment featuring typed holes that allow execution of incomplete or type-erroneous programs.

Several research venues investigate programming systems:
- [VL/HCC](https://conferences.computer.org/VLHCC/) (IEEE Symposium on Visual Languages and Human-Centric Computing)
- The [LIVE programming](https://liveprog.org/) workshop at SPLASH
- The [PX](https://2021.programming-conference.org/home/px-2021) (Programming eXperience) workshop at <Programming>

## Related Methodology

There are several existing projects identifying characteristics of programming systems. Some of these revolve around a single one, such as levels of liveness \cite{Liveness}, plurality and communicativity \cite{KellComm}. Others propose an entire collection, as do we. [Memory Models of Programming Languages]() identifies the "everything is an X" metaphors underlying many programming languages. [The Design Principles of Smalltalk]() documents the philosophical goals and dictums used in the design of Smalltalk. The original [Design Patterns]() names and catalogues specific tactics within the *codebases* of software systems. The Cognitive Dimensions pf Notation \cite{CogDims} introduces a common vocabulary for software's *notational surface* and shows how they trade off and affect the performance of certain types of tasks.

Of these sources, the latter two bear the most obvious influence on our proposal. Our framework of "technical dimensions" continues the approach of the Cognitive Dimensions to the "rest" of a system beyond its notation. The individual dimensions naturally fall under larger clusters which we present in the Patterns style. As for characteristics identified by others, part of our contribution is to integrate them under a common umbrella. Liveness, pluralism and uniformity metaphors ("everything is an X") are incorporated as dimensions that have been already identified by the related work.

We follow the attitude of \cite{EvProgSys} in distinguishing our work from HCI methods and empirical evaluation. We are generally concerned with characteristics that are not obviously amenable to statistical analysis (e.g. mining software repositories) or experimental methods like controlled user studies, so numerical quantities do not make an appearance.

Similar development seems to be taking place in HCI research focused on user interfaces. The UIST [guidelines](https://uist.acm.org/uist2021/author-guide.html) instruct authors to evaluate system contributions holistically and the community has developed heuristics for such evaluation, such as \cite{EvUISR}. Our set of dimentions offers similar heuristics for identifying interesting aspects of programming systems, though they focus more on underlying technical properties than the surface interface.

In sciences like physics, superseded theories made predictions that were eventually falsified by the world they tried to model. Yet much of *computing* involves creating custom "worlds" with their own rules, so the judgement cast by supercession is rather less final. Following Chang's \cite{Chang} "Complementary Science" approach, our attention is drawn to historical systems that have been superseded, forgotten, or largely ignored---a "Complementary Computer Science".

## What we are trying to achieve
In short, while there is a theory for programming languages, programming *systems* deserve a theory too. It should apply from the small scale of language implementations to the vast scale of operating systems. It should be possible to analyse the common and unique features of different systems, to reveal new possibilities, and to build on past work in an effective manner. In Kuhnian terms, it should enable a body of "normal science": filling in the map of the space of possible systems, forming a knowledge repository for future designers.

# History of programming systems
Here, we will present a brief and incomplete history of programming systems. This serves two purposes. First, looking at a number of examples from the past helps build an intuitive understanding of what we mean by a programming system. Second, it allows us to introduce example systems that we will use in the next section to illustrate the individual technical dimensions.

## Time sharing and personal computers
Two historical developments enabled the rise of programming systems: development of time-sharing systems in the 1960s, and cheaper computers that could be owned by individuals in the 1970s. With time-sharing, multiple users could connect to a single machine and use it interactively.

### Interlisp
Interlisp took full advantage of this mode of working. Interaction occured through the teletype at first, later giving way to the screen and keyboard. Even on the teletype, the system incorporated a number of ideas that remain popular with programming systems today. Interlisp did not separate program code from program state. Both were a part of the same environment (or an _image_) and could be accessed and modified interactively using the same means. This made it possible to interactively correct errors. For example, when the system encountered an undefined symbol, it would ask the user and correct the code based on the answer. Interlisp also featured a structure editor to work with S-expressions not as a sequence of characters, but as nested lists. The programmer used commands such as `*P` to print the current expression, or `*(2 (X Y))` to replace its second element with the argument `(X Y)`.

### Smalltalk
Smalltalk, which appeared in the 1970s, shared much with Interlisp. In particular, it was interactive and used a similar environment to make program code part of program state. Smalltalk was designed for single-user machines with graphical display. This interface was used not only for the obvious graphical applications, but also to provide easy access to all objects and their methods through the object browser. The fact that much of the environment was implemented in itself made it possible to significantly modify the system from within; we call this "self-mutability" (#).

### UNIX
Both Interlisp and Smalltalk worked, to some extent, as operating systems. The user started their machine directly in the Interlisp or Smalltalk environment and was able to do everything they needed from *within* the system. This explains why it is worth considering (especially programmer-oriented) operating systems as programming systems as well. UNIX, which appeared in the 1970s as a simpler operating system for time-sharing computers, is a prime example.

As we discuss later under "Learnability & Sociability" (#), many aspects of programming systems are shaped by their intended target audience. UNIX was built for computer hackers themselves and, as such, its interface is close to the machine. While everything is an object in Smalltalk, the ontology of the UNIX system consists of files, memory, executable programs and running processes. Interestingly, there is an explicit stage distinction here, that is not present in Smalltalk or Interlisp. The ontology, however, enables an open pluralistic environment.

## Early application platforms
The previously discussed programming systems did not focus on any particular kind of application. They were universal. As computers became more widely used, it became clear that there are typical kinds of applications that need to be built. For those, more specialized programming systems began to appear. Although these are more focused, they also allow programming based on rich interactions with specialized visual and textual notations.

### Spreadsheets
Spreadsheets were, alongside with word processors, the application that turned personal computers from playthings for hackers into a business tool. The first system, VisiCalc, became available in 1979 and allowed analysts to perform budget calculations. Spreadsheets developed over time, acquiring features that made them into powerful programming systems in a way VisiCalc was not. The final step was the inclusion of macros (Visual Basic for Applications) in Excel in 1993. As programming systems, spreadsheets are interesting thanks to their programming substrate (a grid) and evaluation model (automatic re-evaluation).

### HyperCard
While spreadsheets were designed to solve problems in a specific application area, the next system we consider was designed around a particular application format. 1987 saw HyperCard, with programs as "stacks of cards" containing multimedia components and controls such as buttons. The logic associated with the controls can be defined using a range of pre-defined operations (e.g. "navigate to another card") or using the HyperTalk scripting language.

As a programming system, HyperCard is interesting for a couple of reasons. It effectively combines visual and textual notation. Programs appear the same way during editing as they do during execution. Most notably, HyperCard supports gradual progression from user to a developer. A user may first use stacks, then they may edit the visual aspects or choose pre-defined logic until, eventually, they learn to program in HyperTalk.

## Developer ecosystems
Programming systems such as Smalltalk and HyperCard are relatively *self-contained*. It is clear what is a *part of* the system, and what is on the *outside*. For many systems that began to appear in the late 1980s, this is not the case. To think about them, we have to consider a number of components, some of which may be conventional programming languages.

### Early and late Web
The Web appeared in 1989 as a way of sharing and organizing information, implementing the ideas of *hypertext*. The web gradually evolved from an *information sharing* system to a *developer platform* when client-side scripting using JavaScript became possible. The Web ecosystem started to consist of server-side and client-side programming tools. In the 1990s, the "early Web" became a widely used programming system. JavaScript code was distributed in a form that made it easy to copy and re-use existing scripts, which led to enthusiastic adoption by non-experts. This is comparable to the birth of microcomputers like Commodore 64 with BASIC a decade earlier.

The Web ecosystem continued to evolve. In the 2000s, multiple programming languages started to treat JavaScript as a compilation target, while JavaScript started to be used as a programming language on the server-side. This defines the "late Web" ecosystem, which is quite different from its early incarnation. JavaScript code was no longer simple enough to whimsically copy and paste, yet advanced developer tools provided functionality that is unlike many other programming systems. The DOM structure created by a web page is transparent, accessible to the user and modifiable through the built-in browser debugging tools. Third-party code to modify the structure can be injected via extensions. The DOM also inspired research projects: Webstrates \cite{Webstrates} synchronizes DOM edits made in the browser to all other clients connected to a single server. The Web combines the notations of HTML, CSS and JavaScript as well as many languages that compile to JavaScript.

### REPLs and notebooks
Another kind of developer ecosystem that evolved from simple scripting tools are the modern tools for data science, such as Jupyter (#). Their roots date back to interactive programming tools like Interlisp, where users could type commands to be evaluated and see the results printed. This interaction became known as the REPL (Read-Eval-Print Loop). In the late 1980s, Mathematica 1.0 combined the REPL interaction with a notebook document format that shows the commands alongside visual outputs.

Today, REPLs exist for many programming languages. Unlike in Interlisp, they are often separate from the running program. REPLs often maintain an execution state independent of a running program and there are many strategies for prototyping code in a REPL before making it a part of an ordinary compiled application.

Notebooks for data science are a particularly interesting example. Their primary output is the notebook itself, rather than a separate application to be compiled and run. The code lives in a document format, interleaved with other notations. Code is written in small parts that are executed (almost) immediately, offering the user more rapid feedback than in conventional programming. Finally, a notebook can be seen as a trace of how the result has been obtained, providing a way of retracing the individual execution steps.

### Haskell and other languages
The aforementioned 1990s paradigm shift from thinking about _systems_ to thinking about _languages_ means that researchers tend to emphasize the language side of programming. However, all programming languages are a part of a richer ecosystem that consist of editors and other tools. In our analysis, we choose Haskell as our example, as this is arguably the most language-focused programming system.

Like most programming languages, Haskell code can be written in a wide range of text editors, some of which support assistance tools such as syntax highlighting and auto-completion. These offer immediate feedback while editing code, such as when highlighting type errors. This way, "lapse" and "slip" type errors are mitigated---we discuss this further under "Handling of Errors" (#).

Haskell is mathematically rooted and relies on mathematical intuition for understanding many of its concepts. This background is also reflected in the notations it uses. In addition to the concrete language syntax (used when writing code), the Haskell ecosystem also uses an informal mathematical notation, which is used when writing about Haskell (e.g. in academic papers or on whiteboard). This provides an additional tool for manipulating Haskell programs and experimenting with them on paper (_in vitro_), in ways that other systems may attempt to achieve through experimentation within the system (_in vivo_).

# Technical Dimensions
For brevity, we present three technical dimensions from our current list, the rest of which can be found in the Appendix. These are Feedback Loops, Notational Structure, and CCP.

## Feedback Loops
### Summary
How do users execute their ideas, evaluate the result, and generate new ideas in response?

### Description
An essential aspect of programming systems is how the user interacts with them when creating programs. In the basic form, programmers write their code in a text editor, invoke the compiler and then read through error messages they get.  Other forms are possible, and to analyze them, we use the concepts of _gulf of execution_ and _gulf of evaluation_ from \cite{Norman}.

#### Gulfs of execution and evaluation
In using a system, one first has some idea and attempts to make it exist in the software; the gap between the user's goal and the means to execute the goal is known as the *gulf of execution*. Then, one compares the result actually achieved to the original goal in mind; this crosses the *gulf of evaluation*. These two activities comprise the *feedback loop* through which a user gradually realises their desires in the imagination, or refines those desires to find out "what they actually want".

A system must contain at least one such feedback loop, but may contain several at different levels or specialised to certain domains. For each of them, we can separate the gulf of execution and evaluation as independent legs of the journey, with possibly different manners and speeds of crossing them.

#### Immediate Feedback
\tp{What about the gulf of execution in this case? I guess this is not relevant, because you may still have poor ways of doing what you want despite having immediate feedback. Maybe worth saying this here?}

The specific case where the *evaluation* gulf is minimised to be imperceptible is known as *immediate feedback*. Once the user has caused some change to the system, its effects (including errors) are immediately visible. This is a key ingredient of *liveness*, though it is not sufficient on its own. (See *Relations*)

The ease of achieving immediate feedback is obviously constrained by the computational load of the user's effects on the system, and the system's performance on such tasks. However, such "loading time" is not the only way feedback can be delayed: a common situation is where the user has to manually ask for (or "poll") the relevant state of the system after their actions, even if the system finished the task quickly. Here the feedback could be described as *immediate upon demand* yet not *automatically demanded*, but we include the latter criterion -- automatic demand of result -- in our definition of immediate feedback.

#### Direct Manipulation
*Direct manipulation* (DM) is a special case of immediate feedback. This is where the user sees and interacts with an artefact in a way that is as similar as possible to real life; this typically includes dragging with a cursor or finger in order to physically move a visual item, and is limited by the particular haptic technology in use.

\tp{I wonder if we could mention the famous robot example here? Maybe "Direct manipulation can take the form of interacting with a physical device, such as when programming a robot by physically dragging its arms to record the process that it will later replay. On screen, direct manipulation involves working with visual items through a user interface, such as when manually sorting and editing data in a data table.}

Naturally, because moving real things with one's hands does not involve any waiting for the object to "catch up" with them, DM is necessarily an immediate-feedback cycle. However, if one were to move a figure on screen by typing new co-ordinates in a text box, then this could still give immediate feedback (if the update appears instant and automatic) but would not be an example of DM.

#### Modes of Interaction
Programming systems can allow programmers to operate in multiple different modes, each mode potentially supporting different feedback loops. A typical example here is debugging. In many programming systems, the user can debug a running program and, in this mode, they can modify the program state and get (more) immediate feedback on what individual operations do. When a program is not running, and outside of debug mode, this kind of feedback loop is not available.

A programming system may also be designed with just a single mode. The Jupyter notebook environment does not have a distinct debugging mode; the user runs blocks of code and receives the result. The single mode can be used by users both to quickly test if some way of implementing their idea would work as well as to generate the final result. However, even Jupyter notebooks distinguish between editing a document and running code.

The idea of interaction modes goes beyond just programming systems, appearing in software engineering methodologies. In particular, having a separate _implementation_ and _maintenance_ phase would be an example of two modes.

\tp{I wonder if it would make sense to use footnotes more heavily in this paper? (Kind of in the same way in which philosophy books often have 1/4 of space at the end filled with footnotes. I kind of like the above last paragraph, but it could be a footnote to avoid diverging from the main idea. I think this could be applied to other places in this paper where we feel like adding more detail...)}

### Examples
\note{**UNIX** has two different forms of interaction - programming vs. devops}

**Spreadsheets** have:
  1. A tight, immediate feedback loop for direct manipulation of values and formatting. This is the same as in any other WYSIWYG application.
  2. A loop for formula editing and formula invocation. Here, there is larger execution gulf for designing and typing formulas. The evaluation gulf is often reduced by editor features, e.g. immediate feedback previews for cell ranges. However, one sees what the *effect* of a formula is only on "committing" the formula, e.g. pressing enter.

In a **REPL** or **shell**, there is a main cycle of typing commands and seeing their output, and a secondary cycle of typing and checking the command line itself.
- The output of commands can be immediate, but often reflects only part of the total effects or even none at all. The user must manually issue further commands afterwards, to check the relevant state bit by bit.
- The secondary cycle, like all typing, provides immediate feedback in the form of character "echo", but things like syntax errors are only reported *after* the entire line is submitted.
- One counterexample to this is Firefox's JavaScript console, where the line is "run" in a limited manner on every keystroke. Thus, simple commands without side-effects (e.g. a pure function call) can give instant previewed results, though partially typed expressions and syntax errors do not trigger previews.
- **Commodore 64 BASIC** lets you edit easily via line numbers

A statically checked **programming language** (e.g. Java, Haskell) involves several feedback loops:
1. The notation is plain monospaced text, so users will typically invoke another medium (pencil and paper, whiteboard, or another piece of software) to work out details (e.g. design, organisation, mathematics) before translating this into code. This *supplementary medium* has its own feedback loop.
2. The code is written (through multiple iterations of cycle 1) and is then put through the static checker. Errors here send the user back to writing code, but in the case of success, they are "allowed" to run the program, leading into cycle 3.
    - The execution gulf comprises multiple cycles of the supplementary medium, plus whatever overhead is needed to invoke the compiler (such as build systems).
    - The evaluation gulf is essentially the waiting period before static errors or a successful termination are observed. Hence this is bounded by some function of the length of the code (the same cannot be said for the following cycle 3.)
3. With a runnable program, the user now evaluates the *run-time* behavior. Runtime errors can send the user back to writing code to be checked, or to tweak dynamically loaded data (e.g. data files) in a similar cycle.
    - The execution gulf here may include multiple iterations of cycle 2, each with its own nested cycle 1.
    - The *evaluation* gulf here is theoretically unbounded; one may have to wait a very long time or create very specific conditions to rule out certain bugs (e.g. race conditions) or simply to consider the program as fit for purpose.
    - The latter issue, of evaluating according to human judgement, is made tractable by targetting "good enough for this release" instead of some final, comprehensive measure.
    - By imposing static checks, some bugs can be pushed earlier to the evaluation stage of cycle 2, reducing the likely size of the cycle 3 *evaluation* gulf.
    - On the other hand, this can make it harder to write statically-valid code, which may increase the number of level-2 cycles, thus increasing the total *execution* gulf at level 3.
    - **Depending on how these balance out, the total top-level feedback loop may grow longer or shorter!**
4. Diagram: TODO

\tp{Add reference to modes. Debuggers for normal programming languages. There is no debugging mode in REPLs, not because it would not be possible, but because nobody needs it. A more extreme idea would be to merge execution with editing - I don't think we have an example of this though, so we can leave this for the evaluation when discussing Subtext...

Maybe Flash and Visual Basic, HyperCard have immediate feedback loops only in certain substrate (add reference to substrates)}


### Relations
- A longer evaluation gulf delays the detection of errors. A longer execution gulf can increase the *likelihood* of errors (e.g. writing a lot of code or taking a long time to write it). By turning runtime bugs into statically detected bugs, the combined evaluation gulfs can be reduced. All of these are implications for *error handling*.
- The *execution* gulf is concerned with software using and programming in general. The time taken to realise an idea in software is affected by the user's familiarity and the system's *learnability*, as well as the *expressive power* of the system's ontology.
- *Liveness* is impossible without immediate feedback. However, the motto "The thing on the screen is supposed to be the actual thing" \cite{Live13} suggests that representations should be "canonical" in some sense, i.e. equipped with faithful behaviour rather than intangible shadows cast by the hidden *real* object. This seems to overlap with Direct Manipulation and *bidirectionality*, but it is unclear if it is meant to be synonymous with them.
- Notational structure (different feedback loops for different notations)

## Notational structure
### Summary
What are the different notations, both textual and visual, through which the system is programmed? How do they relate to each other when programming the system?

### Description
Programming is always done through some form of notation. We consider notations in a general sense and include both the textual and the visual. Textual notations include primarily programming languages, but may also include, for example, configuration files. Visual notations include graphical programming languages, but also user interfaces that let us construct visual elements used in the system. Cognitive Dimensions \cite{CogDims} provides a comprehensive framework for analysing individual notations, but our focus here is on how multiple notations are combined, i.e., the notational structure.

In practice, most programming systems use multiple notations. Even when we consider traditional programming languages, those _primary notations_ are often supported by _secondary notations_ such as annotations encoded in comments, and build tool configuration files. More interestingly, some systems have multiple different _primary_ notations. Those can be either provided as different ways of programming the same part of a system, or they can be provided as complementing ways of programming different aspects of a system.

#### Overlapping notations
A programming system may provide multiple notations for programming the same aspect of the system. An example is Sketch-n-sketch \cite{SnS}, which allows authors to create and edit SVG and HTML documents. Sketch-n-sketch displays the source code of the document side-by-side with the resulting output. The author can edit either of the two. An edit in the source code will be immediately visible in the output and edit in the output will result in corresponding change in the source code.

The crucial issue in this kind of arrangement is synchronization between the different notations. If the notations have different characteristics, this is not a straightforward mapping -- for example, source code may allow a more elaborate abstraction mechanism (e.g., a loop) which will not be apparent in the output (i.e., it will result in a repeated object). What should such system do when the user edits a single object that resulted from such repetition? For programming systems that use _overlapping notations_, we need to describe how the notations are synchronized.

#### Complementing notations
A programming system may also provide multiple complementing notations for programming different aspects of its world. An example is Excel spreadsheets, where there are two different notations that complement each other. The first is the formula language, where users describe calculations with data on the sheet. The second is the macro language (VBA), which lets users automate the system in ways that go beyond what is possible through the formula language. There is also a third, even more basic, level which is just entering data into the sheet, although this is not programming the system.

The key issue for systems with complementing notations is how the different notations are connected and how the user may progress from one to the next level if they need. In Excel, macros can be used to control the lower level (you can write macros that evaluate formulas).  This is also a question for learnability. In Excel, you need to learn a completely different language if you want to move to the macro level. The approach optimizes for easy learnability at one level, but introduces a hurdle that users have to cross to get to the second level.

#### Primary and secondary notations
Some systems have multiple primary notations. They can live alongside each other, but they can also be nested. In HyperCard, there is a visual "notation" for designing the user interface: the card itself, which can be edited directly. Then there is HyperScript, which is secondary and can be associated with individual controls.

If we think of just programming languages, it is often easy to miss the fact that using the system as a whole includes a number of secondary notations and tools. Documenting these reveals a number of important facts about a system that may otherwise be hidden. For example, many programming languages use a secondary notation for management of dependencies or build configuration. However, some systems have a nature which makes such secondary notations unnecessary.

#### Expression geography
Programming notations are used to specify a certain logic that the resulting program should execute. A crucial feature of a notation is the relationship between the structure of the notation and the structure of the logic it encodes. Most importantly, do similar expressions, written using a particular notation, represent similar logic?

In textual notations, this may easily not be the case. Consider the C conditional `if (x==1) { .. }` vs. `if (x=1) { .. }`. The former checks whether `x` equals `1` whereas the latter assigns `1` to `x` and then interprets the result as `true`. A notation can be designed to map better to the logic behind it (for example, by requiring the user to write `1==x`). Visual notations may provide more or less direct mapping. On the one hand, similar-looking code in a block language may mean very different things. On the other hand, similar looking design of two HyperCard cards will result in similar looking cards---the mapping between the notation and the logic is much more direct in this case.

\tp{The idea of "expression geography" is due to Antranig, but I cannot find a reference to cite. Similarly "pedantic notations" is due to Thomas Green, but again, I cannot find a citation.}

#### Uniformity of notations
One common concern with notations is the extent to which they are uniform. A uniform notation allows the user to express a wide range of things using just a small number of concepts. The primary example here is S-expressions from LISP, where any expression is represented using a list structure containing either atoms or nested lists. In LISP, the uniformity of notations is closely linked to uniformity of representation, i.e., what exists in memory when a program is running. This however does not necessarily have to be the case.

### Primary examples
**Spreadsheets and HyperCard.** Spreadsheet systems such as Excel use complementing notations consisting of (i) the visual grid, (ii) formula language and (iii) macro language such as VBA. The notations are largely independent and have different degrees of expressivity. A user gradually learns more advanced notations, but experience with previous notation does not help with mastering the next one. The notational structure of HyperCard is similar and consists of (i) visual design of cards, (ii) visual programming (via menu) with a limited number of operations and (iii) HyperTalk for scripting.

**Boxer and Jupyter.** Boxer uses _complementing notations_ in that it combines a visual notation (the layout of the document and the boxes it consists of) with textual notation (the code in the boxes). In case of Boxer, the textual notation is always nested within the visual. The case of Jupyter notebooks is similar---the document structure is graphical (edited by adding and removing cells); code and visual outputs are nested as cells in the document. This arrangement is common in many other systems such as Flash or Visual Basic, which both combine visual notation with textual code, although one is not nested in the other.

**Haskell.** The primary notation is the programming language, but there is also a number of secondary notations. Those include package managers (e.g. the `cabal.project` file) or configuration files for Haskell build tools. More interestingly, there is also an informal mathematical notation associated with Haskell that is used when programmers discuss programs on a whiteboard or in academic publications. Indeed, the idea of having a mathematical notation dates back to the Report on Algol 58 \cite{Alg58}, which explicitly defined "publication language" for "stating and communicating problems" that used, for example, Greek letters and subscripts.

### Further examples

**Sketch-n-sketch.** Sketch-n-sketch, mentioned earlier, is an example of a programming system that implements the _overlapping notations_ structure. It allows users to edit HTML/SVG files in an interface with a split-screen structure that shows source code on the left and displayed visual output on the right. The user can edit both of these and changes are propagated to the other view. In terms of _expression geography_, the code can use abstraction mechanism (such as functions) which are not visible in the visual editor. The visual view thus hides some aspects of the geography, but is more "pedantic" in other aspects. More generally, Sketch-n-sketch can be seen as an example of a *projectional editor*.

**UML Round-tripping.** Another example of a programming system that utilizes the _overlapping notations_ structure are UML design tools that allow the user to see program both as source code and as a UML diagram. Edits in one result in automatic update of the other. An example is the [Together/J](https://www.mindprod.com/jgloss/togetherj.html) system. In order to match the two notations, such systems often need to store additional information (e.g., location of classes in UML diagram after the user rearranges them) in the textual notation. This can be done, e.g., by using a special kind of code comment.

The importance of notations in the practice of science, more generally, has been studied in \cite{PaperTools}, which talks about "paper tools", mechanisms such as formulas that can be manipulated by humans in lieu of experimentation. Programming notations are similar, but they are a way of communicating with a machine---the experimentation does not happen just on paper. One exception here is the mathematical notation in Haskell, which is used as a "paper tool" for experimentation on a whiteboard. In the context of programming notations, the Cognitive Dimensions framework \cite{CogDims} offers a detailed way of analysing individual notations.

\note{Maybe also: ORMs, coordinating DB schema and class definitions}

### Relations
 - _Factoring of complexity._ Using multiple complementing notations implicitly factors complexity by expressing different aspects of a program using different notations.
 - _Feedback loops._ The feedback loops that exist in a programming system are typically associated with individual notations. Different notations may also have different feedback loops.
 - _Learnability._ Notational structure can affect learnability. In particular, complementing notations may require (possibly different) users master multiple notations. Overlapping notations may improve learnability by allowing the user to edit program in one way (e.g. visually) and see the effect in the other notation (e.g., in code).

## Technical dimension: Coherence vs Compatibility and Pluralism

### Summary
What tradeoffs are made between logical coherence and compatibility with established technologies? Does the system replace established technologies or attempt to adapt and recombine them?

### Description
> I will contend that Conceptual Integrity is the most important consideration in system design. It is better to have a system omit certain anomalous features and improvements, but to reflect one set of design ideas, than to have one that contains many good but independent and uncoordinated ideas. — Fred Brooks

> The essence of this style can be captured by the phrase “the right thing”. To such a designer it is important to get all of the following characteristics right: Simplicity … Correctness … Consistency … Completeness — Richard Gabriel

We will refer to Brooks’ conceptual integrity and Gabriel’s right thing as *coherence*: forming a simple unified whole. The dilemma is that the evolution of programming systems has led in the opposite direction, to an enormously complex ecosystem of specialized technologies and standards. Any attempt to unify parts of this ecosystem into a coherent whole will create *incompatibility* with the remaining parts, which becomes a major barrier to adoption. Designers are thus pushed to focus on localized incremental improvements that stay within the boundaries of existing practice.

#### Worse is better
Richard Gabriel first described the problem in his influential 1991 essay "Worse is Better" \cite{WIB} analyzing the defeat of Lisp by Unix/C. Because Unix and C were so easy to port to new hardware, they were “the ultimate computer viruses” despite providing only “about 50%-80% of what you want from an operating system and programming language”.

Today we live in a highly developed world of software technology. It is estimated that 41,000 person years have been invested into Linux. We describe software development technologies in terms of *stacks* of specialized tools, each of which might capitalize over 100 person years of development. Programming system designers face an existential question: how to make a noticeable impact on the overwhelming edifice of existing technology? There are strong incentives to focus on localized incremental improvements that don’t cross the established boundaries.

#### The end of history?
The history of computing is one of cycles of evolution and revolution. Successive cycles were dominated in turn by mainframes, minicomputers, personal computers, and the web. Each transition built a whole new technology ecosystem replacing or on top of the previous. The last revolution, the web, was 25 years ago. Many people have never experienced a disruptive platform transition. Has history stopped, or are we just stuck in a long cycle, with increasingly pent-up pressures for change? If it is the latter, then incompatible ideas now spurned may yet flourish.

#### Pragmatism vs idealism
The choice between compatibility and coherence correlates with the personality traits of pragmatism and idealism. It is pragmatic to accept the status quo of technology and make the best of it. Conversely, idealists are willing to fight convention and risk rejection in order to attain higher goals. We can wonder which came first: the design decision or the personality trait? Do Lisp and Haskell teach people to think more abstractly and coherently, or do they filter for those with a preexisting condition?

#### Everything is an X
Smalltalk and Lisp unify all data into "objects" and "lists", respectively. Likewise, their programming environments have a uniform representation for code: Smalltalk syntax and bytecode in the one case, and simply more lists in the other. In UNIX, everything is a binary data stream or "file", whether for program-interpreted data or machine code.

The Memory Models of Programming Languages essay \cite{MemMod} suggests further examples:
- In COBOL, state consists of nested records in a tax form
- In FORTAN, state consists of parallel arrays
- In SQL, state is a set of mutable multivalued finite functions

Most programming languages and systems impose, require or prescribe structure and form at a "fine granularity": that of individual variables and other data and code structures. This replaces and constrains the flat, "anything goes" memory landscape of the machine level, and the similar "run it and see what happens" indifference of machine instruction streams. Conversely, systems like UNIX or even the Web impose fewer restrictions on how programmers represent things---in UNIX's case, delegating all fine-grained structure to the client program and insisting only on a basic infrastructure of "large objects" \cite{KellOS}. The price to pay for this design decision is that the system can provide relatively little insight into "what is going on" inside the programs if they use a peculiar representation.

#### Living with pluralism
Python follows the principle that “There should be one — and preferably only one — obvious way to do it” in order to promote community consensus on a single coherent style. Contrarily, Perl states that “There is more than one way to do it.” and considers itself “the first postmodern programming language”. “Perl doesn't have any agenda at all, other than to be maximally useful to the maximal number of people. To be the duct tape of the Internet, and of everything else.”

The Perl way is to accept the status quo of evolved chaos and build upon it using duct tape and ingenuity. Taken to the extreme, a programming system becomes no longer properly speaking a system, but rather a toolkit for improvising assemblages of found software. This perspective may reveal a path between the Scylla of compatibility and the Charybdis of coherence. It has appealing connections to the philosophies of Postmodernism and Pluralism. Unfortunately efforts in this direction have so far had limited success (see the examples below).

### Examples
**Unix and C**: Unix rapidly spread across many hardware architectures because C served as a portable assembly language. Porting Unix requires only bootstrapping a C compiler and writing some device drivers. The tradeoff is that C is very weakly specified, with many platform dependencies and undefined behaviors.

**The Unix Programming Environment**: Unix establishes many standard formats and APIs for modularly constructing systems, and a set of utilities and conventions for program development. Examples are the Posix APIs, the ELF executable file format, the text piping constructors of the shell, and the infrastructure of programming tools like vi and make. The tradeoff is that these fixed boundaries stifle innovation. It is difficult to build a cross-process datastore other than a file system. Programming languages are limited to transforming ASCII source files into binary executables.

**Smalltalk and LISP machines**: These classical systems offered a conceptually coherent and self-sufficient programming world using a single programming language throughout. This coherence offered great leverage to experts, many of whom now swear that nothing since has come close. The tradeoff was that these systems were isolated from the rapidly evolving mainstream of heterodox programming. They ran initially on custom hardware, and were ported to standard systems at a very low level, taking over control of disks and displays at the hardware level. Later implementation improved interoperability with the outside world, but still as a somewhat second-class citizen.

**C\++**: C\++ added to C the OO (Object Oriented) concepts pioneered by Smalltalk, while remaining 100% compatible with C, down to the level of ABI and performance. This strategy was enormously successful for adoption, but came with the tradeoff of enormous complexity compared to languages designed from scratch for OO, like Smalltalk, Ruby, and Java.

**Perl and Python**: Perl claims to be a *postmodern* programming language in which “There is more than one way to do it”, enabling idiosyncrasy. In Python the principle that “There should be one — and preferably only one — obvious way to do it” promotes community consensus on a single coherent style.

**Imperative vs Functional Programming**: Imperative programming embraces the hardware capability to write anywhere in memory through any pointer, whereas functional programming creates a higher-level and safer world of immutable data at the cost of more awkward interaction with the external stateful world.

**Pluralistic programming**: Aspect oriented programming, context oriented programming, postmodern programming, mashups, integration domains.

**Web and Wildcard/CodeStrates**: the Web is the ultimate "worse" system (vs. Xanadu)

\tp{Interestingly, most "good old systems" are coherent. There are two exceptions: UNIX and Web (from our list of cool things) - UNX and Web are infinitely repurposeable - this is very admirable}

### Relations
- **Factoring of Complexity**: Normalizing redundancy across interrelated descriptions improves coherency.

\note{
### References
- https://en.wikipedia.org/wiki/The\_Mythical\_Man-Month
- https://dreamsongs.com/WIB.html
- https://www.freecodecamp.org/news/linux-is-25-yay-lets-celebrate-with-25-rad-facts-about-linux-c8d8ac30076d/
- http://www.wall.org/\~larry/pm.html
- http://www.mcs.vuw.ac.nz/comp/Publications/archive/CS-TR-02/CS-TR-02-9.pdf
- https://en.wikipedia.org/wiki/Mashup\_(web\_application\_hybrid)
- https://www.geoffreylitt.com/wildcard/ - mashup thing for glueing existing things in the web
- WebStrates / CodeStrates / mashups / Yahoo pipes
- https://www.cl.cam.ac.uk/research/srg/netos/papers/2009-kell2009mythical.pdf

> TP: To also include uniformity, we need

- "consistency" cognitive dimension
- core assumptions in Lakatos
- memory models http://canonical.org/~kragen/memory-models/
}

# Conclusions
The framework of technical dimensions puts the vast variety of programming systems, past and present, on a common footing of commensurability. This is crucial to enable the strengths of each to be identified and, if possible, combined by designers of the next generation of programming systems. As more and more systems are assessed in the framework, a picture of the space of possibilities will gradually emerge. Some regions will be conspicuously empty, indicating unrealised possibilities that could be worth trying. In this way, a domain of "normal science" is created for the design of programming systems.

\PleaseBeginTheAppendixOkThanks \joel{for Pandoc}

## Self-mutability
### Summary
To what extent can the system be arbitrarily re-programmed without having to go outside it? Which features or infrastructure are "set in stone" or "hard-coded"?

### Description
In most software systems there are typically "hard-coded" or "baked-in" properties that users have no hope of changing. Usually in fact most of the system is immutable, while only a small region is marked "programmable".

#### Homoiconicity
homoiconicity - what do we say about it & where??

### Primary examples

As you go down, you get more self-mutability, but also more
totally-encompassing systems.

You can treat Haskell as a part of UNIX, but that's silly
(but it is largely written in itself, except for some C)

(TODO)

### Secondary examples

3-LISP
COLAs

### Papers

- 3-LISP, COLAs


---

(Early-binding is related to information loss; e.g. optimising away structures that support dynamic change)
* Addressability / Reflection / macros
  "what can you do to the system from inside" [JOEL II]
    * LISP as an extreme, maybe LISP3 :-)?
    * Type providers example - [Move to customizability?]
    * Aspect oriented people - [maybe not as this is now in extensibility below]
    * "Hooks"
    * Stephen Kell's work on making processes in UNIX more self-descriptive?
    * Web: document.getElementById() and injecting `<script>` elements lets you do a lot

## Technical dimension: Information Loss
### Summary
At which points in the system is information irreversibly destroyed or scrambled, and which operations are reversible?

### Description
A piece of computer memory can typically be overwritten any number of times. Such writes, by default, do not set aside and save the old value beforehand; thus, information destruction is the norm. Conceptually, each cell has a history of different values, but practically only its latest value exists.

Destructive overwrites occur frequently, from ordinary incrementation of a counter to re-use of garbage-collected or freed memory blocks.

#### Provenance
When data is computed by code, a user stepping through in a debugger might know what code computed the data, but otherwise this is unknowable from the data itself. A time when this might be useful would be tracking down a bug in procedurally drawn graphics. If a shape is being drawn in the wrong way, it would be convenient if each shape had been tagged with, say, the line number of its draw call. Then one could click on the shape and immediately narrow down the relevant code.

#### Bi-directionality
Computation ordinarily proceeds uni-directionally: complex expressions are gradually reduced down to simpler values, or subroutines are invoked on input parameters to produce an output. Furthermore, intermediate values are quickly destroyed as in discarded stack frames or heap blocks.

#### "Back button"
In HyperCard and Web.

\tp{Research idea (mention in conclusions?) motivated by this dimension is "Python with Back button"}

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

There are a number of interesting questions related to staging of customization. First, what is the notation used for customization? This may be the notation in which a program was initially created, but a system may also use a secondary notation for customization (e.g., Emacs using Emacs Lisp). For systems with a stage distinction, an important question is whether such changes are *persistent*. For example, modifying a DOM of a web page returned from a web application through Developer Tools is not normally a persistent change. Webstrates \cite{Webstrates}, however, makes exactly this kind of modification persistent by synchronizing the DOM between the server and the client. Teitelman's PILOT system for LISP offers an interactive way of correcting errors when a program fails. Such corrections are then applied to the source code of the running program.

#### Externalizability and addressibility
A program is typically represented through some structure. This may be its source code (in conventional programming languages), a graph structure in memory (e.g., object graph in a Smalltalk image) or perhaps a document (as in spreadsheet or a Boxer program). When customizing a program, an interesting question is whether a customization needs to be done by modifying the original structure (*internally*) or whether it can be done by adding something alongside the original structure (*externally*).

Examples of the former abound. A case of the latter is, for example, the Cascading Style Sheets (CSS) mechanism on the web. Given a web page, it is possible to modify (almost) any aspects of its look simply by *adding* additional rules to a CSS file. A similar effect is achieved in object-oriented programming where functionality can be added to a system by defining a new class (although injecting the new class into existing code without modification requires some form of configuration such as a dependency injection container).

When customizing programs through external means, the customization is done by _addressing_ some aspect in the existing program and specifying additional or replacement behaviour. An important issue is how are such addresses specified and what extension points in the program can they refer to. The programming system may offer an automatic mechanism that makes certain parts of a program addressable or this task may be delegated to the programmer. In Aspect Oriented Programming (AOP) systems such as AspectJ, it is possible to add functionality to the invocation of a specific method (among other options) by using the _method call pointcut_.

### Examples

**Smalltalk, Newspeak and similar**: in programming systems derived from Smalltalk, there is generally no strict distinction between stages and so a program can be customized during execution in the same way as during development. This is typically done _internally_, i.e., by navigating to a suitable object or a class (which serve as the addressable extension points) and modifying that. LISP-based systems such as **Interlisp** follow a similar model.

**Extensible text editors** including vim, emacs and Atom: although those are not (exactly) programming systems, they serve as an interesting example. They can be modified during execution. In some, this is done using a secondary notation (explicitly designed for this purpose), but e.g., in Atom the customization is done through the same mechanism in which it is implemented (JavaScript). The customization is done _externally_ by writing an extension separate from the editor itself and it can address extension points offered by the editor. For example, in case of Atom, this is an explicitly defined API, although the dynamic nature of JavaScript (and CSS) makes it possible to address other (less directly exposed) aspects of the system.

**Cascading Style Sheets**: Although not a programming system, CSS is a prime example of a system that offers external customizability with rich addressability mechanisms that is partly automatic (e.g., when referring to tag names) and partly manual (e.g., when using element IDs and class names). The **Infusion** project is a research programming system that offers similar customizatbility mechanism, but for behaviour rather than just styling.

**Document Object Model (DOM) and Webstrates**: In the context of web programming, there is traditionally a stage distinction between programming (writing the code and markup) and running (displaying a page). However, the DOM can be also modified by browser Developer Tools---either manually or by running scripts in a console (or by using a userscript manager such as Greasemonkey). Such changes are not persistent except in Webstrates \cite{Webstrates}, which automatically synchronizes DOM edits to the server and to all other clients viewing the page/application.

**Object and Aspect Oriented Programming**: in conventional programming languages, customization is done by modifying the code itself. OOP and AOP make it possible to do so _externally_ by adding code independently of existing program code. In OOP, this requires manual definition of extension points; AOP improves on this by providing a richer addressing mechanism.

**Subtext \cite{Subtext} and Boxer \cite{Boxer}** are two example research programming systems that do not have explicit stage distinctions. Both of them represent programs as a document that is visible to the user in its entirety (called _naive realism_ in Boxer), allowing the user to customize the program by finding the relevant aspect in the document and modifying it.

### Relations
 - Factoring of Complexity: related in that "customizability" is a form of creating new programs from existing ones; factoring repetitive aspects into a reusable standard component library facilitates the same thing.
 - Uniformity (Uniformity of interaction) and Feedback Loops: the two of these determine whether there are separate stages for running and writing programs and may thus influence what kind of cusomizability is possible.

### Papers
 - The open authorial principle: supporting networks of authors in creating externalisable designs
 - AspectJ / AOP papers
 - Flavors in LISP c.f. https://dreamsongs.com/Files/Incommensurability.pdf

## Level of Automation

### Summary
To what extent and in what ways does the programming system remove the need of specifying the program implementation in full minutiae detail?

### Description
In order to execute a computer program, computers require a full and exact specificiation of the instructions to run. Ever since the 1940s, programmers envisioned that some form of "automatic programming" will alleviate the need for repeatedly specifying all details. The computer still requires full details today, but many aspects of the task of programming can be automated.

Automation can take a number of forms. Extracting common functionality into a library may be merely good use of _Factoring of Complexity_, but to the user of the library, this may appear as automation. In high-level programming languages, many details are also omitted; those are filled-in by the compiler. Finally, the program may also be executed by a more sophisticated runtime that fills in details not specified explicitly, such as when running an SQL query.

#### Notations
Even with high-level of automation, programming involves manipulating some program notation. In high-level functional or imperative programming languages, the programmer writes code that typically has clear operational meaning. When using more declarative programming like SQL, Prolog or Datalog, the meaning of a program is still unambiguous, but it is not defined operationally---there is a (more or less deterministic) inference engine that solves the problem based on the provided program. Finally, systems based on programming by example step even further away from having clear operational meaning---the program may be simply a collection of sample inputs and outputs and a (typically non-deterministic) engine infers the minute details of a program based on those.

#### Degrees of automation
This analysis suggests that there are many degrees of automation in programming systems. The basic mechanism is however always the same---given a program, some logic is specified explicitly and some is left to a reusable component that can specify the details. In the case of library reuse, the reusable component is just the library. In the case of higher-level programming languages, the reusable component may include a memory allocator or a garbage collector. In case of declarative languages or programming by example, the reusable component is a general purpose inference engine.

It is worth noting that higher levels of automation require significantly more complex _reusable components_ than lower levels. This is a difference between _Level of Automation_ and _Factoring of Complexity_---producing systems with higher level of automation requires more than simply extracting (factoring) existing code into a reusable component. Instead, it requires doing more work and introducing a higher level of indirection between the program and the reusable component.

There is also an interesting (and perhaps inevitable?) trade-off. The higher the level of automation, the less explicit the operational meaning of a program. This has a wide range of implications. Smaragdakis notes, for example, that this means the implementation can significantly change the performance of a program.

#### Fragmentation
An interesting issue is that reusable components that enable higher levels of automation are often specific to each system. This, arguably, limits what we can achieve as components that enable higher-levels of automation are increasingly complex to implement. As noted by Kell, incompatible reusable components that exist for multiple systems also limit compositionality. One possible exception from the rule is the Z3 theorem prover, which is used as an implementation mechanism by multiple programming systems including F\#.

#### Next-level automation
Throughout history, programmers have always hoped for the next level of "automatic programming". As observed by Parnas, _"automatic programming has always been a euphemism for programming in a higher-level language than was then available to the programmer"_.

We may speculate whether deep learning will enable the next step of automation. However, this would not be different in principle from existing developments. We can see any level of automation as using _artificial intelligence_ methods. This is the case for declarative languages or constraint-based languages---where the inference engine implements a traditional AI method (GOFAI, i.e., Good Old Fashioned AI).

\joel{include a definition and discussion of "boilerplate" code!}

### Relations
 - Factoring of Complexity: The way this is done is that you typically automate the thing at the lowest level in your factoring (by making the lowest level a thing that exists outside of the program---in a system or a library)

### Papers
- "automatic programming has always been a euphemism for programming in a higher-level language than was then available to the programmer" - Parnas in http://web.stanford.edu/class/cs99r/readings/parnas1.pdf
- Next Paradigm PLs: https://yanniss.github.io/next-paradigm-onward19.pdf
- Limiting compositionality https://www.cs.kent.ac.uk/people/staff/srk21/research/papers/kell13operating.pdf

## Technical dimension: Handling of errors

### Summary
What does the system consider to be an error, and how does it approach their prevention and handling?

### Description

In general, a _program error_ is when the system cannot run in a normal way and needs to resolve the situation. This raises a number of questions for system design: What can cause a program error? Which program errors can be prevented from happening? How should the system react to a program error?

A computer system is not aware of human intentions. There will always be human mistakes that the system cannot recognize as errors. However, there are many human mistakes that a system can recognize. The design of a system can determine what human mistakes can be detectable program errors.

We distinguish between four kinds of errors: slips, lapses, mistakes and failures. A _slip_ is a unintended error caused by a human attention failure such as a typo in source code. A _lapse_ is also an unintended error, but caused e.g., by a memory failure such as an incorrectly remembered method name. A _mistake_ is a logic error of the human such as bad design of an algorithm. Finally, a _failure_ is a system error caused by the system itself that the programmer has no control over, e.g. a hardware or a virtual machine failure.

#### Detecting and preventing errors

Errors can be identified in any of the _feedback loop_ that the system implements. This can be done either by a human or the system itself, depending on the nature of the feedback loop. Consider three examples. First, in live programming systems, the programmer immediately sees the result of their code changes. Error detection is done by a human and the system can assist this by visualizing as many consequences of a code change as possible. Second, in a system with static checking feedback loop (e.g. syntax checking, static type system), potential errors are reported as the result of the analysis. Third, errors can be detected when the developed software is run, either when it is tested by the programmer or when it is run by a user.

Error detection in different feedback loops is suitable for detecting different kinds of errors. Many slips and lapses can be detected by the static checking feedback loop, although this is not always the case. For example, a more compact _expression geography_ can make it easier for slips and lapses to produce hard to detect errors. Mistakes are easier to detect through live feedback loop, but they can also be partly detected by more advanced static checking.

A common aim is to eliminate _latent errors_, i.e. errors that occur at some earlier point during execution, but will manifest themselves through an unexpected behaviour later (for example, dereferencing an incorrect memory address to obtain a value that will be stored in a database and accessed later). Latent errors can be prevented differently in different feedback loops. In the live feedback loop, this can be done by visualizing effects that would normaly remain hidden. When running software, latent errors can be prevented through a mechanism that detects errors as early as possible (e.g. initializing pointers to `null` and stopping on `null` dereferencing).

#### Responding to errors

When an error is detected by a system, there are a number of typical ways in which the system can respond. The following applies to systems that admit some kind of error detection during execution.

- A system may attempt to automatically recover from the error as best as possible. This may be possible for simpler errors (slips and lapses), but also for certain mistakes (e.g., a mistake in concurrency logic of an algorithm may often be resolved by restarting the code).
- A system may proceed as if the error did not happen. This may lead to latent errors later, but the approach may, for example, eliminate expensive checks.
- A system may ask a human how to resolve the issue. This can be done interactively, by entering into a mode where the code can be corrected, or non-interactively by stopping the system.

Orthogonally to the above options, a system may also have a way for recovering from latent errors by being able to trace back through the execution in order to find the root cause for the error. It may also have a mechanism for undoing all actions that occurred in the meantime, e.g. through transactional processing.

### Examples

- Haskell - (static loop) static checking, errors (of the slip or lapse variety) should never happen
- Sonic PI - (live loop) you get live feedback, human may choose to accept mistake and play different music; the music continues to play uninterrupted until code is changed in a valid way
- Interlisp + DWIM - (running loop) ask human what to do and let them correct things - also similar thing in Smalltalk
- Elm time traveling debugger - (running loop) tracing back through event log
- Something transactional - databases, but also the STEPS transactional thing (Warth's worlds)
- Antifragile software

### Relations
- Error detection happens at different _feedback loops_
- A system can recognize slips and lapses as errors if you have wide *expression geography*

### Papers
- Tomas - input/output error paper: https://web.eecs.umich.edu/~weimerw/2006-615/reading/goodenough-exceptions.pdf (introduced idea of exceptions i think)
- miscomputation philosophy papers, Human Error book

## Technical dimension: Background Knowledge
### Summary
What background knowledge does the system demand in order to be judged on its own merit?

### Description
Every system rests on some requirement of background knowledge in order to be *learnable* in the first place. Some requirements, like literacy in a written natural language or familiarity with the de facto GUI conventions of modern computing, are easy to miss because they are so ubiquitous. But above the bare necessities for software-in-general, each system will sit on its own specific foundations that are deemed *outside of its scope* for teaching the user. These can range from widely known skills like the above, to specialist topics in mathematics, sciences or the unnamed cultural history of the system itself.

Background knowledge is not only necessary to get *benefit* from *using* the system; it is also necessary to be able to give it a truly fair *evaluation*. If someone without the necessary background attempts and fails to get the use promised by the system, this is not a point against the system (although the fact that it *does* depend on this prerequisite may be criticised). On the other hand, someone who is familiar with the background is in a position to judge the learnability of the system.

The matter is complicated, however, by the fact that a system may not give any clear outward indication of what it expects users to already know. Instead this will have to be *inferred* along the way, making it unclear whether difficulties should be attributed to newly revealed prerequisites, or to shortcomings of the system design.

Thus, to the extent that a system explicitly sets out its background knowledge, it may be judged on whether it works "as advertised". In the more common case of this being implicit, this will invite a complex debate involving what the system is for and what can be inferred about its prerequisites.

### Examples
- As mentioned, familiarity with GUI items like windows, menus, buttons and text fields and their use via keyboard and mouse (or touch) is so ubiquitous a requirement for software that one may wish to declare it *universal*. However, if we consider Bret Victor's **DynamicLand** under our remit (it exists at the edge between "software systems" proper and "physical systems *mediated by* software in the background") then it constitutes a counterexample. Instead, only familarity with everyday physical objects, along with *programming languages*(!) is required. (Plus keyboard and GUI etc for *entering* the program code? Maybe I don't know what I'm talking about here. Can you hand-write program code?)
- While the GUI is the ubiquitous background requirement for most "end-user"-facing software and also much "programming" software, programming has its own ubiquitous assumed base: the concepts and conventions of the **UNIX operating system** (more precisely, of UNIX *at the latest* -- no doubt, it imported many concepts and conventions from its predecessors and contemporaries): hierarchical file systems; files as streams and vice versa; command-line argument spelling conventions; parsing and serialising of ASCII renderings of structured data.
- **Spreadsheets** are notable for embodying a dataflow computation model on a greater proportion of GUI background to traditional programming.
  - Instead of a textual rendering of symbolic names for variables, spreadsheets present a 2D matrix analogous to computer memory, with spatially "addressed" locations instead of named ones. This substitutes vision and spatial reasoning for abstract name management.
  - Formulas, at their simplest, rest on basic arithmetical knowledge along with two extras: the de-facto ASCII names for multiplication and division (* and /), and the lexical / syntax parsing rules of traditional programming.
  - More complex formulas require using functions in a semi-mathematical notation; this leverages the mathematical concept of functions and its typical notation. However, as tasks move beyond the arithmetically simple, **even spreadsheets cannot avoid gradually importing more and more concepts of traditional programming.** (conditionals, sequencing, arrays, ...)
  - Copy+Paste
  - Replace "variables" with "grid" - which is a space concept rather than abstract concept

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

## Technical dimension: Factoring of complexity
### Summary
What are the primitives? How can they be combined? How is *common structure* recognised and utilised?

### Description
There is a large space of possible things we might want to do with a system. The question is, how do we "get" to all the possible locations in this space? We can have a very flat structure where different tool/method/feature is used to reach individual points in this space. We can also have a more structured approach where we need to compose individual components to "get" to individual locations.

#### Composability
In short, _you can get anywhere by putting together a number of smaller steps._ There exist building blocks which span a range of useful combinations. Such a property can be analogised to *linear independence* in mathematical vector spaces: a number of primitives (basis vectors) whose possible combinations span a meaningful space. Composability is, in a sense, key to the notion of "programmability" and every programmable system will have some level of composability (e.g. in the scripting language.)

#### Convenience
In short, _you can get to X, Y or Z via one single step._ There are ready-made solutions to specific problems, not necessarily generalisable or composable. Convenience often manifests as "canonical" solutions and utilities in the form of an expansive standard library.

Composability without convenience is a set of atoms or gears; theoretically, anything you want could be built out of them, but you do have to do that work.

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
 - Spreadsheets
     - cell structure is built-in
     - metaphor is "tax form"
 - Smalltalk
     - very first-class - you can define your own objects
     - metaphor is compiter consisting of small computers
 - In relational databases, there is an opposition between *normalization* and *redundancy*. When data is duplicated in order to fit into a flat table structure, there is the corresponding redundancy. When data is factored into small tables as much as possible, such that there is only one place each piece of data "lives", the database is in *normal form* or *normalized*. Redundancy is useful for read-only processes, because you do not need joins. But it makes writing risky, because you need to modify one thing in multiple places.
 - In some sense every "library" is at the very least a collection of "diagonals", which may in some cases also be orthogonal/independent in a higher-dimensional space! :)
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


## Technical dimension: Abstraction mechanisms

### Summary
What is the relationship between concrete and abstract in the system? What are the different abstraction mechanisms supported by the system? How are abstract entities created from concrete things and vice versa?

### Description
Abstraction is a "process where general concepts are derived from specific examples, first principles or other methods" (wikipedia). An _abstraction_ is the result of such process. Almost all programming systems support some kind of abstraction. This is necessary, because we often want to instruct the computer to perform the same operation on multiple different inputs or produce many things using the same schema. This technical dimension captures what is the nature of _abstractions_ used in the programming system, how are they created, modified and used.

#### Constructing abstractions
As suggested above, abstractions can be constructed from concrete examples, first principles or through other methods. A part of the process may happen in the programmer's brain---for example, they can think of concrete cases and use that to come up with an abstract concept and then directly encode the abstract concept in the programming system. But a programming system can directly support different ways of producing abstractions.

One option is to construct abstractions _from the first principles_. Here, the programmer starts by defining an abstract entity such as an interface in object-oriented programming languages. To do this, they have to think what the required abstraction will be (in the brain) and then encode it (in the system).

Another option is to construct abstractions _from concrete cases_. Here, the programmer uses the system to solve one or more concrete problems and, when they are satisfied, the system guides them in creating an abstraction based on their concrete case(s). This can be done in a programming language (e.g., through refactoring like extract function & adding a parameter), but also through other approaches (e.g., a form of macro recording)


#### Encapsulation or transparency
To what extent are abstract things hidden and protected from being manipulated?

> This is going to be a reference to "addressability" (or whatever we call it) dimension
>
#### Higher-order

> TODO: Merge important bits from "higher-order" in self-sufficiency into this
> (clear in PLs, but no obvious representation of higher-order in visual systems)
> Also hard to reason about this statically (c.f. thegamma)


### Examples

- **Pygmalion** - In Pygmalion, all programming is done by manipulating with concrete icons that represent concrete things. To create an abstraction, you can use "Remember mode", which records the operations done on icons and makes it possible to bind this recording to a new icon.
- **Smalltalk** - You can always look inside abstractions! (Not the case when importing external library in Java.)
- **Jupyter notebook** - In Jupyter notebooks, you are inclined to work with concrete things, because you see previews after individual cells. This discourages creating abstractions, because then you would not be able to look inside at such a fine grained level. (People come up with tricks like the `material` variable in [FT analysis](https://github.com/ft-interactive/recycling-is-broken-notebooks/blob/master/01-wrangle-eurostat.ipynb)).
- **Spreadsheets** - Up until the recent introduction of lambda expression into Excel, spreadsheets have been relentlessly concrete, without any way to abstract and reuse patterns of computation other than copy-and-paste.

### Relations
- normalization - abstractions are a key for enabling normalization (unless it's all built in)
- notational strucutre - abstractions are typically done at a level of individual notations
- self-sufficiency cluster - provides ways for building abstractions (like higher-order, maybe reflection, etc.)

### References
- Abstraction gradient cognitive dimension

## Technical Dimension: Learnability and Sociability

### Summary
How does the system facilitate or obstruct adoption by both individuals and communities? Individual adoption is facilitated by designing the system to be easily learned by a targeted audience. Community adoption is less about technical issues and more about economic/social/cultural factors that are harder to design for. One important factor is the tenor of online communities, whose norms are best established at the start.

### Description
Human and social factors greatly affect the extent to which a technology is used. Even the simplest software technologies require substantial effort to learn. All else equal, a technology that is easier to learn is more likely to be adopted. Individuals with free choice will decide whether the learning investment is worth the benefits. We can make a technology more learnable in several ways:

- Specialize to a specific domain of usage or population of users.
- Design for teaching beginners rather than professional usage.
- Stage levels for learners to advance through.
- Provide more scaffolding and faster feedback in the programming experience.
- Reduce the number of things that need to be learned by unifying concepts (See Coherence dimension).

However social factors can easily override individual ones. Our increasing appreciation of the importance of social factors leads us to discuss software technolgies in terms of communities. The nature of the community can be the decisive factor in adopting a technology. How big and old is the community? Do we feel safe that future problems will be solved and new requirements will be met? Do we feel the community shares our values and that we belong in it? Does it give us purpose and meaning? We cannot claim to have a good understanding of how to design a sociable programming systerm, but we do observe a number of factors that have been important historically:

- Easy integration into existing technology stacks, allowing incremental adoption, and also easy exit if needed.
- Contrary to the previous point, a cloistered community that turns its back on the wider world can give its members string feelings of belonging and purpose. Examples are Smalltalk, Racket, Clojure, Haskell. These communities bear some resemblance to cults, including guru-like leaders. As such we can expect them to last a long time, but to always remain a fringe counter-culture to the mainstream.
- Backing by large corporations or large capital investments to ensure longevity.
- Making the limits of the technology clear up front, so that adopters are not led astray. For example, no one expects spreadsheets to create web apps. On the other hand, many “no-code” systems have vague and shifting limits.
- Easy sharing of code via package repositories or open exchanges. Prior to the open source era, commercial marketplaces were important, like VBX components for VisualBasic.
- Avoiding fragmentation into sub-communities by establishing standard libraries and practices. Scheme and Haskell are counter-examples. See the Lisp Curse.
- Establishing an online community that is welcoming and supportive of newcomers. This is best done by setting community norms from the beginning, as they can be intractable to change later. A good example of this is Elm.

### Examples
- Spreadsheets, HyperCard - Small self-sufficient systems that can be mastered in a matter of months.
- Logo, Boxer, Basic, Pascal, Scratch - Designed primarily for teaching, prioritizing simplicity.
- HyperCard, Racket - Levels of progressively increasing complexity to assist learning
- Live programming research - offload programmers from having to simulate execution in their head. See Bret Victor, Christopher Fry
- Python, Ruby, Elm - PLs that prioritize friendliness to beginners, both technically and in community norms. Leadership that is self-effacing.
- LISP, Scheme, Haskell - Math-like languages appealing strongly to certain people but repelling the general public, along with a culture that celebrates the divide.
- Software ecosystems: VisualBasic VBX marketplace. Package managers: CPAN, RubyGems, npm. Scratch website.
- Elm: an intentionally sociable PL. Friendly error messages, a dramatic usability improvement over other ML-like languages - not technically hard, but the other language communities never cared enough to fix it. Principled exclusion of unsafe features that can cause runtime errors, to the point of breaking external interoperability. Prioritized establishing friendly community norms from the beginning.

### Relations
Coherence vs Compatibility and Pluralism
Feedback Loops


### References
- Myerovich & Rabkin: Socio-PLT: Principles for Programming Language Adoption   https://parlab.eecs.berkeley.edu/sites/all/parlab/files/Socio-PLT.pdf
- Lisp Curse [http://www.winestockwebdesign.com/Essays/Lisp\_Curse.html]
- Evan Czaplicki “What is Success” [https://www.youtube.com/watch?v=uGlzRt-FYto]
- [Programming on an already full brain](https://dl.acm.org/doi/10.1145/248448.248459)
- Bret Victor Learnable Programming
