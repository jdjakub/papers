# Technical dimensions - Changelog

## 3. History of Programming Systems
* The history section has been rewritten and improved to include workstations alongside with time-sharing. The discussion about Lisp has been edited to talk about Lisp more generally, with references to MacLisp and Interlisp.
* We also made some initial improvements in the section on Smalltalk, but we expect to make further revision after sharing our draft with experts on the history of the other systems discussed in the paper (Smalltalk, UNIX, HyperCard, spreadsheets, and the Web)
* We clarified a bit the discussion about notebooks and trace of steps - there is an interesting issue with notebooks, which is that code blocks can be run out of order - so the notebook is not as straightforward trace of the execution (leading to some interesting issues).
* We made some smaller edits in other sections in the history section (e.g. around the DOM)

## 4. Technical dimensions
* We adopted a more structured approach in the presentation. Our initial idea was to define a set of "technical dimensions" that can be used for evaluating (and talking about) programming systems. To make this more clear, we now treat sub-sections such as "Feedback loops" as clusters of individual "technical dimensions". The clusters contain subsections that can be (i) "technical dimensions" - which describe some characteristic of the system, (ii) "instances" - which are known or typical configurations of technical dimensions and (iii) "remarks" - which provide some additional clarification.
* **QUESTION:** We considered how to relate this to patterns - if we see pattern as a "re-usable form of a solution to a design problem", then perhaps what we refer to as "instances" currently should actually be called "design patterns". Would this be appropriate, or confusing?

### 4.1 Interaction Structure (formerly Feedback Loops)
* We made Feedback Loops into a Dimension
* Categorised e.g. Immediate Feedback as Instances
* Changed "basic form" to "statically typed PL" clarifications

### 4.2 Notational Structure
* We did various small tweaks to address the specific points, including expanding the explanation of `x==1` and other highlighted points.
* A bigger change is in "Complementing notations" where we expanded the discussion on "programming language enclosed in (at least one) programming system" and also added versioning and package management in Pharo as an example.

### 4.3 Conceptual Structure (formerly Orderliness)
* Renamed and reshuffled the cluster, and reworded some parts.

## Throughout
* We fixed typos and substituted alternatives for "often" and "allow"
* We fixed stylistic issues, e.g. em/en dashes, Oxford commas, and adjacent headings
* Less confusing formatting of "Relation" sections - will need further work
* Consistent use of em and en dashes
* Added a section to Tech Dims opening explaining "cluster", "dimension", "instance" & "remark" structure.
* Made citations (Author, Year) to match end bibliography, so they work when reading aloud
* Added an Acknowledgements section at the end
