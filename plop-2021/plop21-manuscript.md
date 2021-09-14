# Introduction

\note{We should also make sure "programming system" includes the whole lifecycle (think UNIX but also magic deploy-to-cloud-apps)}

\note{
> ORIGINAL VERSION
Many forms of software have been developed to enable "programming". The classic form is *programming languages (PLs)*, differentiated by syntax, semantics of abstract tree transformations, and implementation techniques. Since the advent of the GUI, languages can be found embedded within a graphical "application" and dependent on its context, but the GUI also permits the novelty of "visual" programming (non-)languages. We call examples of any of these forms, or combinations thereof, *Programming Systems*. Evidently, the tools and interfaces supporting languages form a part of such a landscape, and the languages "themselves"---abstracted from this implementation context---a still smaller part.

>There is an increasing interest in (non-language) programming systems. Researchers are increasingly studying topics such as *programming experience* and *live programming tools*, as instances like Replit and Dark become more popular. Yet, this line of research remains on the side. While PLs are a well-established concept, analysed and compared in a common vocabulary, no similar foundation exists for the wider range of programming systems.
>
> NEW VERSION BELOW
}

Many forms of software have been developed to enable programming. The classic form consists of a *programming language*, a text editor to enter source code, and a compiler to turn it into an executable program. Instances of this form are differentiated by the syntax and semantics of the language, along with the implementation techniques in the compiler or runtime environment. Since the advent of graphical user interfaces (GUIs), programming languages can be found embedded within graphical environments that increasingly define how programmers work with the language (by directly supporting debugging or refactoring, for instance.) However, the rise of GUIs also permits diverse visual forms of programming, including visual languages and GUI-based end-user programming tools. This paper relies on, and encourages, a shift of attention from *programming languages* to the more general notion of "software that enables programming"---in other words, *programming systems*.

A *programming system* may include tools, protocols, notations and languages. It is a software artefact that makes it possible to construct programs, debug them, and turn them into operational, maintained and evolvable artifacts running on appropriate hardware. This notion covers classic programming languages together with their editors, debuggers, compilers and other tools. Yet it is intentionally broad enough to accommodate image-based programming environments like Smalltalk, operating systems like Unix, and hypermedia systems like Hypercard, as well as various other examples we will mention.

## What is the problem?

There is a growing interest in broader forms of *programming systems*, both in the programming research community and in industry. On the one hand, researchers are increasingly studying topics such as *programming experience* and *live programming* that require considering not just the *language*, but further aspects of a given system. On the other hand, commercial companies are building new programming environments like Replit or low-code programming tools like Dark and Glide. Yet, such topics remain at the sidelines of mainstream programming research. While *programming languages* are a well-established concept, analysed and compared in a common vocabulary, no similar foundation exists for the wider range of *programming systems*.

The academic research on programming suffers from the lack of common vocabulary for talking about programming systems. While we can thoroughly assess programming languages, as soon as we add interaction or graphics into the picture, all we can say is that the resulting system is vaguely "cool" or "interesting". Moreover, when designing new systems, inspiration is often drawn from same few somewhat disconnected sources of ideas. These might be influential past systems like Smalltalk, programmable end-user applications like spreadsheets, or motivational illustrations by thinkers like Victor\ \cite{BretVictor}.

Instead of forming a solid body of work, the ideas that emerge are difficult to relate to each other. Similarly, the research methods used to study programming systems lack the more rigorous structure of programming language research methods. They tend to rely on singleton examples, which demonstrate the author's ideas, but are inadequate methods for comparing new ideas with the work of others. This makes it hard to build on top and thereby advance the state of the art.

Studying *programming systems* is not merely about taking a programming language and looking at the tools that surround it. It presents a *paradigm shift* to a perspective that is, at least partly, *incommensurable* with that of languages. When studying programming languages, everything that matters is in the program code; when studying programming systems, everything that matters is in the *interaction* between the programmer and the system. As documented by Gabriel \cite{PLrev}, looking at a *system* from a *language* perspective makes it impossible to think about concepts that arise from interaction with a system, but are not reflected in the language. Thus, we must proceed with some caution. As we will see, when we talk about Lisp as a programming system, we mean something very different from a parenthesis-heavy programming language!

## Contributions
We propose a new common language as an initial, tentative step towards more progressive research on programming systems. Our set of "Technical Dimensions for Programming Systems" seeks to break down the holistic view of systems along various specific "axes": verbal conceptual prompts inspired by the *Cognitive\ Dimensions of\ Notation*\ \cite{CogDims}. While not strictly quantitative, we have designed them to be narrow enough to be comparable, so that we may say one system has more or less of a property than another. Generally, we see the various possibilities as tradeoffs and are reluctant to assign them "good" or "bad" status. If the framework is to be useful, then it must encourage some sort of rough consensus on how to apply it; we expect it will be more helpful to agree on descriptions of systems first, and settle normative judgements later.

The set of dimensions can be understood as a map of the design space of programming systems (Figure\ \ref{fig:tech-dims-diagram}). Past and present systems will serve as landmarks, and with enough of them, unexplored or overlooked possibilities will reveal themselves. So far, the field has not been able to establish a virtuous cycle of feedback where practitioners are able to situate their work in the context of others' for subsequent work to improve on. Our aim is to provide foundations for the study of programming systems that would allow such development.

1. We discuss in detail three clusters of technical dimensions: *interaction structure*, *notational structure*, and *conceptual structure*. The rest of our initial set resides in the Appendix.
2. We define these dimensions by reference to landmark programming systems of the past, and discuss any relationships between them.
3. We demonstrate the salience of these dimensions by applying them to example systems from both the past and present. We situate some experimental systems as explorations at the frontier of certain dimensions.

\note{5. We identify limitations and needed future work.}

# Related work

While we do have new ideas to propose, part of our contribution is simply integrating a wide range of existing concepts under a common umbrella. This work is spread out across different domains, but each part connects to programming systems or focuses on a specific characteristic they may have.

## Which "systems" are we talking about?

The programming systems that shape our framework come from a few recognisable clusters:

- "Platforms" supporting arbitrary software ecosystems: UNIX, Lisp, Smalltalk, the Web
- "Applications" targeted to a specific domain: spreadsheets
- Mixed aspects of platform and application: HyperCard, Boxer, Flash, and programming language workflows

Richard Gabriel noted a "paradigm shift" \cite{PLrev} from the study of systems to the study of languages in computer science, which informs our distinction here. One consequence of the change is that a *language* is often formally specified apart from any specific implementations, while *systems* resist formal specification and are often *defined by* an implementation. We do, however, intend to recognizeprogramming languages as a small part of the space of possible systems (Figure\ \ref{fig:tech-dims-diagram}). Hence we refer to the *interactive programming system* aspects of languages, such as text editing and command-line workflow.

\begin{figure}
  \centering
  \includegraphics[width=0.5\linewidth]{tech-dims-diagram.png}
  \caption{A speculative sketch of one 2-dimensional slice of the space of possible systems.\label{fig:tech-dims-diagram}}
\end{figure}

Our "system" concept is mostly technical in scope, with occasional excursions as in "Learnability & Sociability" (Section\ \ref{learnability-and-sociability}). This contrasts with the more socio-political focus found in \cite{TcherDiss}. It overlaps with Kell's conceptualization of Unix, Smalltalk, and Operating Systems generally\ \cite{KellOS}, and we ensure UNIX is a part of ours. We do not, however, extend it to systems distributed over networks, although our framework may still be applicable there.

## Industry and research interest in programming systems
There is renewed interest in programming systems in both industry and research. In industry we see:

- Computational notebooks such as Jupyter^[https://jupyter.org/] that make data analysis more amenable to scientists by combining code snippets and their numerical or graphical output in a convenient document format.
- “Low code” end-user programming systems that present a simplified GUI for developing applications. One example is Coda,^[https://coda.io/welcome] which combines tables, formulas, and scripts to enable non-technical people to build “applications as a document”.
- Specialized programming systems that augment a specific domain. For example Dark,^[https://darklang.com/] which creates cloud API services with a “holistic” programming experience including a language and direct manipulation editor with near-instantaneous building and deployment.
- Even for general purpose programming with conventional tools, systems like Replit^[https://replit.com/] have demonstrated the benefits of integrating all needed languages, tools, and user interfaces into a seamless experience available from a browser with no setup.

In research, there are an increasing number of explorations of the possibilities of full programming systems:

- Subtext \cite{Subtext}, which combines code with its live execution in a single editable representation.
- Sketch-n-sketch \cite{SnS}, which can synthesize code by direct manipulation of its outputs.
- Hazel \cite{Hazel}, a live functional programming environment featuring typed holes which enable execution of incomplete or type-erroneous programs.

Several research venues investigate programming systems:

- [VL/HCC](https://conferences.computer.org/VLHCC/) (IEEE Symposium on Visual Languages and Human-Centric Computing)
- The [LIVE programming](https://liveprog.org/) workshop at SPLASH
- The [PX](https://2021.programming-conference.org/home/px-2021) (Programming eXperience) workshop at $\langle$Programming$\rangle$

## Related methodology

There are several existing projects identifying characteristics of programming systems. Some of these revolve around a single one, such as levels of liveness \cite{Liveness}, or plurality and communicativity \cite{KellComm}. Others propose, as we do here, an entire collection:

- *Memory\ Models of\ Programming\ Languages*\ \cite{MemMod} identifies the "everything is an X" metaphors underlying many programming languages.
- The *Design\ Principles of\ Smalltalk*\ \cite{STdesign} documents the philosophical goals and dictums used in the design of Smalltalk.
- The original *Design Patterns*\ \cite{DesPats} names and catalogues specific tactics within the *codebases* of software systems.
- The *Cognitive\ Dimensions of\ Notation*\ \cite{CogDims} introduces a common vocabulary for software's *notational surface* and shows how they trade off and affect the performance of certain types of tasks.

Of these sources, the latter two bear the most obvious influence on our proposal. Our framework of "technical dimensions" continues the approach of the Cognitive Dimensions to the "rest" of a system beyond its notation. Our individual dimensions naturally fall under larger *clusters* that we present in a regular format, similar to the presentation of the classic Design Patterns. As for characteristics identified by others, part of our contribution is to integrate them under a common umbrella: Liveness, pluralism, and uniformity metaphors ("everything is an X") are incorporated as dimensions already identified by the related work.

We follow the attitude of *Evaluating Programming Systems*\ \cite{EvProgSys} in distinguishing our work from HCI methods and empirical evaluation. We are generally concerned with characteristics that are not obviously amenable to statistical analysis (e.g. mining software repositories) or experimental methods like controlled user studies, so numerical quantities are generally not featured.

Similar development seems to be taking place in HCI research focused on user interfaces. The UIST guidelines^[https://uist.acm.org/uist2021/author-guide.html] instruct authors to evaluate system contributions holistically, and the community has developed heuristics for such evaluation, such as *Evaluating User Interface Systems Research*\ \cite{EvUISR}. Our set of dimensions offers similar heuristics for identifying interesting aspects of programming systems, though they focus more on underlying technical properties than the surface interface.

Finally, it is worth mentioning an influence from the history and philosophy of science. In fields like physics, superseded theories made predictions that were eventually falsified by the world they tried to model. Much of *computing*, however, involves creating custom "worlds" with their own rules, making the judgement cast by "supercession" seem rather less final. Hence we follow Chang's "Complementary Science" approach\ \cite{Chang}, drawing our attention to historical systems that have been superseded, forgotten, or largely ignored---a "Complementary Computer Science".

## What we are trying to achieve
In short, while there is a theory for programming languages, programming *systems* deserve a theory too. It should apply from the small scale of language implementations to the vast scale of operating systems. It should be possible to analyse the common and unique features of different systems, to reveal new possibilities, and to build on past work in an effective manner. In Kuhnian terms, it should enable a body of "normal science": filling in the map of the space of possible systems (Figure \ref{fig:tech-dims-diagram}), thereby forming a knowledge repository for future designers.

# History of programming systems
Here, we will present a brief and incomplete history of programming systems. This serves two purposes. First, looking at a number of examples from the past helps build an intuitive understanding of what we mean by a programming system. Second, it allows us to introduce example systems that we will use in the next section to illustrate the individual technical dimensions.

## Interacting with computers

The key aspect of computers that enabled the rise of programming systems was the ability for a programmer to interact one-on-one with a computer. This was not possible in the 1950s when most computers were large and operated in a batch-processing mode. Two historical developments enabled such interactivity from the 1960s. First, time-sharing systems enabled interactive shared use of a computer via a teletype. Second, smaller computers such as the PDP-1 and PDP-10 provided similar direct interaction, while 1970s workstations such as the Alto and Lisp Machines added graphical displays and mouse input.

### Lisp
The Lisp programming language (in the form of LISP 1.5 \cite{LISP15}) was designed before the rise of interactive computers. Nevertheless, the existence of an interpreter plus the absence of declarations made it natural to use Lisp interactively, with the first interactive implementations appearing in the early 1960s. Two branches of the Lisp family,^[The Lisp family consists of several branches, including MacLisp, InterLisp, ZetaLisp, Common Lisp, Scheme, Racket, and Clojure. see \cite{LispEvolve}] MacLisp and the later Interlisp, fully embraced the so called "conversational" way of working. Interaction occured through the teletype at first, later giving way to the screen and keyboard. Even on the teletype, the system incorporated a number of ideas that remain popular with programming systems today.

Both MacLisp and Interlisp adopted the idea of *persistent address space*. The address space (what Smalltalk calls the *image*) contained both program code and program state, meaning that both could be accessed and modified interactively as well as programmatically using the *same means*. This idea of persistent address space appeared on time-sharing systems and culminated with the development of Lisp Machines, which embraced the idea that the machine runs continually and saves the state to disk when needed. Today, while this is still not the default state for systems running "natively" on some hardware, it is widely seen in cloud-based services like Google Docs and online IDEs.

One idea not widely seen today, yet pioneered in MacLisp and Interlisp, was the use of *structure editors*. These let programmers work with Lisp data structures not as sequences of characters, but as nested lists. In Interlisp, for example, the programmer would use commands such as `*P` to print the current expression, or `*(2 (X Y))` to replace its second element with the argument `(X Y)`. The PILOT system \cite{Pilot}, later integrated into Interlisp, offered even more sophisticated conversational features. For typographical errors and other slips, it would offer an automatic fix for the user to interactively accept, modifying the program in memory and resuming the execution.

### Smalltalk
Smalltalk came on the scene in the 1970s, with the ambition of providing "dynamic media which can be used by humans of all ages". The authors saw computers as *meta-media* that could become a range of other media for applications like animation, circuit design, simulation and others not yet invented. Smalltalk was designed for single-user workstations with graphical display, and this display was pioneered not just for applications, but also for programming. In Smalltalk 72, one wrote code in the bottom half of the screen. When editing a definition, the window became a structure editor logically similar to that in Lisp, but controlled using a mouse and menu instead of a teletype.

Smalltalk shared a number of other characteristics with Lisp, although its key concept was that of an *object* rather than a *list*. Today, Smalltalk is perhaps best known for adopting the aforementioned persistent address space model of programming, where all objects remain in memory. Any changes made to the system state by programming or execution are preserved when the computer is turned off. The graphical interface then provides easy access to all objects and their methods through the *object browser*. The fact that much of the Smalltalk environment was implemented in itself, a property shared with many Lisp later systems, made it possible to significantly modify the system from within.

### UNIX
Both Lisp and Smalltalk worked, to some extent, as operating systems. The user started their machine directly in the Lisp or Smalltalk environment and was able to do everything they needed from *within* the system.^[When the Lisp and Smalltalk systems were implemented on specialized computers---InterLisp and Smalltalk on the Alto and Xerox D, ZetaLisp and Common Lisp on Lisp machines---the user would start their computers directly in the programming system environment. When implemented on commodity hardware, the user would resume a saved image of the programming system.] This explains why it is worth considering (especially programmer-oriented) operating systems as programming systems as well. A prime example of this is UNIX, which was a simpler 1970s operating system for time-sharing computers.

As we discuss later under "Learnability & Sociability" (Section \ref{learnability-and-sociability}), many aspects of programming systems are shaped by their intended target audience. UNIX was built for computer hackers themselves and, as such, its interface is close to the machine. While everything is an object in Smalltalk, the ontology of the UNIX system consists of files, memory, executable programs, and running processes. Interestingly, there is an explicit stage distinction here, that is not present in Smalltalk or Lisp. The ontology, however, enables an open pluralistic environment.

## Early application platforms
The previously discussed programming systems did not focus on any particular kind of application. They were universal. As computers became more widely used, it became clear that there are typical kinds of applications that need to be built. For those, more specialized programming systems began to appear. Although they are more focused, they also support programming based on rich interactions with specialized visual and textual notations.

### Spreadsheets
Spreadsheets, along with word processors, were the application that turned personal computers from playthings for hackers into a business tool. The first system, VisiCalc, became available in 1979 and helped analysts perform budget calculations. Spreadsheets developed over time, acquiring features that made them into powerful programming systems in a way VisiCalc was not. The final step was the 1993 inclusion of *macros* in Excel, later extended with *Visual Basic for Applications*. As programming systems, spreadsheets are notable for their programming substrate (a grid) and evaluation model (automatic re-evaluation).

### HyperCard
While spreadsheets were designed to solve problems in a specific application area, the next system we consider was designed around a particular application format. 1987 saw HyperCard \cite{HyperCard}, with programs as "stacks of cards" containing multimedia components and controls such as buttons. The logic associated with the controls could be programmed with pre-defined operations (e.g. "navigate to another card") or otherwise via the HyperTalk scripting language.

As a programming system, HyperCard is interesting for a couple of reasons. It effectively combines visual and textual notation. Programs appear the same way during editing as they do during execution. Most notably, HyperCard supports gradual progression from the "user" role to "developer": a user may first use stacks, then go on to edit the visual aspects or choose pre-defined logic until, eventually, they learn to program in HyperTalk.

## Developer ecosystems
Programming systems such as Smalltalk and HyperCard are relatively *self-contained*. It is clear what is *part of* the system, and what is on the *outside*. For many systems that began to appear in the late 1980s, this is not the case. To think about them, we have to consider a number of components, some of which may be conventional programming languages.

### Early and late Web
The Web appeared in 1989 as a way of sharing and organizing information, implementing the ideas of *hypertext*. The web gradually evolved from an *information sharing* system to a *developer platform* when client-side scripting using JavaScript became possible. The Web ecosystem started to consist of server-side and client-side programming tools. Today, the Web combines the notations of HTML, CSS, a wide range of server-side programming systems as well as JavaScript, and many languages that compile to JavaScript.

In the 1990s, the "early Web" became a widely used programming system. JavaScript code was distributed in a form that made it easy to copy and re-use existing scripts, which led to enthusiastic adoption by non-experts. This is comparable to the birth of microcomputers like Commodore 64 with BASIC a decade earlier.

The Web ecosystem continued to evolve. In the 2000s, multiple programming languages started to treat JavaScript as a compilation target, while JavaScript started to be used as a programming language on the server-side. This defines the "late Web" ecosystem, which is quite different from its early incarnation. JavaScript code was no longer simple enough to whimsically copy and paste, yet advanced developer tools provided functionality resembling early interactive programming systems like Lisp and Smalltalk. The *Document Object Model (DOM)* structure created by a web page is transparent, accessible to the user and modifiable through the built-in browser debugging tools, and third-party code to modify the structure can be injected via extensions. In this, the DOM resembles the *persistent image* model. The DOM also inspired further research on image-based programming: Webstrates \cite{Webstrates} synchronizes DOM edits made in the browser to all other clients connected to a single server.

### REPLs and notebooks
Another kind of developer ecosystem that evolved from simple scripting tools are the modern tools for data science, such as Jupyter. Their roots date back to conversational implementations of Lisp, where users could type commands to be evaluated and see the results printed. This interaction became known as the REPL (Read-Eval-Print Loop). In the late 1980s, Mathematica 1.0 combined the REPL interaction with a notebook document format that shows the commands alongside visual outputs.

Today, REPLs exist for many programming languages. Unlike in Lisp, they are often separate from the running program. REPLs often maintain an execution state independent of a running program and there are many strategies for prototyping code in a REPL before making it a part of an ordinary compiled application.

Notebooks for data science are a particularly interesting example. Their primary output is the notebook itself, rather than a separate application to be compiled and run. The code lives in a document format, interleaved with other notations. Code is written in small parts that are executed (almost) immediately, offering the user more rapid feedback than in conventional programming. A notebook can be seen as a trace of how the result has been obtained, although one often problematic feature of notebooks is that they allow the user to run code blocks out-of-order. Retracing the individual steps in a notebook may thus be more subtle than following a trace produced from a conventional REPL (for example, using the `dribble` function in Common Lisp).

### Haskell and other languages
The aforementioned 1990s paradigm shift from thinking about *systems* to thinking about *languages* means that researchers tend to emphasize the language side of programming. However, all programming languages are a part of a richer ecosystem that consist of editors and other tools. In our analysis, we choose Haskell as our example as a clearly language-focused programming system.

Like most programming languages, Haskell code can be written in a wide range of text editors, some of which support assistance tools such as syntax highlighting and auto-completion. These offer immediate feedback while editing code, such as when highlighting type errors. This way, "lapse" and "slip" type errors are mitigated---we discuss this further under "Handling of Errors" (\ref{handling-of-errors}).

Haskell is mathematically rooted and relies on mathematical intuition for understanding many of its concepts. This background is also reflected in the notations it uses. In addition to the concrete language syntax (used when writing code), the Haskell ecosystem also uses an informal mathematical notation, which is used when writing about Haskell (e.g. in academic papers or on the whiteboard). This provides an additional tool for manipulating Haskell programs and experimenting with them on paper *"in vitro"*, in ways that other systems may attempt to achieve through experimentation within the system *"in vivo"*.

# Technical dimensions
In this section, we present our most worked-out technical dimensions under three *clusters*. This is a consequence of how we developed the framework. In the beginning, we considered these clusters the "dimensions" themselves---yet, as we added detail, they soon developed an internal "glossary" structure defining more primitive terms. Since it was easier to see how these primitives could be compared and assigned values for concrete systems, and unclear how the same would be possible for the clusters, we tentatively settled on the format that follows. The clusters may be regarded as "topics of interest" or "areas of inquiry" when studying a given system, grouping together related dimensions against which to measure it.

Each cluster is named and opens with a short *summary*, followed by a detailed *description*, and closes with a list of *examples* and any *relations* to other clusters. Within the main description, individual *dimensions* are identified. Sometimes, a particular value along a dimension (or a combination of values along several dimensions) can be recognized as a familiar pattern---perhaps with a name already established in the literature. These are marked as *instances*. Finally, interspersed discussion that is neither a *dimension* nor an *instance* is introduced as a *remark*.

For brevity, we present three dimension clusters from our current list, and leave the rest to the Appendix. These are *interaction structure*, *notational structure*, and *conceptual structure*.^[The fact that these all have "structure" in the name is a curious coincidence---more variety can be found in our less fleshed-out clusters in the Appendix.]

## Interaction structure
### Summary
How do users execute their ideas, evaluate the result, and generate new ideas in response?

### Description
An essential aspect of programming systems is how the user interacts with them when creating programs. Take the standard form of statically typed, compiled languages with straightforward library linking: here, programmers write their code in a text editor, invoke the compiler, and then read through error messages they get.

Other forms are yet possible. For example, the compilation or execution of a program can contain further nested programmer interactions, or they may not even be perceptible at all. To analyze all forms of programming, we use the concepts of *gulf of execution* and *gulf of evaluation* from *The Design of Everyday Things*\ \cite{Norman}.

#### Dimension: feedback loops
In using a system, one first has some idea and attempts to make it exist in the software; the gap between the user's goal and the means to execute the goal is known as the *gulf of execution*. Then, one compares the result actually achieved to the original goal in mind; this crosses the *gulf of evaluation*. These two activities comprise the *feedback loop* through which a user gradually realises their desires in the imagination, or refines those desires to find out "what they actually want".

A system must contain at least one such feedback loop, but may contain several at different levels or specialized to certain domains. For each of them, we can separate the gulf of execution and evaluation as independent legs of the journey, with possibly different manners and speeds of crossing them.

#### Instance: immediate feedback
\tp{What about the gulf of execution in this case? I guess this is not relevant, because you may still have poor ways of doing what you want despite having immediate feedback. Maybe worth saying this here?}

The specific case where the *evaluation* gulf is minimized to be imperceptible is known as *immediate feedback*. Once the user has caused some change to the system, its effects (including errors) are immediately visible. This is a key ingredient of *liveness*, though it is not sufficient on its own. (See *Relations*)

The ease of achieving immediate feedback is obviously constrained by the computational load of the user's effects on the system, and the system's performance on such tasks. However, such "loading time" is not the only way feedback can be delayed: a common situation is where the user has to manually ask for (or "poll") the relevant state of the system after their actions, even if the system finished the task quickly. Here, the feedback could be described as *immediate upon demand* yet not *automatically demanded*. However, for convenience, we include the latter criterion---automatic demand of result---in our definition of immediate feedback.

#### Instance: direct manipulation
The origin of *direct manipulation* is in the real world, such as programming a robot by physically dragging its arms to record the process that it will later replay. Since most interaction with software takes place through keyboards, screens, and mice, it is more common for this to be simulated.

In this case, direct manipulation is a special case of an immediate feedback loop. The user sees and interacts with an artefact in a way that is as similar as possible to real life; this typically includes dragging with a cursor or finger in order to physically move a visual item, and is limited by the particular haptic technology in use.

Naturally, because moving real things with one's hands does not involve any waiting for the object to "catch up"^[In some situations, such as steering a boat with a rudder, there is a delay between input and effect. But on closer inspection, this delay is between the rudder and the boat; we do not see the hand pass through the wheel like a hologram, followed by the wheel turning a second later. In real life, objects touched directly give immediate feedback; objects controlled further down the line might not!], direct manipulation is necessarily an immediate-feedback cycle. However, if one were to move a figure on screen by typing new co-ordinates in a text box, then this could still give immediate feedback (if the update appears instant and automatic) but would not be an example of direct manipulation.

#### Dimension: modes of interaction
Programming systems can give programmers different modes in which to operate, each mode potentially supporting different feedback loops. A typical example here is debugging. In many programming systems, the user can debug a running program and, in this mode, they can modify the program state and get (more) immediate feedback on what individual operations do. When a program is not running, and outside of debug mode, this kind of feedback loop is not available.

A programming system may also be designed with just a single mode. The Jupyter notebook environment does not have a distinct debugging mode; the user runs blocks of code and receives the result. The single mode can be used to quickly try things out, and to generate the final result. However, even Jupyter notebooks distinguish between editing a document and running code.

The idea of interaction modes goes beyond just programming systems, appearing in software engineering methodologies. In particular, having a separate *implementation* and *maintenance* phase would be an example of two modes.

\tp{I wonder if it would make sense to use footnotes more heavily in this paper? (Kind of in the same way in which philosophy books often have 1/4 of space at the end filled with footnotes. I kind of like the above last paragraph, but it could be a footnote to avoid diverging from the main idea. I think this could be applied to other places in this paper where we feel like adding more detail...)}

### Examples
\note{*UNIX* has two different forms of interaction - programming vs. devops}
\ \linebreak{} *Spreadsheets* have:

1. A tight, immediate feedback loop for direct manipulation of values and formatting. This is the same as in any other WYSIWYG application.
2. A loop for formula editing and formula invocation. Here, there is larger execution gulf for designing and typing formulas. The evaluation gulf is often reduced by editor features, e.g. immediate feedback previews for cell ranges. However, one sees what the *effect* of a formula is only on "committing" the formula, i.e. pressing enter.

In a *REPL* or *shell*, there is a main cycle of typing commands and seeing their output, and a secondary cycle of typing and checking the command line itself.

- The output of commands can be immediate, but usually reflects only part of the total effects or even none at all. The user must manually issue further commands afterwards, to check the relevant state bit by bit.
- The secondary cycle, like all typing, provides immediate feedback in the form of character "echo", but things like syntax errors are only reported *after* the entire line is submitted.
- One counterexample to this is Firefox's JavaScript console, where the line is "run" in a limited manner on every keystroke. Thus, simple commands without side-effects (e.g. a pure function call) can give instant previewed results, though partially typed expressions and syntax errors do not trigger previews.

\begin{figure}
  \centering
  \includegraphics[width=0.5\linewidth]{feedback-loops.png}
  \caption{The nested feedback loops of a statically-checked programming language.\label{fig:feedback-loops}}
\end{figure}

A statically checked *programming language* (e.g. Java, Haskell) involves several feedback loops (Figure \ref{fig:feedback-loops}):

1. The notation is plain monospaced text, so users will typically invoke another medium (pencil and paper, whiteboard, or another piece of software) to work out details (e.g. design, organization, mathematics) before translating this into code. This *supplementary medium* has its own feedback loop.
2. The code is written (through multiple iterations of cycle 1) and is then put through the static checker. Errors here send the user back to writing code, but in the case of success, they are "allowed" to run the program, leading into cycle 3.

    - The execution gulf comprises multiple cycles of the supplementary medium, plus whatever overhead is needed to invoke the compiler (such as build systems).
    - The evaluation gulf is essentially the waiting period before static errors or a successful termination are observed. Hence this is bounded by some function of the length of the code (the same cannot be said for the following cycle 3.)

3. With a runnable program, the user now evaluates the *runtime* behavior. Runtime errors can send the user back to writing code to be checked, or to tweak dynamically loaded data (e.g. data files) in a similar cycle.

    - The execution gulf here may include multiple iterations of cycle 2, each with its own nested cycle 1.
    - The *evaluation* gulf here is theoretically unbounded; one may have to wait a very long time or create very specific conditions to rule out certain bugs (e.g. race conditions) or simply to consider the program as fit for purpose.
    - The latter issue, of evaluating according to human judgement, is made tractable by targetting "good enough for this release" instead of some final, comprehensive measure.
    - By imposing static checks, some bugs can be pushed earlier to the evaluation stage of cycle 2, reducing the likely size of the cycle 3 *evaluation* gulf.
    - On the other hand, this can make it harder to write statically valid code, which may increase the number of level-2 cycles, thus increasing the total *execution* gulf at level 3.
    - Depending on how these balance out, the total top-level feedback loop may grow longer or shorter.

\tp{Add reference to modes. Debuggers for normal programming languages. There is no debugging mode in REPLs, not because it would not be possible, but because nobody needs it. A more extreme idea would be to merge execution with editing - I don't think we have an example of this though, so we can leave this for the evaluation when discussing Subtext...

Maybe Flash and Visual Basic, HyperCard have immediate feedback loops only in certain substrate (add reference to substrates)}


### Relations
- A longer evaluation gulf delays the detection of errors. A longer execution gulf can increase the *likelihood* of errors (e.g. writing a lot of code or taking a long time to write it). By turning runtime bugs into statically detected bugs, the combined evaluation gulfs can be reduced. All of these are implications for *handling of errors* (Section \ref{handling-of-errors}.)
- The *execution* gulf is concerned with software using and programming in general. The time taken to realizean idea in software is affected by the user's familiarity and the system's *learnability* (Section \ref{learnability-and-sociability}), as well as the *expressive power* of the system's ontology.
- *Liveness* is impossible without immediate feedback. However, the motto "The thing on the screen is supposed to be the actual thing" \cite{Live13} suggests that representations should be "canonical" in some sense, i.e. equipped with faithful behavior rather than intangible shadows cast by the hidden *real* object. This seems to overlap with Direct Manipulation and *bidirectionality*, but it is unclear if it is meant to be synonymous with them.
- Different *notational structures* have different feedback loops.

## Notational structure
### Summary
What are the different notations, both textual and visual, through which the system is programmed? How do they relate to each other when programming the system?

### Description
Programming is always done through some form of notation. We consider notations in the most general sense and include any structured gesture using textual or visual notation, user interface or other means. Textual notations include primarily programming languages, but may also include, for example, configuration files. Visual notations include graphical programming languages. Other kinds of structured gestures include, for example, user interfaces for constructing visual elements used in the system. *Cognitive Dimensions*\ \cite{CogDims} provides a comprehensive framework for analysing individual notations, but our focus here is on how multiple notations are combined, i.e., the notational structure.

In practice, most programming systems use multiple notations. Even when we consider traditional programming languages, those *primary notations* are often supported by *secondary notations* such as annotations encoded in comments, and build tool configuration files. More interestingly, some systems have multiple different *primary* notations. Those can be either provided as different ways of programming the same part of a system, or they can be provided as complementing ways of programming different aspects of a system.

#### Dimension: overlapping notations
A programming system may provide multiple notations for programming the same aspect of the system. An example is Sketch-n-sketch \cite{SnS}, a tool for creating and editing SVG and HTML documents. Sketch-n-sketch displays the source code of the document side-by-side with the resulting output. The author can edit either of the two. An edit in the source code will be immediately visible in the output, and editing the output will cause corresponding changes to the source code.

The crucial issue in this kind of arrangement is synchronization between the different notations. If the notations have different characteristics, this is not a straightforward mapping---for example, source code may allow a more elaborate abstraction mechanism (such as a loop) which will not be apparent in the output (it will result in visible repetitions). What should such system do when the user edits a single object that resulted from such repetition? For programming systems that use *overlapping notations*, we need to describe how the notations are synchronized.

#### Dimension: complementing notations
A programming system may also provide multiple complementing notations for programming different aspects of its world. An example is Excel spreadsheets, where there are two different notations that complement each other. The first is the formula language, where users describe calculations with data on the sheet. The second is the macro language (Visual Basic for Applications), which lets users automate the system in ways that go beyond what is possible through the formula language. There is also a third, even more basic, level which is entering data into the sheet. This cannot be used to specify new computations, but can be used to adapt or run a computation, for example when entering different alternatives in "What-If Scenario Analysis".

The key issue for systems with complementing notations is how the different notations are connected and how the user may progress from one to the next level if they need. In Excel, macros can be used to control the lower level (you can write macros that evaluate formulas).  This is also a question for learnability. In Excel, you need to learn a completely different language if you want to move to the macro level. The approach optimizes for easy learnability at one level, but introduces a hurdle that users have to cross to get to the second level.

#### Dimension: primary and secondary notations
Some systems have multiple primary notations. They can live alongside each other, but they can also be nested. In HyperCard \cite{HyperCard}, there is a visual "notation" for designing the user interface: the card itself, which can be edited directly. Then there is HyperScript, which is secondary and can be associated with individual controls.

Programming systems typically have further notations or structured gestures associated with them. The primary notation in UNIX is the C programming language. Yet this is enclosed in a programming *system* providing (multi-step) mechanisms for running C code via the terminal, assisted by secondary notations such as shell scripts. Even an ordinary programming language such as Java is only a part of (at least one) programming system that includes structured gestures---running code in Eclipse---and secondary notations for the management of dependencies and build configurations.

Some programming systems attempt to integrate tools that normally rely on secondary notations into the system itself, reducing the number of secondary notations that the programmer needs to master. For example, in the Smalltalk descendant Pharo, versioning and package management is done from within Pharo, removing the need for secondary notation such as `git` commands and dependency configuration files.^[The tool for versioning and package management in Pharo can still be seen as an *internal* domain-specific language and thus as a secondary notation, but its basic structure is *shared* with other notations in the Pharo system.]

#### Dimension: expression geography
A crucial feature of a notation is the relationship between the structure of the notation and the structure of the behavior it encodes. Most importantly, do *similar expressions*, in a particular notation, represent *similar behavior*?

In textual notations, this may easily not be the case. Consider the two C conditionals:

- `if (x==1) { ... }` evaluates the Boolean expression `x==1` to determine whether `x` equals `1`, running the code block if the condition holds.
- `if (x=1) { ... }` assigns `1` to the variable `x`. In C, assignment is an expression returning the assigned value, so the result `1` is interpreted as `true` and the block of code is *always* executed.

A notation can be designed to map better to the logic behind it, for example, by requiring the user to write `1==x`. This solves the above problem as `1` is a literal rather than a variable, so it cannot be assigned to (`1=x` is a compile error).

Visual notations may provide more or less direct mapping. On the one hand, similar-looking code in a block language may mean very different things. On the other hand, similar looking design of two HyperCard cards will result in similar looking cards---the mapping between the notation and the logic is much more direct in this case.

\tp{The idea of "expression geography" is due to Antranig, but I cannot find a reference to cite. Similarly "pedantic notations" is due to Thomas Green, but again, I cannot find a citation.}

#### Dimension: uniformity of notations
One common concern with notations is the extent to which they are uniform. A uniform notation can express a wide range of things using just a small number of concepts. The primary example here is S-expressions from Lisp. An S-expression is either an atom or a pair of S-expressions written `(s1 . s2)`. By convention, an S-expression `(s1 . (s2 . (s3 . nil)))` represents a list, written as `(s1 s2 s3)`. In Lisp, the uniformity of notations is closely linked to uniformity of representation. In the idealized model of LISP 1.5, the data structures represented by an S-expression is what exists in memory. In real-world Lisp systems, the representation in memory is more complex. A programming system can also take a very different approach and fully separate the notation from the in-memory representation.

Lisp source code is represented in memory as S-expressions, which can be manipulated by Lisp primitives. In addition, Lisp systems have robust macro processing as part of their semantics: expanding a macro revises the list structure of the code that uses the macro. Combining these makes it possible to define extensions to the Lisp system in Lisp with syntax indistinguishable from Lisp. Moreover, it is possible to write a Lisp program that constructs another Lisp program and not only run it interpretively (using the Lisp function \texttt{eval}) but compile it at runtime (using the Lisp function \texttt{compile}) and then execute it. Many domain-specific languages as well as prototypes of new programming languages (such as Scheme) were implemented this way. Lisp, the language, is, in this sense, a programmable programming language. \cite{LispIntro,ProgProgLang}

A programming system can also take a very different approach and fully separate the notation from the in-memory representation.


### Primary examples
- *Spreadsheets and HyperCard.* Spreadsheet systems such as Excel use complementing notations consisting of (i) the visual grid, (ii) formula language and (iii) macro language such as VBA. The notations are largely independent and have different degrees of expressivity. A user gradually learns more advanced notations, but experience with previous notation does not help with mastering the next one. The notational structure of HyperCard is similar and consists of (i) visual design of cards, (ii) visual programming (via menu) with a limited number of operations and (iii) HyperTalk for scripting.
- *Boxer and Jupyter.* Boxer \cite{Boxer} uses *complementing notations* in that it combines a visual notation (the layout of the document and the boxes it consists of) with textual notation (the code in the boxes). In case of Boxer, the textual notation is always nested within the visual. The case of Jupyter notebooks is similar---the document structure is graphical (edited by adding and removing cells); code and visual outputs are nested as cells in the document. This arrangement is common in many other systems such as Flash or Visual Basic, which both combine visual notation with textual code, although one is not nested in the other.
- *Haskell.* The primary notation is the programming language, but there are also a number of secondary notations. Those include package managers (e.g. the `cabal.project` file) or configuration files for Haskell build tools. More interestingly, there is also an informal mathematical notation associated with Haskell that is used when programmers discuss programs on a whiteboard or in academic publications. Indeed, the idea of having a mathematical notation dates back to the Report on Algol 58 \cite{Alg58}, which explicitly defined a "publication language" for "stating and communicating problems" that used Greek letters and subscripts.

### Further examples
- *Sketch-n-sketch.* Sketch-n-sketch \cite{SnS} is an example of a programming system that implements the *overlapping notations* structure. The user edits HTML/SVG files in an interface with a split-screen structure that shows source code on the left and displayed visual output on the right. They can edit both of these and changes are propagated to the other view. In terms of *expression geography*, the code can use abstraction mechanisms (such as functions) which are not visible in the visual editor. The visual view thus hides some aspects of the geography, but is more "pedantic" in other aspects. More generally, Sketch-n-sketch can be seen as an example of a *projectional editor*.
- *UML Round-tripping.* Another example of a programming system that utilizes the *overlapping notations* structure are UML design tools that display the program both as source code and as a UML diagram. Edits in one result in automatic update of the other. An example is the [Together/J](https://www.mindprod.com/jgloss/togetherj.html) system. In order to match the two notations, such systems often need to store additional information (e.g. location of classes in UML diagram after the user rearranges them) in the textual notation. This can be done by using a special kind of code comment.
- *Paper Tools*. The importance of notations in the practice of science, more generally, has been studied by Klein\ \cite{PaperTools} as "paper tools"---things like formulas, which can be manipulated by humans in lieu of experimentation. Programming notations are similar, but they are a way of communicating with a machine---the experimentation does not happen just on paper. One exception here is the mathematical notation in Haskell, which is used as a "paper tool" for experimentation on a whiteboard. In the context of programming notations, the Cognitive Dimensions framework \cite{CogDims} offers a detailed way of analysing individual notations.

\note{Maybe also: ORMs, coordinating DB schema and class definitions}

### Relations
- *Factoring of complexity* (Section \ref{factoring-of-complexity}): Using multiple complementing notations implicitly factors complexity by expressing different aspects of a program using different notations.
- *Interaction structure* (Section \ref{interaction-structure}): The feedback loops that exist in a programming system are typically associated with individual notations. Different notations may also have different feedback loops.
- *Learnability* (Section \ref{learnability-and-sociability}): Notational structure can affect learnability. In particular, complementing notations may require (possibly different) users master multiple notations. Overlapping notations may improve learnability by allowing the user to edit program in one way (e.g. visually) and see the effect in the other notation (e.g. in code).

\note{
## Conceptual structure

### Summary
What tradeoffs are made between conceptual integrity and compatibility with established technologies? Does the design seek unification or pluralism?

### Description
> I will contend that Conceptual Integrity is the most important consideration in system design. It is better to have a system omit certain anomalous features and improvements, but to reflect one set of design ideas, than to have one that contains many good but independent and uncoordinated ideas.---Fred Brooks \cite{brooks95aristo}

> The essence of this style can be captured by the phrase “the right thing”. To such a designer it is important to get all of the following characteristics right: Simplicity … Correctness … Consistency … Completeness---Richard Gabriel

Richard Gabriel first described the dilemma in his influential 1991 essay "Worse is Better" \cite{WIB} analyzing the defeat of Lisp by Unix and C. Because the latter were so easy to port to new hardware, they were “the ultimate computer viruses” despite providing only “about 50%--80% of what you want from an operating system and programming language”.

#### Technical Dimension: conceptual integrity vs compatibility
Programming systems face many choices between doing the right thing and the popular thing. Doing the right thing chooses technical power, simplicity, and elegance at the cost of reduced popularity. Doing the popular thing chooses better chances of adoption at the cost of conceptual complexity and ratcheting technical debt.

Today we live in a highly evolved world of software technology. It is estimated that 41,000 person years have been invested into Linux alone. We describe software development technologies in terms of *stacks* of specialized tools, each of which might capitalize over 100 person years of development. Dominant software technologies can not really be described as having been designed---they are more the result of a haphazard evolutionary history than intentional human design. There is a widespread belief that the currently dominant software technologies are unassailable, and that even considering alternatives is foolish idealism.

But the history of computing tells another story, one of cycles of evolution and revolution. Successive cycles were dominated in turn by mainframes, minicomputers, workstations, personal computers, and the web. Each transition built a whole new technology ecosystem replacing or on top of the previous. The last revolution, the web, was 25 years ago. Many people have not lived through a disruptive platform transition, and naturally assume Unix and the Web are unalterable facts of life. Perhaps history has indeed ended, or perhaps we are just stuck in a long cycle, with increasingly pent-up pressures for change? If it is the latter, then progress may again become possible, and paths abandoned in previous cycles can be reopened.

#### Remark: the personal is the technological
The fundamental tradeoff between conceptual integrity and compatibility seems to correlate with certain personality traits: introverts and idealists tend to favor conceptual integrity and reject social pressures, while extroverts and pragmatists are more willing to conform to custom in order to succeed in the marketplace.

It is reasonable to ask which came first: the design decision or the personality trait? Do Lisp and Haskell teach people to think more abstractly and coherently, or do they filter for those with a preexisting condition? Likewise, introverted developers might self-select for the cloisters of Smalltalk or Lisp while extroverts might be drawn to the adventurous Wild West of the Web.

#### Dimension: unification vs pluralism
A recurring strategy to achieve conceptual integrity is unification. If many seemingly different things can instead be seen as configurations of some common thing, then a lot of complexity can be factored out. For example, Smalltalk and Lisp provide a uniform way to compose elements: *objects* and *lists*^[LISP 1.5 also had arrays but no literal syntax for them; later Lisps supported many other types of collections, data structures, and object systems, but kept code as lists.], respectively. Likewise, their programming environments have a uniform representation for code: Smalltalk classes in the one case, and simply more lists in the other. The great advantage to everything being constructed the same way is that code written to handle those things becomes universally applicable, avoiding the babel of many languages for saying the same thing.

This sort of expansive unification is often called "Everything is an X". The *Memory Models of Programming Languages* essay \cite{MemMod} suggests further examples:

- In COBOL, state consists of nested records in a tax form.
- In Fortran, state consists of parallel arrays.
- In SQL, state is a set of relations with key constraints.

Python does not follow an "Everything is an X" metaphor, yet still pursures unity in a different way. It follows the principle that “There should be one---and preferably only one---obvious way to do it” in order to promote community consensus on a unified style.

The opposite strategy is to embrace the flexibility and power of pluralism. Python famously contradicts Perl, whose motto states “There is more than one way to do it.” and considers itself “the first postmodern programming language” \cite{Perl}. “Perl doesn't have any agenda at all, other than to be maximally useful to the maximal number of people. To be the duct tape of the Internet, and of everything else.”

Unix also chooses a pluralistic unification: everything is a file containing an array of bytes^[With the escape hatch of `ioctl` calls.], or a directory naming other files and directories. But files are "large objects" \cite{KellOS} that provide relatively little insight into their contents or how they are processed. Nevertheless, files allow many different sorts of things to be handled to some extent similarly. The Web adds MIME datatypes to the Unix file abstraction, which has proven to be a very propitious choice. Unix and the Web have had such overwhelming success with their pluralistic strategy that they have become the dominant technologies to which most others must conform.

Richard Gabriel observes that pluralism is inescapable: “Conceptual integrity arises not (simply) from one mind or from a small number of agreeing resonant minds, but from sometimes hidden co-authors and the thing designed itself.”\cite{DesignedAsDesigner}

### Examples
\ \linebreak{} *Unix and C*: Unix rapidly spread across many hardware architectures because C served as a portable assembly language. Porting Unix requires only bootstrapping a C compiler and writing some device drivers. The tradeoff is that C is very weakly specified, with many platform dependencies and undefined behaviors.

*The Unix Programming Environment*: Unix establishes many standard formats and APIs for modularly constructing systems, and a set of utilities and conventions for program development. Examples are the Posix APIs, the ELF executable file format, the text piping constructors of the shell, and the infrastructure of programming tools like `vi` and `make`. The tradeoff is that these fixed boundaries stifle innovation. It is difficult to build a cross-process datastore other than a file system. Programming languages are limited to transforming textual source files into binary executables.

*The Web*: HTTP endpoints have proven to be an even more adaptable and viral abstraction than Unix files. They operate at a similar level of abstraction as files, but support richer content and encompass internet-wide interactions between autonomous systems. In a sense HTTP GET and PUT have become the "subroutine calls" of an internet-scale programming system. The most surprising thing about the web is that its success came as such a surprise to everyone involved in designing it or competing with it.

*Smalltalk and Lisp machines*: These classical systems offered a conceptually coherent and self-sufficient programming world using a single programming language throughout. This coherence offered great leverage to experts, many of whom now swear that nothing since has come close. The tradeoff was that these systems were isolated from the rapidly evolving mainstream of heterodox programming. Early implementations of Smalltalk ran on custom hardware, and were ported to standard systems at a very low level, taking over control of disks and displays at the hardware level. Several companies and universities built Lisp machines. Later implementations of Smalltalk and Lisp improved interoperability with the outside world, but still as a somewhat second-class citizen.

*C\++*: C\++ added to C the OO (Object Oriented) concepts pioneered by Smalltalk, while remaining 100% compatible with C, down to the level of ABI and performance. This strategy was enormously successful for adoption, but came with the tradeoff of enormous complexity compared to languages designed from scratch for OO, like Smalltalk, Ruby, and Java.

*Perl and Python*: Perl claims to be a *postmodern* programming language in which “There is more than one way to do it”, enabling idiosyncrasy. In Python the principle that “There should be one---and preferably only one---obvious way to do it” promotes community consensus on a single coherent style.

*Imperative vs Functional Programming*: Imperative programming embraces the hardware capability to write anywhere in memory through any pointer, whereas functional programming creates a higher-level and safer world of immutable data at the cost of more awkward interaction with the external stateful world.

\note{*Pluralistic programming*: Aspect oriented programming, context oriented programming, postmodern programming, mashups, integration domains.}

\tp{Interestingly, most "good old systems" are coherent. There are two exceptions: UNIX and Web (from our list of cool things) - UNX and Web are infinitely repurposeable - this is very admirable}

### Relations
\ \linebreak{} *Factoring of Complexity* (Section \ref{factoring-of-complexity}): Normalizing redundancy across interrelated descriptions improves coherence.

\note{
### References
- https://en.wikipedia.org/wiki/The\_Mythical\_Man-Month
- https://dreamsongs.com/WIB.html
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
}

## Conceptual structure

### Summary
What tradeoffs are made between conceptual integrity and diversity? How compatible is the system with established technologies? How open is it to the changing practices of the software industry?

### Description
> I will contend that Conceptual Integrity is the most important consideration in system design. It is better to have a system omit certain anomalous features and improvements, but to reflect one set of design ideas, than to have one that contains many good but independent and uncoordinated ideas. ---\ Fred Brooks \cite{brooks95aristo}

\note{The essence of this style can be captured by the phrase “the right thing”. To such a designer it is important to get all of the following characteristics right: Simplicity … Correctness … Consistency … Completeness --- Richard Gabriel}

> Conceptual integrity arises not (simply) from one mind or from a small number of agreeing resonant minds, but from sometimes hidden co-authors and the thing designed itself. ---\ Richard Gabriel \cite{DesignedAsDesigner}

The evolution of programming systems has led away from conceptual integrity, towards an enormously complex ecosystem of specialized technologies and standards. Any attempt to unify parts of this ecosystem into a coherent whole will create *incompatibility* with the remaining parts, which becomes a major barrier to adoption. Designers seeking adoption are pushed to focus on localized incremental improvements that stay within the boundaries of existing practice. This tension manifests in two dimensions: how open we are to the pressures imposed by society, and how highly we value conceptual elegance.

#### Dimension: conceptual integrity
Smalltalk and Lisp elegantly provide a uniform way to compose elements: *objects* and *lists*^[ISP 1.5 also had arrays but no literal syntax for them; later Lisps supported many other types of collections, data structures, and object systems, but kept code as lists.], respectively. In UNIX, everything is a file allowing reading and writing of a binary data stream^[With the escape hatch of `ioctl` calls.], or a directory naming other files and directories. The great advantage to everything being the same sort of thing is that code written to handle those things becomes universally applicable. One avoids the babel of many languages for saying the same thing.

The *Memory Models of Programming Languages* essay \cite{MemMod} suggests further examples:

- In COBOL, state consists of nested records in a tax form.
- In Fortran, state consists of parallel arrays.
- In SQL, state is a set of relations with key constraints.

#### Dimension: conceptual openness
The choice between compatibility and integrity correlates with the personality traits of pragmatism and idealism. It is pragmatic to accept the status quo of technology and make the best of it. Conversely, idealists are willing to fight convention and risk rejection in order to attain higher goals. We can wonder which came first: the design decision or the personality trait? Do Lisp and Haskell teach people to think more abstractly and coherently, or do they filter for those with a preexisting condition? Likewise, introverted developers might prefer the cloisters of Smalltalk or Lisp to the adventurous Wild West of the Web.


#### Dimension: conceptual granularity
\tp{Smalltalk objects are "all levels of granularity"; UNIX files are large-scale; Haskell data structures small-scale; very big virtual machines; there is also the web / distributed file system?}

Many programming languages and systems impose structure at a "fine granularity": that of individual variables and other data and code structures. This replaces and constrains the flat, "anything goes" memory landscape of the machine level, and the similar "run it and see what happens" indifference of machine instruction streams. Conversely, systems like UNIX or the Web impose fewer restrictions on how programmers represent things---in UNIX's case, delegating all fine-grained structure to the client program and insisting only on a basic infrastructure of "large objects" \cite{KellOS}. The price to pay for this flexibility is that the system can provide relatively little insight into "what is going on" inside the programs if they use a peculiar representation.

#### Instances: worse is better

\tp{UNIX vs Lisp - difference comes from the outside - conceptual opennness}

Richard Gabriel first described the problem in his influential 1991 essay "Worse is Better" \cite{WIB} analyzing the defeat of Lisp by Unix/C. Because Unix and C were so easy to port to new hardware, they were “the ultimate computer viruses” despite providing only “about 50%--80% of what you want from an operating system and programming language”. Their conceptual openness meant that they adapted well to the evolving conditions of the external world.

#### Remark: the end of the history?

Today we live in a highly developed world of software technology. It is estimated that 41,000 person years have been invested into Linux. We describe software development technologies in terms of *stacks* of specialized tools, each of which might capitalize over 100 person years of development. Programming system designers face an existential question: how to make a noticeable impact on the overwhelming edifice of existing technology? There are strong incentives to focus on localized incremental improvements that don’t cross the established boundaries.

The history of computing is one of cycles of evolution and revolution. Successive cycles were dominated in turn by mainframes, minicomputers, workstations, personal computers, and the web. Each transition built a whole new technology ecosystem replacing or on top of the previous. The last revolution, the web, was 25 years ago. Many people have never experienced a disruptive platform transition. Has history stopped, or are we just stuck in a long cycle, with increasingly pent-up pressures for change? If it is the latter, then incompatible ideas now spurned may yet flourish.

#### Instances: living with pluralism

\tp{Python vs Perl - difference comes from the inside - conceptual integrity}

Python and Perl provide opposite examples when it comes to conceptual integrity. On the one hand, Python follows the principle that “There should be one---and preferably only one---obvious way to do it” in order to promote community consensus on a single coherent style. On the other hand, Perl states that “There is more than one way to do it.” and considers itself “the first postmodern programming language” \cite{Perl}. “Perl doesn't have any agenda at all, other than to be maximally useful to the maximal number of people. To be the duct tape of the Internet, and of everything else.”

The Perl way is to accept the status quo of evolved chaos and build upon it using duct tape and ingenuity. Taken to the extreme, a programming system becomes no longer properly speaking a system, but rather a toolkit for improvising assemblages of found software. This perspective may reveal a path between the Scylla of compatibility and the Charybdis of coherence. It has appealing connections to the philosophies of Postmodernism and Pluralism. Unfortunately, efforts in this direction have so far had limited success.

### Examples
- *Unix and C*: Unix rapidly spread across many hardware architectures because C served as a portable assembly language. Porting Unix requires only bootstrapping a C compiler and writing some device drivers. The tradeoff is that C is very weakly specified, with many platform dependencies and undefined behaviors.
- *The Unix Programming Environment*: Unix establishes many standard formats and APIs for modularly constructing systems, and a set of utilities and conventions for program development. Examples are the Posix APIs, the ELF executable file format, the text piping constructors of the shell, and the infrastructure of programming tools like `vi` and `make`. The tradeoff is that these fixed boundaries stifle innovation. It is difficult to build a cross-process datastore other than a file system. Programming languages are limited to transforming textual source files into binary executables.
- *The Web*: HTTP endpoints have proven to be an even more adaptable and viral abstraction than Unix files. They operate at a similar level of abstraction as files, but support richer content and encompass internet-wide interactions between autonomous systems. In a sense HTTP GET and PUT have become the "subroutine calls" of an internet-scale programming system. The most surprising thing about the web is that its usefullness came as a surprise to everyone involved in designing it or competing with it.
- *Smalltalk and Lisp machines*: These classical systems offered a conceptually coherent and self-sufficient programming world using a single programming language throughout. This coherence offered great leverage to experts, many of whom now swear that nothing since has come close. The tradeoff was that these systems were isolated from the rapidly evolving mainstream of heterodox programming. Early implementations of Smalltalk ran on custom hardware, and were ported to standard systems at a very low level, taking over control of disks and displays at the hardware level. Several companies and universities built Lisp machines. Later implementations of Smalltalk and Lisp improved interoperability with the outside world, but still as a somewhat second-class citizen.
- *C\++*: C\++ added to C the OO (Object Oriented) concepts pioneered by Smalltalk, while remaining 100% compatible with C, down to the level of ABI and performance. This strategy was enormously successful for adoption, but came with the tradeoff of enormous complexity compared to languages designed from scratch for OO, like Smalltalk, Ruby, and Java.
- *Perl and Python*: Perl claims to be a *postmodern* programming language in which “There is more than one way to do it”, enabling idiosyncrasy. In Python the principle that “There should be one---and preferably only one---obvious way to do it” promotes community consensus on a single coherent style.
- *Imperative vs Functional Programming*: Imperative programming embraces the hardware capability to write anywhere in memory through any pointer, whereas functional programming creates a higher-level and safer world of immutable data at the cost of more awkward interaction with the external stateful world.

\note{*Pluralistic programming*: Aspect oriented programming, context oriented programming, postmodern programming, mashups, integration domains.}

\tp{Interestingly, most "good old systems" are coherent. There are two exceptions: UNIX and Web (from our list of cool things) - UNX and Web are infinitely repurposeable - this is very admirable}

### Relations
\ \linebreak{} *Factoring of complexity* (Section \ref{factoring-of-complexity}): Normalizing redundancy across interrelated descriptions improves coherence.

\note{
### References
- https://en.wikipedia.org/wiki/The\_Mythical\_Man-Month
- https://dreamsongs.com/WIB.html
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
There is a renewed interest in developing new programming systems. Such systems go beyond the simple model of code written in a programming language using a more or less sophisticated text editor. They combine textual and visual notations, create programs through rich graphical interactions, and challenge accepted assumptions about program editing, execution and debugging. Despite the growing number of novel programming systems, it remains difficult to evaluate the novelty of programming systems and see how they improve over work done in the past. To address the issue, we proposed a framework of “technical dimensions” that captures essential characteristics of programming systems in a qualitative but rigorous way.

The framework of technical dimensions puts the vast variety of programming systems, past and present, on a common footing of commensurability. This is crucial to enable the strengths of each to be identified and, if possible, combined by designers of the next generation of programming systems. As more and more systems are assessed in the framework, a picture of the space of possibilities will gradually emerge. Some regions will be conspicuously empty, indicating unrealized possibilities that could be worth trying. In this way, a domain of "normal science" is created for the design of programming systems.

# Acknowledgements
We would like to thank Richard Gabriel for his detailed comments and shepherding of the drafts for this paper. We also thank the committee of the *Pattern Languages of Programming (PLoP)* conference, who enabled such a collaboration for our submission. We have additionally benefited from discussions with members of the *Temporary Computing Collective* during its regular reading group and elsewhere.
