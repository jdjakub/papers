\newpage

# Making dimensions quantitative

To generate numerical co-ordinates for *self-sustainability* and *notational diversity*, we split both dimensions into a small number of yes/no questions and counted the "yes" answers for each system. We came up with the questions informally, with the goal of achieving three things:

1. To capture the basic ideas or features of the dimension
2. To make prior impressions more precise (i.e. to roughly match where we intuitively felt certain key systems fit, but provide precision and possible surprises for systems we were not as confident about.)
3. To be the fewest in number necessary to attain the above

The results of this process were as follows, along with a brief rationale for each question. Afterwards, we will close with some remarks.

\newcommand{\y}{\ding{52}}
\newcommand{\n}{}

## Self-sustainability

Questions:

1. *Can you add new items to system namespaces without a restart?* The canonical example of this is in JavaScript, where "built-in" classes like `Array` or `Object` can be augmented at will (and destructively modified, but that would be a separate point). Concretely, if a user wishes to make a new `sum` operation available to all Arrays, they are not *prevented* from straightforwardly adding the method to the Array prototype as if it were just an ordinary object (which it is). Having to re-compile or even restart the system would mean that this cannot be meaningfully achieved from within the system. Conversely, being able to do this means that even "built-in" namespaces are modifiable by ordinary programs, which indicates less of a implementation level vs. user level divide and seems important for self-sustainability.
2. *Can programs generate programs and execute them?* This property, related to "code as data" or the presence of an `eval()` function, is a key requirement of self-sustainability. Otherwise, re-programming the system, beyond selecting from a predefined list of behaviors, will require editing an external representation and restarting it. If users can type text inside the system then they will be able to write code---yet this code will be inert unless the system can interpret internal data structures as programs and actually execute them.
3. *Are changes persistent enough to encourage indefinite evolution?* If initial tinkering or later progress can be reset by accidentally closing a window, or preserved only through a convoluted process, then this discourages any long-term improvement of a system from within. For example, when developing a JavaScript application with web browser developer tools, it is possible to run arbitrary JavaScript in the console, yet these changes apply only to the running instance. After tinkering in the console with the advantage of concrete system state, one must still go back to the source code file and make the corresponding changes manually. When the page is refreshed to load the updated code, it starts from a fresh initial state. This means it is not worth using the *running* system for any programming beyond tinkering.
4. *Can you reprogram low-level infrastructure within the running system?* This is a hopefully faithful summary of how the COLAs work aims to go beyond Lisp and Smalltalk in this dimension.
5. *Can the user interface be arbitrarily changed from within the system?* Whether classed as "low-level infrastructure" or not, the visual and interactive aspects of a system are a significant part of it. As such, they need to be as open to re-programming as any other part of it to classify as truly self-sustainable.

\begin{tabular}{ c  c c c  c c c c  c c c c }
Question & \rot{Haskell}      & \rot{Jupyter} & \rot{HyperCard} & \rot{Subtext}
         & \rot{Spreadsheets} & \rot{Boxer}   & \rot{Web}       & \rot{UNIX}
         & \rot{Smalltalk}    & \rot{Lisp}    & \rot{COLAs} \\
\hline
1 & \n & \n & \n & \n & \n & \n & \y & \y & \y & \y & \y \\
2 & \n & \n & \n & \n & \n & \n & \y & \y & \y & \y & \y \\
3 & \n & \n & \y & \n & \y & \y & \n & \y & \y & \y & \y \\
4 & \n & \n & \n & \n & \n & \n & \n & \n & \n & \n & \y \\
5 & \n & \n & \n & \n & \n & \n & \n & \y & \y & \y & \y \\
\hline
Total & 0 & 0 & 1 & 0 & 1 & 1 & 2 & 4 & 4 & 4 & 5 \\
\end{tabular}

## Notational diversity

Questions:

1. *Are there multiple syntaxes for textual notation?* Obviously, having more than one textual notation should count for notational diversity. However, for this dimension we want to take into account notations beyond the strictly textual, so we do not want this to be the only relevant question. Ideally, things should be weighted so that having a wide diversity of notations within some *narrow class* is not mistaken for notational diversity in a more global sense. We want to reflect that UNIX, with its vast array of different languages for different situations, can never be as notationally diverse as a system with many languages *and* many graphical notations, for example.
2. *Does the system make use of GUI elements?* This is a focused class of non-textual notations that many of our example systems exhibit.
3. *Is it possible to view and edit data as tree structures?* Tree structures are extremely common in programming, but they are usually worked with as text in some way. A few of our examples provide a graphical notation for this common data structure, so this is one way they can be differentiated from the rest.
4. *Does the system allow freeform arrangement and sizing of data items?* We still felt Boxer and spreadsheets exhibited something not covered by the previous three questions, which is this. Within their respective constraints of rendering trees as nested boxes and single-level grids, they both provide for notational variation that can be useful to the user's context. These systems *could* have decided to keep boxes neatly placed or cells all the same size, but the fact that they allow these to vary scores an additional point for notational diversity.

\begin{tabular}{ c  c c c  c c c c  c c c c }
Question & \rot{Haskell}      & \rot{Jupyter} & \rot{HyperCard} & \rot{Subtext}
         & \rot{Spreadsheets} & \rot{Boxer}   & \rot{Web}       & \rot{UNIX}
         & \rot{Smalltalk}    & \rot{Lisp}    & \rot{COLAs} \\
\hline
1 & \n & \n & \n & \n & \n & \n & \y & \y & \n & \n & \y \\
2 & \n & \y & \y & \y & \y & \y & \y & \n & \y & \n & \n \\
3 & \n & \n & \n & \y & \n & \y & \y & \n & \n & \y & \n \\
4 & \n & \n & \n & \n & \y & \y & \n & \n & \n & \n & \n \\
\hline
Total & 0 & 1 & 1 & 2 & 2 & 3 & 3 & 1 & 1 & 1 & 1 \\
\end{tabular}

## Remarks and future work
This task of quantifying dimensions forced us to drill down and decide on more crisp definitions of what they should be. We recommend it as a useful exercise even in the absence of a goal like generating a graph.

It is worth clarifying the meaning of what we have done here. It must not be overlooked that this settling down on one particular definition does not replace or obsolete the general qualitative descriptions of the dimensions that we start with. Clearly, there are far too many sources of variation in our process to consider our results here as final, objective, the single correct definition of these dimensions, or anything in this vein. Each of these sources of variation suggests future work for interested parties:

\paragraph{Quantification goals.} We sought numbers to generate a graph that roughly matched our own intuitive placement of several example systems. In other words, we were trying to make those intuitions more precise along with the dimensions themselves. An entirely different approach would be to have no "anchor" at all, and to take whatever answers a given definition produces as ground truth. However, this would demand more detail for answering questions and generating them in the first place.

\paragraph{Question generation.} We generated our questions informally and stopped when it seemed like there were enough to make the important distinctions between example points. There is huge room for variation here, though it seems particularly hard to generate questions in any rigorous manner. Perhaps we could take our *self-sustainability* questions to be drawn from a large set of "actions you can perform while the system is running", which could be parametrized more easily. Similarly, our *notational diversity* questions tried to take into account a few classes of notations---a more sophisticated approach might be to just count the notations in a wide range of classes.

\paragraph{Answering the questions.} We answered our questions by coming to a consensus on what made sense to the three of us. Others may disagree with these answers, and tracing the source of disagreement could yield insights for different questions that both parties would answer identically. Useful information could also be obtained from getting many different people to answer the questions and seeing how much variation there is.

\paragraph{What is ``Lisp'', anyway?} The final major source of variation would be the labels we have assigned to example points. In some cases (Boxer), there really is only one system; in others (spreadsheets) there are several different *products* with different names, yet which are still similar enough to plausibly analyze as the same thing; in still others (Lisp) we're treating a family of related systems as a cohesive point in the design space. It is understandable if some think this elides too many important distinctions. In this case, they could propose splits into different systems or sub-families, or even suggest how these families should be treated as blobs within various sub-spaces.
