\setlength{\epigraphwidth}{0.7\linewidth}
\epigraph{A systematic presentation removes ideas from the ground that made them grow and arranges them in an artificial pattern.}{\textit{The Tyranny of Science} \\ \textsc{Paul Feyerabend}}

\joel{
\renewcommand{\epigraphflush}{flushleft}
\renewcommand{\sourceflush}{flushleft}
}

\epigraph{Irony is said to allow the artist to continue his creative production while immersed in a sociocultural context of which he is critical.}{\emph{Irony; or, the Self-Critical Opacity of Postmodernist Architecture} \\ \textsc{Emmanuel Petit} }


# Introduction

Many forms of software have been developed to enable programming. The classic form consists of a *programming language*, a text editor to enter source code, and a compiler to turn it into an executable program. Instances of this form are differentiated by the syntax and semantics of the language, along with the implementation techniques in the compiler or runtime environment. Since the advent of graphical user interfaces (GUIs), programming languages can be found embedded within graphical environments that increasingly define how programmers work with the language---for instance, by directly supporting debugging or refactoring. Beyond this, the rise of GUIs also permits diverse visual forms of programming, including visual languages and GUI-based end-user programming tools. This paper advocates a shift of attention from *programming languages* to the more general notion of "software that enables programming"---in other words, *programming systems*.

\begin{defn}[Programming System]
A \emph{programming system} is an integrated and complete set of tools sufficient for creating, modifying, and executing programs. These will include notations for structuring programs and data, facilities for running and debugging programs, and interfaces for performing all of these tasks. Facilities for testing, analysis, packaging, or version control may also be present. Notations include programming languages and interfaces include text editors, but are not limited to these.
\end{defn}

This notion covers classic programming languages together with their editors, debuggers, compilers, and other tools. Yet it is intentionally broad enough to accommodate image-based programming environments like Smalltalk, operating systems like UNIX, and hypermedia authoring systems like Hypercard, in addition to various other examples we will mention.

## What is the problem?

There is a growing interest in broader forms of *programming systems*, both in the programming research community and in industry. On the one hand, researchers are studying topics such as *programming experience* and *live programming* that require considering not just the *language*, but further aspects of a given system. On the other hand, commercial companies are building new programming environments like Replit\ \cite{ReplitWeb} or low-code tools like Dark\ \cite{DarkWeb} and Glide\ \cite{GlideWeb}. Yet, such topics remain at the sidelines of mainstream programming research. While *programming languages* are a well-established concept, analysed and compared in a common vocabulary, no similar foundation exists for the wider range of *programming systems*.

The academic research on programming suffers from this lack of common vocabulary. While we may thoroughly assess programming *languages*, as soon as we add interaction or graphics into the picture, evaluation beyond subjective "coolness" becomes fraught with difficulty \cite{EvUISR}. Moreover, when designing new systems, inspiration is often drawn from the same few standalone sources of ideas. These might be influential past systems like Smalltalk, programmable end-user applications like spreadsheets, or motivational illustrations by thinkers like Victor\ \cite{BretVictor}.

Instead of forming a solid body of work, the ideas that emerge are difficult to relate to each other. The research methods used to study programming systems lack the rigorous structure of programming language research methods. They tend to rely on singleton examples, which demonstrate the author's ideas, but are inadequate methods for comparing new ideas with the work of others. This makes it hard to build on top and thereby advance the state of the art.

Studying *programming systems* is not merely about taking a programming language and looking at the tools that surround it. It presents a *paradigm shift* to a perspective that is, at least partly, *incommensurable* with that of languages. When studying programming languages, everything that matters is in the program code; when studying programming systems, everything that matters is in the *interaction* between the programmer and the system. As documented by Gabriel \cite{PLrev}, looking at a *system* from a *language* perspective makes it impossible to think about concepts that arise from interaction with a system, but are not reflected in the language. Thus, we must proceed with some caution. As we will see, when we talk about Lisp as a programming system, we mean something very different from a parenthesis-heavy programming language!

## Contributions
We propose a common language as an initial step towards a more progressive research on programming systems. Our set of *technical dimensions* seeks to break down the holistic view of systems along various specific "axes". The dimensions identify a range of possible design choices, characterized by two extreme points in the design space. They are not quantitative, but they allow comparison by locating systems on a common axis. We do not intend for the extreme points to represent "good" or "bad" designs; we expect any position to be a result of design trade-offs. At this stage we encourage agreement on descriptions of systems first, in order to settle any normative judgements later.

The set of dimensions can be understood as a map of the design space of programming systems (Figure\ \ref{fig:tech-dims-diagram}). Past and present systems will serve as landmarks, and with enough of them, unexplored or overlooked possibilities will reveal themselves. So far, the field has not been able to establish a virtuous cycle of feedback; it is hard for practitioners to situate their work in the context of others' so that subsequent work can improve on it. Our aim is to provide foundations for the study of programming systems that would allow such development.

This paper is intended as a reference on the current state of the technical dimensions framework and it is meant to be _used_ rather than _read_. We present the dimensions in detail, but encourage the reader to skim through the details on the first read. Subsequently, we suggest revisiting dimensions which seem relevant to a concrete system known to the reader. The main contributions of this paper are organized as follows:

1. In Section\ \ref{programming-systems}, we characterize what a programming system is and review landmark programming systems of the past that are used as examples throughout this paper, as well as to delineate our notion of a programming system.
2. We present the technical dimensions in detail, organised into related clusters: *interaction*, *notation*, *conceptual structure*, *customizability*, *complexity*, *errors*, and *adoptability*. For each dimension, we give examples that illustrate the range of values along its axis. We intend this as a reference to be used as needed rather than something to be read from start to finish, so we recommend skimming the catalogue on the first reading.
2. In Section\ \ref{evaluation}, we sketch two ways of using the technical dimensions framework. In Section\ \ref{evaluating-the-dark-programming-system}, we use it to evaluate a recent interesting programming system; in Section\ \ref{exploring-the-design-space}, we use it to identify an unexplored point in the design space and envision a potential novel programming system.

\begin{figure}
  \centering
  \includegraphics[width=0.6\linewidth]{plot-figure0.pdf}
  \caption{One 2-dimensional slice of the space of possible systems, to be examined in more detail in Section\ \ref{exploring-the-design-space}.\label{fig:tech-dims-diagram}}
\end{figure}

# Related work

While we do have new ideas to propose, part of our contribution is integrating a wide range of *existing* concepts under a common umbrella. This work is spread out across different domains, but each part connects to programming systems or focuses on a specific characteristic they may have.

\paragraph{From languages to systems.}
Our approach lies between a narrow focus on programming languages and a broad focus on programming as a socio-political and cultural subject. Our concept of a programming system is technical in scope, although we acknowledge the technical side often has important social implications as in the case of the "Adoptability" dimension (Section\ \ref{adoptability}). This contrasts with the more socio-political focus found in Tchernavskij \cite{TcherDiss} or in software studies \cite{SwStudies}. It overlaps with Kell's conceptualization of UNIX, Smalltalk, and Operating Systems generally\ \cite{KellOS}, and we have ensured that UNIX has a place in our framework.

The distinction between more narrow _programming languages_ and broader _programming systems_ is more subtle. Richard Gabriel noted an invisible paradigm shift from the study of "systems" to the study of "languages" in computer science \cite{PLrev}, and this observation informs our distinction here. One consequence of the change is that a *language* is often formally specified apart from any specific implementations, while *systems* resist formal specification and are often *defined by* an implementation. We recognize programming language implementations as a *small region* of the space of possible systems, at least as far as interaction and notations might go. Hence we refer to the *interactive programming system* aspects of languages, such as text editing and command-line workflow.

\paragraph{Programming systems research.}
There is renewed interest in programming systems in the form of recent non-traditional programming tools:

- Computational notebooks such as Jupyter simplify data analysis by combining code snippets with text and visual output. They are backed by stateful "kernels" and used interactively.
- "Low code" end-user programming systems allow application development (mostly) through a GUI. One example is Coda \cite{CodaWeb}, which combines tables, formulas, and scripts to enable non-technical people to build "applications as documents".
- Domain-specific programming systems such as Dark, which claims a "holistic" programming experience for cloud API services. This includes a language, a direct manipulation editor, and near-instantaneous building and deployment.
- Even for general purpose programming with conventional tools, systems like Replit have demonstrated the benefits of integrating all needed languages, tools, and user interfaces into a seamless experience, available from the browser, that requires no setup.

Research that follows the programming systems perspective can be found in a number of research venues. Those include Human-Computer Interaction conferences such as [UIST](https://uist.acm.org/)^[ACM Symposium on User Interface Software and Technology] and [VL/HCC](https://conferences.computer.org/VLHCC/)^[IEEE Symposium on Visual Languages and Human-Centric Computing]. However, work in those often emphasizes the user experience over technical description. Programming systems are often presented in workshops such as [LIVE](https://liveprog.org/) and [PX](https://2021.programming-conference.org/home/px-2021)^[Programming eXperience]. However, work in those venues is often limited to the authors' individual perspectives and suffers from the aforementioned difficulty of comparing to other systems.

Concrete examples of systems appear throughout the paper. Recent systems which motivated some of our dimensions include Subtext \cite{Subtext}, which combines code with its live execution in a single editable representation; Sketch-n-sketch \cite{SnS}, which can synthesize code by direct manipulation of its outputs; Hazel \cite{Hazel}, a live functional programming environment with typed holes to enable execution of incomplete or ill-typed programs; and Webstrates \cite{Webstrates}, which extends Web pages with real-time sharing of state.

\paragraph{Already-known characteristics.}
There are several existing projects identifying characteristics of programming systems. Some revolve around a single one, such as levels of liveness \cite{Liveness}, or plurality and communicativity \cite{KellComm}. Others propose an entire collection. *Memory Models of Programming Languages*\ \cite{MemMod} identifies the "everything is an X" metaphors underlying many programming languages; the *Design Principles of Smalltalk*\ \cite{STdesign} documents the philosophical goals and dicta used in the design of Smalltalk; the "Gang of Four" *Design Patterns*\ \cite{DesPats} catalogues specific implementation tactics; and the *Cognitive Dimensions of Notation*\ \cite{CogDims} introduces a common vocabulary for software's *notational surface* and for identifying their trade-offs.

The latter two directly influence our proposal. Firstly, the Cognitive Dimensions are a set of qualitative properties which can be used to analyze *notations*. We wish to extend this approach to the "rest" of a system, beyond its notation, with *Technical* Dimensions. Secondly, our individual dimensions naturally fall under larger *clusters* that we present in a regular format, similar to the presentation of the classic Design Patterns. As for characteristics identified by others, part of our contribution is to integrate them under a common umbrella: liveness, pluralism, and uniformity metaphors ("everything is an X"), which have already been identified by others, become dimensions in our framework.

\paragraph{Methodology.}
We follow the attitude of *Evaluating Programming Systems*\ \cite{EvProgSys} in distinguishing our work from HCI methods and empirical evaluation. We are generally concerned with characteristics that are not obviously amenable to statistical analysis (e.g. mining software repositories) or experimental methods like controlled user studies, so numerical quantities are generally not featured.

Similar development seems to be taking place in HCI research focused on user interfaces. The UIST guidelines \cite{UISTAuthor} instruct authors to evaluate system contributions holistically, and the community has developed heuristics for such evaluation, such as *Evaluating User Interface Systems Research*\ \cite{EvUISR}. Our set of dimensions offers similar heuristics for identifying interesting aspects of programming systems, though they focus more on underlying technical properties than the surface interface.

Finally, we believe that the aforementioned paradigm shift from programming systems to programming languages has hidden many ideas about programming that are worthwhile recovering and developing further \cite{ComplementaryBasic}. Thus our approach is related to the idea of _complementary science_ developed by Chang\ \cite{Chang} in the context of history and philosophy of science. Chang argues that even in disciplines like physics, superseded or falsified theories may still contain interesting ideas worth documenting. In the field of programming, where past systems are discarded for many reasons besides empirical failure, Chang's _complementary science_ approach seems particularly suitable.

\paragraph{Programming systems deserve a theory too!}
In short, while there is a theory for programming languages, programming *systems* deserve a theory too. It should apply from the small scale of language implementations to the vast scale of operating systems. It should be possible to analyse the common and unique features of different systems, to reveal new possibilities, and to build on past work in an effective manner. In Kuhnian terms, it should enable a body of "normal science": filling in the map of the space of possible systems (Figure \ref{fig:tech-dims-diagram}), thereby forming a knowledge repository for future designers.

# Programming systems

We introduce the notion of a _programming system_ through a number of example systems. We draw them from three broad reference classes:

- Software ecosystems built around a text-based programming _language_. They consist of a set of tools such as compilers, debuggers, and profilers. These tools may exist as separate command-line programs, or within an Integrated Development Environment.

- Those that resemble an _operating system_ (OS) in that they structure the execution environment and encompass the resources of an entire machine (physical or virtual). They provide a common interface for communication, both between the user and the computer, and between programs themselves.

- Programmable _applications_, typically optimized for a specific domain, offering a limited degree of programmability which may be increased with newer versions.

We will proceed to detail some systems under this grouping. This will provide an intuition for the notion of a programming system and establish a collection of go-to examples for the rest of the paper.

## Systems based around languages

We see programming systems as (collections of) software artifacts that make it possible to construct programs, debug them, and turn them into operational, maintained, and evolvable artifacts running on an appropriate hardware. Text-based programming languages sit within programming systems whose boundaries are not explicitly defined. To speak of a programming system, we need to consider a language with, at minimum, an editor and a compiler or interpreter. However, the exact boundaries are a design choice that significantly affects our analysis.

\paragraph{Java with the Eclipse ecosystem.}
Java \cite{Java} cannot be viewed as a programming system on its own, but it is one if we consider it as embedded in an ecosystem of tools. There are multiple ways to delineate this, resulting in different analyses. A minimalistic programming system would consist of a text editor to write Java code and a command line compiler. A more realistic system is Java as embedded in the Eclipse IDE \cite{Eclipse}. The programming systems view allows us to see all there is beyond the textual code. In the case of Eclipse, this includes the debugger, refactoring tools, testing and modelling tools, GUI designers, and so on. This delineation yields a programming system that is powerful and convenient, but has a large number of concepts and secondary notations.

\paragraph{Haskell tools ecosystem.}
Haskell is an even more language-focused programming system. It is used through the command-line *GHC* \cite{GHC} compiler and *GHCi* REPL, alongside a text editor that provides features like syntax highlighting and auto-completion. In general, we can consider any editor that supports the Language Server Protocol \cite{LSP}.

Haskell is mathematically rooted and relies on mathematical intuition for understanding many of its concepts. This background is also reflected in the notations it uses. In addition to the concrete language syntax for writing code, the ecosystem also uses an informal mathematical notation for writing about Haskell (e.g. in academic papers or on the whiteboard). This provides an additional tool for manipulating Haskell programs. Experiments on paper can provide a kind of rapid feedback that other systems may provide through live programming.

\paragraph{From REPLs to notebooks.}
A different kind of developer ecosystem that evolved around a programming language is the Jupyter notebook platform \cite{Jupyter}. In Jupyter, data scientists write scripts divided into notebook cells, execute them interactively and see the resulting data and visualizations directly in the notebook itself. This brings together the REPL, which dates back to conversational implementations of Lisp in the 1960s, with literate programming \cite{LiterateProg} used in the late 1980s in Mathematica 1.0 \cite{Mathematica}.

As a programming system, Jupyter has a number of interesting characteristics. The primary outcome of programming is the notebook itself, rather than a separate application to be compiled and run. The code lives in a document format, interleaved with other notations. Code is written in small parts that are executed quickly, offering the user more rapid feedback than in conventional programming. A notebook can be seen as a trace of how the result has been obtained, yet one often problematic feature of notebooks is that some allow the user to run code blocks out-of-order. The code manipulates mutable state that exists in a "kernel" running in the background. Thus, retracing one's steps in a notebook is more subtle than in, say, Common Lisp \cite{CommonLisp}, where the `dribble` function would directly record the user's session to a file.

## OS-like programming systems

These begin from the 1960s when it became possible to interact one-on-one with a computer. First, time-sharing systems enabled interactive shared use of a computer via a teletype; smaller computers such as the PDP-1 and PDP-8 provided similar direct interaction, while 1970s workstations such as the Alto and Lisp Machines added graphical displays and mouse input. These *OS-like* systems stand out as having the totalising scope of *operating systems*, whether or not they are *officially* considered as such.

\paragraph{MacLisp and Interlisp.}
LISP 1.5 \cite{LISP15} arrived before the rise of interactive computers, but the existence of an interpreter and the absence of declarations made it natural to use Lisp interactively, with the first such implementations appearing in the early 1960s. Two branches of the Lisp family \cite{LispEvolve}, MacLisp and the later Interlisp, embraced the interactive "conversational" way of working, first through a teletype and later using the screen and keyboard.

Both MacLisp and Interlisp adopted the idea of *persistent address space*. Both program code and program state were preserved when powering off the system, and could be accessed and modified interactively as well as programmatically using the *same means*. Lisp Machines embraced the idea that the machine runs continually and saves the state to disk when needed. Today, this is widely seen in cloud-based services like Google Docs and online IDEs. Another idea pioneered in MacLisp and Interlisp was the use of *structure editors*. These let programmers work with Lisp data structures not as sequences of characters, but as nested lists. In Interlisp, the programmer would use commands such as `*P` to print the current expression, or `*(2 (X Y))` to replace its second element with the argument `(X Y)`. The PILOT system \cite{Pilot} offered even more sophisticated conversational features. For typographical errors and other slips, it would offer an automatic fix for the user to interactively accept, modifying the program in memory and resuming execution.

\paragraph{Smalltalk.}
Smalltalk appeared in the 1970s with a distinct ambition of providing "dynamic media which can be used by human beings of all ages" \cite{PersonalDynMedia}. The authors saw computers as *meta-media* that could become a range of other media for education, discourse, creative arts, simulation and other applications not yet invented. Smalltalk was designed for single-user workstations with a graphical display, and pioneered this display not just for applications but also for programming itself. In Smalltalk 72, one wrote code in the bottom half of the screen using a structure editor controlled by a mouse, and menus to edit definitions. In Smalltalk-76 and later, this had switched to text editing embedded in a *class browser* for navigating through classes and their methods.

Similarly to Lisp systems, Smalltalk adopts the persistent address space model of programming where all objects remain in memory, but based on _objects_ and _message passing_ rather than _lists_. Any changes made to the system state by programming or execution are preserved when the computer is turned off. Lastly, the fact that much of the Smalltalk environment is implemented in itself makes it possible to extensively modify the system from within.

\paragraph{UNIX.}
We include Lisp and Smalltalk in this group because they function as operating systems in many ways. On specialized machines, like the Xerox Alto and Lisp machines, the user started their machine directly in the Lisp or Smalltalk environment and was able to do everything they needed from *within* the system. Nowadays, however, this experience is associated with UNIX and its descendants on a vast range of commodity machines.

UNIX illustrates the fact that many aspects of programming systems are shaped by their intended target audience. Built for computer hackers \cite{Hackers}, its abstractions and interface are close to the machine. Although historically linked to the C language, UNIX developed a language-agnostic set of abstractions that make it possible to use multiple programming languages in a single system. While everything is an object in Smalltalk, the ontology of the UNIX system consists of files, memory, executable programs, and running processes. Note the explicit "stage" distinction here: UNIX distinguishes between volatile *memory* structures, which are lost when the system is shut down, and non-volatile *disk* structures that are preserved. This distinction between types of memory is considered, by Lisp and Smalltalk, to be an implementation detail to be abstracted over by their persistent address space. Still, this did not prevent the UNIX ontology from supporting a pluralistic ecosystem of different languages and tools.

\paragraph{Early and late Web.}
The Web evolved \cite{DotCom} from a system for sharing and organizing information to a *programming system*. Today, it consists of a wide range of server-side programming tools, JavaScript and languages that compile to it, and notations like HTML and CSS. As a programming system, the "modern 2020s web" is reasonably distinct from the "early 1990s web". In the early web, JavaScript code was distributed in a form that made it easy to copy and re-use existing scripts, which led to enthusiastic adoption by non-experts---recalling the birth of microcomputers like Commodore 64 with BASIC a decade earlier.

In the "modern web", multiple programming languages treat JavaScript as a compilation target, and JavaScript is also used as a language on the server-side. This web is no longer simple enough to encourage copy-and-paste remixing of code from different sites. However, it does come with advanced developer tools that provide functionality resembling early interactive programming systems like Lisp and Smalltalk. The *Document Object Model (DOM)* structure created by a web page is transparent, accessible to the user and modifiable through the built-in browser inspector tools. Third-party code to modify the DOM can be injected via extensions. The DOM almost resembles the tree/graph model of Smalltalk and Lisp images, lacking the key persistence property. This limitation, however, is being addressed by Webstrates\ \cite{Webstrates}.

## Application-focused systems
The previously discussed programming systems were either universal, not focusing on any particular kind of application, or targeted at broad fields, such as Artificial Intelligence and symbolic data manipulation in Lisp's case. In contrast, the following examples focus on more narrow kinds of applications that need to be built. Many support programming based on rich interactions with specialized visual and textual notations.

\paragraph{Spreadsheets.}
The first spreadsheets became available in 1979 in VisiCalc \cite{VisiCalc, VisiCalc2} and helped analysts perform budget calculations. As programming systems, spreadsheets are notable for their programming substrate (a two-dimensional grid) and evaluation model (automatic re-evaluation). The programmability of spreadsheets developed over time, acquiring features that made them into powerful programming systems in a way VisiCalc was not. The final step was the 1993 inclusion of *macros* in Excel, later further extended with *Visual Basic for Applications*.

\paragraph{Graphical "languages".}
Efforts to support programming without relying on textual code can only be called "languages" in a metaphorical sense. In these programming systems, programs are made out of graphical structures as in LabView \cite{LabView} or Programming-By-Example \cite{PBE}.

\paragraph{HyperCard.}
While spreadsheets were designed to solve problems in a specific application area, HyperCard \cite{HyperCard} was designed around a particular application format. Programs are "stacks of cards" containing multimedia components and controls such as buttons. These controls can be programmed with pre-defined operations like "navigate to another card", or via the HyperTalk scripting language for anything more sophisticated.

As a programming system, HyperCard is interesting for a couple of reasons. It effectively combines visual and textual notation. Programs appear the same way during editing as they do during execution. Most notably, HyperCard supports gradual progression from the "user" role to "developer": a user may first use stacks, then go on to edit the visual aspects or choose pre-defined logic until, eventually, they learn to program in HyperTalk.

\includepdf[pages={2}]{table.pdf}

# Technical dimensions catalogue
Here, we present our proposed technical dimensions in great detail. Please note that our intention is to provide a *reference* to be looked up and *used* as needed, not something that should be read from start to finish. Therefore, we recommend skimming through this for anything particularly interesting before proceeding to Section\ \ref{evaluation}. There, we will reference several dimensions in the context of a specific example, at which point it may be helpful to come back for more detail. For a quick overview, we included a concise reference sheet on the previous page, though it may make more sense after reading the relevant sections.

We present the dimensions grouped under *clusters*. These may be regarded as "topics of interest" or "areas of inquiry" when studying a given system, grouping together related dimensions against which to measure it.

Each cluster is named and opens with a boxed *summary*, followed by a longer *discussion*, and closes with a list of any *relations* to other clusters along with any *references* if applicable. Within the main discussion, individual *dimensions* are listed. Sometimes, a particular value along a dimension (or a combination of values along several dimensions) can be recognized as a familiar pattern---perhaps with a name already established in the literature. These are marked as *examples*. Finally, interspersed discussion that is neither a *dimension* nor an *example* is introduced as a *remark*.

\input{prog22-alldims.tex}

# Evaluation
The technical dimensions should be evaluated on the basis of how useful they are for designing and analysing programming systems. To that end, this section demonstrates two uses of the framework. First, we use the dimensions to analyze the recent programming system Dark\ \cite{DarkWeb}, explaining how it relates to past work and how it contributes to the state of the art. Second, we use technical dimensions to identify a new unexplored point in the design space of programming systems and envision a new design that could emerge from the analysis.

## Evaluating the Dark programming system

Dark is a programming system for building "serverless backends", i.e. services that are used by web and mobile applications. It aims to make building such services easier by "removing accidental complexity"^[https://roadmap.darklang.com/goals-of-dark-v2.html] resulting from the large number of systems typically involved in their deployment and operation. This includes infrastructure for orchestration, scaling, logging, monitoring and versioning. Dark provides integrated tooling (Figure\ \ref{fig:dark}) for development and is described as _deployless_, meaning that deploying code to production is instantaneous.

\begin{figure}
  \centering
  \includegraphics[width=1\linewidth]{dark-annotated.png}
  \caption{A simple web service in Dark consisting of two HTTP endpoints (1, 2), a database (3), and a worker (4).\label{fig:dark}}
  \note{FROM https://medium.com/@wilk/dark-lang-an-uncommon-step-towards-the-future-of-programming-921cf7f38baf}
\end{figure}

Dark illustrates the need for the broader perspective of programming systems. Of course, it contains a programming language, which is inspired by OCaml and F#. But Dark's distinguishing feature is that it eliminates the many secondary systems needed for deployment of modern cloud-based services. Those exist outside of a typical programming language, yet form a major part of the complexity of the overall development process.

With technical dimensions, we can go beyond the "sales pitch", look behind the scenes, and better understand the interesting technical aspects of Dark as a programming system. Table\ \ref{tab:dark} summarises the more detailed analysis that follows.

\newcommand{\wrap}[1]{\parbox[t]{10cm}{#1}}
\renewcommand{\arraystretch}{1.3}

\begin{table}
\centering
\caption{Summary of where Dark lies on some of the dimensions.}
\begin{tabular}{ >{\raggedleft\arraybackslash}p{4.6cm} l }
\hline
Dimension (CLUSTER) & Summary \\ 
\hline\hline
INTERACTION	\\
Modes of Interaction & 
\wrap{Single integrated mode comprises development, debugging and operation ("deployless")} \\
Feedback Loops & \wrap{Code editing is triggered either by user or by unsupported HTTP request and changes are deployed automatically, allowing for \emph{immediate feedback}}\\
\hline
ERRORS	\\
Error Response & \wrap{When an unsupported HTTP request is received, programmer can write handler code using data from the request in the process}\\
\hline
CONCEPTUAL STRUCTURE	\\
Conceptual Integrity vs. Openness & \wrap{Abstractions at the domain specific high-level and the functional low-level are both carefully designed for conceptual integrity.}\\
Composability & \wrap{
User applications are composed from high-level primitives; the low-level uses composable functional abstractions (records, pipelines).}\\
Convenience & \wrap{Powerful high-level domain-specific abstractions are provided (HTTP, database, workers); core functional libraries exist for the low-level.} \\
\hline
ADOPTABILITY \\
Learnability & \wrap{High-level concepts will be immediately familiar to the target audience; low-level language has the usual learning curve of basic functional programming}\\
\hline
NOTATION	\\
Notational Structure & \wrap{Graphical notation for high-level concepts is complemented by structure editor for low-level code} \\
Uniformity & \wrap{Common notational structures are used for database and code, enabling the same editing construct for sequential structures (records, pipelines, tables)}\\
\hline
COMPLEXITY	\\
Factoring of Complexity & \wrap{Cloud infrastructure (deployment, orchestration, etc.) is provided by the Dark platform that is invisible to the programmer, but also cannot be modified}\\
Level of Automation & \wrap{Current implementation provides basic infrastructure, but a higher degree of automation in the platform can be provided in the future, e.g. for scalability} \\
\hline
CUSTOMIZABILITY\\	
Staging of Customization & \wrap{System can be modified while running and changes are persisted, but they have to be made in the Dark editor, which is distinct from the running service}
\end{tabular}
\label{tab:dark}
\end{table}

### Dimensional analysis of Dark

\paragraph{Modes of interaction and feedback loops.}
Conventional *modes of interaction* (\ref{dimension-modes-of-interaction}) include running, editing and debugging. For modern web services, running refers to operation in a cloud-based environment that typically comes with further kinds of feedback (logging and monitoring). The key design decision of Dark is to integrate all these different modes of interaction into a single one. This tight integration allows Dark to provide a more immediate *feedback loop* (\ref{dimension-feedback-loops}) where code changes become immediately available not just to the developer, but also to external users. The integrated mode of interaction is reminiscent of the image-based environment in Smalltalk; Dark advances the state of art by using this model in a multi-user, cloud-based context.

\paragraph{Feedback loops and error response.}
The integration of development and operation also makes it possible to use *errors* occurring during operation to drive development. Specifically, when a Dark service receives a request that is not supported, the user can build a handler \cite{DarkErrors} to provide a response---taking advantage of the live data that was sent as part of the request. In terms of our dimensions, this is a kind of _error response_ (\ref{dimension-error-response}) that was pioneered by the PILOT system for Lisp\ \cite{Pilot}. Dark does this not just to respond to errors, but also as the primary development mechanism, which we might call *Error-Driven Development.* This way, Dark users can construct programs with respect to sample input values.

\paragraph{Conceptual structure and learnability.} Dark programs are expressed using high-level concepts that are specific to the domain of server-side web programming: HTTP request handlers, databases, workers and scheduled jobs. These are designed to reduce accidental complexity and aim for high _conceptual integrity_ (\ref{dimension-conceptual-integrity-vs.-openness}). At the level of code, Dark uses a general-purpose functional language that emphasizes certain concepts, especially records and pipelines. The high-level concepts contribute to _learnability_ (\ref{dimension-learnability}) of the system, because they are highly domain-specific and will already be familiar to its intended users.

\paragraph{Notational structure and uniformity.} Dark uses a combination of graphical editor and code. The two aspects of the notation follow the _complementing notations_ (\ref{dimension-notational-structure}) pattern. The windowed interface is used to work with the high-level concepts and code is used for working with low-level concepts. At the high level, code is structured in freely positionable boxes on a 2D surface. Unlike Boxer \cite{Boxer}, these boxes do not nest and the space cannot be used for other content (say, for comments, architectural illustrations or other media). Code at the low level is manipulated using a syntax-aware structure editor, showing inferred types and computed live values for pure functions. It also provides special editing support for records and pipelines, allowing users to add fields and steps respectively.

\paragraph{Factoring of complexity and automation.} One of the advertised goals of Dark is to remove accidental complexity. This is achieved by collapsing the heterogeneous stack of technologies that are typically required for development, cloud deployment, orchestration and operation. Dark hides this via _factoring of complexity_ (\ref{dimension-factoring-of-complexity}). The advanced infrastructure is provided by the Dark platform and is hidden from the user. The infrastructure is programmed explicitly and there is no need for sophisticated automation (\ref{dimension-level-of-automation}). This factoring of functionality that was previously coded manually follows a similar pattern as the development of garbage collection in high-level programming languages.

\paragraph{Customizability.} The Dark platform makes a clear distinction between the platform itself and the user application, so _self-sustainability_ (\ref{dimension-self-sustainability}) is not an objective. The strict division between the platform and user (related to its aforementioned _factoring of complexity_) means that changes to Dark require modifying the platform source code itself, which is available under a license that solely allows using it for the purpose of contributing. Similarly, applications themselves are developed by modifying and adding code, requiring destructive access to it---so _additive authoring_ (\ref{dimension-addressing-and-externalizability}) is not exhibited at either level. Thanks to the integration of execution and development, persistent changes may be made during execution (c.f. _staging of customization_, \ref{dimension-staging-of-customization}) but this is done through the Dark editor, which is separate from the running service.

### Technical innovations of Dark

This analysis reveals a number of interesting aspects of the Dark programming system. The first is the tight integration of different _modes of interaction_ which collapses a heterogeneous stack of technologies, makes Dark _learnable_, and allows quick feedback from deployed services. The second is the use of _error response_ to guide the development of HTTP handlers. Thanks to the technical dimensions framework, each of these can be more precisely described. It is also possible to see how they may be supported in other programming systems. The framework also points to possible alternatives (and perhaps improvements) such as building a more self-sustainable system that has similar characteristics to Dark, but allows greater flexibility in modifying the platform from within itself.

## Exploring the design space

With a little work, technical dimensions can let us see patterns or gaps in the design space by plotting their values on a simple scatterplot. Here, we will look at two dimensions, *notational diversity*^[This is simply the dimension we named as *uniformity of notations* (\ref{dimension-uniformity-of-notations}), but flipped in the opposite direction.] and *self-sustainability*, for the following programming systems: Haskell, Jupyter notebooks, Boxer, HyperCard, the Web, spreadsheets, Lisp, Smalltalk, UNIX, and COLAs.

While our choice to describe dimensions as qualitative concepts was necessary for coming up with them, *some* way of generating numbers is clearly necessary for visualizing their relationships like this. For simplicity,^[There are undoubtedly many ways to turn our descriptions into various measures, with strengths and weaknesses for different purposes, but this is beyond the scope of the present paper. Here, we merely wish to demonstrate that such a thing is possible and show what one can do with the results.] we adopt the following scheme. For each dimension, we distill the main idea into several yes/no questions (Appendix\ \ref{making-dimensions-quantitative}) that capture enough of the distinctions we observe between the systems we wish to plot. Then, for each system, we add up the number of "yes" answers and obtain a plausible score for the dimension.

\begin{figure}
  \centering
  \includegraphics[width=0.6\linewidth]{plot-figure0.pdf}
  \caption{Example programming systems (or system families) measured against \emph{self-sustainability} and \emph{notational diversity}, revealing an absence of systems with a high degree of both. \label{fig:design-space-plot}}
\end{figure}

Figure\ \ref{fig:design-space-plot} shows the results we obtained with our sets of questions. It shows that application-focused systems span a range of notational diversity, but only within fairly low self-sustainability. The "OS-likes" (Section \ref{os-like-programming-systems}) cluster in an "island" at the right, sharing identical notational diversity and near-identical self-sustainability. There is also a conspicuous blank space at the top-right, representing an unexplored combination of high values on both dimensions. With other pairs of dimensions, we might take this as evidence of an oppositional relationship, such that more of one inherently means less of the other (perhaps looking for a single new dimension that describes this better.) In this case, though, there is no obvious conflict between having many notations and being able to change a system from within. Therefore, we interpret the gap as a new opportunity to try out: combine the self-sustainability of COLAs with the notational diversity of Boxer and Web development. In fact, this is more or less the forthcoming dissertation of the primary author.

# Conclusions
There is a renewed interest in developing new programming systems. Such systems go beyond the simple model of code written in a programming language using a more or less sophisticated text editor. They combine textual and visual notations, create programs through rich graphical interactions, and challenge accepted assumptions about program editing, execution and debugging. Despite the growing number of novel programming systems, it remains difficult to evaluate the design of programming systems and see how they improve over work done in the past. To address the issue, we proposed a framework of “technical dimensions” that captures essential characteristics of programming systems in a qualitative but rigorous way.

The framework of technical dimensions puts the vast variety of programming systems, past and present, on a common footing of commensurability. This is crucial to enable the strengths of each to be identified and, if possible, combined by designers of the next generation of programming systems. As more and more systems are assessed in the framework, a picture of the space of possibilities will gradually emerge. Some regions will be conspicuously empty, indicating unrealized possibilities that could be worth trying. In this way, a domain of "normal science" is created for the design of programming systems.

\acks
(To be completed for publication.)
