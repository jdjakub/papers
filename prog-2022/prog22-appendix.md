# Making dimensions quantitative

To generate numerical co-ordinates for *self-sustainability* and *notational diversity*, we split both dimensions into a small number of yes/no questions and counted the "yes" answers for each system. We came up with the questions informally, with the goal of achieving three things:

1. To capture the basic ideas or features of the dimension
2. To make prior impressions more precise (i.e. to roughly match where we intuitively felt certain key systems fit, but provide precision and possible surprises for systems we were not as confident about.)
3. To be the fewest in number necessary to attain the above

The results of this process were as follows.

\newcommand{\y}{\ding{52}}
\newcommand{\n}{}

## Self-sustainability

Questions:

1. Can you add new items to system namespaces without a restart?
2. Can programs generate programs and execute them?
3. Are changes persistent enough to encourage indefinite evolution?
4. Can you reprogram low-level infrastructure within the running system?
5. Can the user interface be arbitrarily changed from within the system?

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

1. Are there multiple syntaxes for textual notation?
2. Does the system make use of GUI elements?
3. Is it possible to view and edit data as tree structures?
4. Does the system allow freeform arrangement and sizing of data items?

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
