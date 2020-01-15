# What does it take to create with domain-appropriate tools? A case study on the "OROM" system.

## Abstract
Insert abstract here.

## Introduction

As someone who can code, I have already passed the first and most important hurdle for making full use of the potential of my computer. However, even in this supposedly empowered state, I am still far away from feeling the relationship between myself and software as between artisan and material, free to shape it into any form with effort proportional to complexity.

One would have thought that software-creation acts like hypothetical super-intelligent AI. That is: even though we start from a primitive base in the 50s (or even today), there would surely be a recursive process of self-improvement, building better software-creation tools with the existing ones, until an "expressivity singularity" where software becomes a workable material as described.

However, this didn't happen. Or at least, it is happening glacially slowly. The brute fact is that whenever you want to create software, you go to a text editor and figure out how to translate your design into that. The text editors, being software, were written with the help of previous text editors, and so on. It's undeniable that text editors have improved, even if you think it peaked with Emacs. We just don't seem able to go beyond them where it matters, such as visual domains ill-fitted to monospaced ASCII.

Amdahl's Law generalises the following idea: even when you spend hours of effort doubling the performance of a component used 1% of the time, your reward is a system overall improved by a mere 0.5%. Now, text coding is certainly ubiquitous, the 99% case in programming, so you might wonder where I'm going with this. Well, a small improvement to text editing, if adopted by everyone, certainly does have a massive *intermediate* effect --- but this only *matters* to the extent that text was helping the programmers in the first place. If my goal is to draw or animate pictures, or create a digital synth from a frequency spectrogram, then giving me the ability to auto-indent my SVG markup is rather underwhelming as a productivity increase, as it doesn't target the core of the enterprise that makes it so hard.

My experience of coding, most of the projects requiring shapes (such as GUIs), leads me to conclude that no matter how much I improve my skill at a particular language, knowledge of libraries or even general coding ability, my predicament stays the same. Our basic method of creating software is optimised for an ever-diminishing proportion of the software we actually want to make; ill-optimised for the graphics, layout, interactivity and and basic physics --- more on this later --- that we usually require.

Whenever I work on these I feel stuck in a box I know I can never escape from: that box is the text editor, a fixed conduit through which all *fundamental* changes to my program must pass. It's not a part of the system I am building, so I can't even make use of features of the thing I'm developing, to make its own development easier.

Surely the trick is to *use* coding to build something *better than it*. And then use that, to build something even better. But there is an enormous breadth and depth of philosophies here, along with many failed historical attempts to do better --- or at least, ones that failed to catch on. But even worse than this is that in my very *language* here I am making the same mistake as the text editor --- speaking in unqualified terms of "better" and "worse" as if there really is a one-size-fits-all solution to software creation!

Of course what we *really* want is the ability for people to create *in the way that they think is best* in their particular context --- to equip them to feasibly create the tools that suit them for the thing they want to make. And second-order tools that suit them for making the first-order tools, etc. It would do no good to replace text-imperialism with anything-else-imperialism, which is one interpretation of calls for alternatives. This dream goes beyond familiar senses of what constitutes a "craft", as far as a strong melding of tool and material.

Certainly in the real world there is only one "material" --- matter --- and humanity as a whole does create "higher-order" tools. A (future) software craft, however, could be expected to give this power to *individuals* instead of the community alone. The one-size-fits-all approach is an understandable consequence of few designers catering to many users --- perhaps due to the necessity to specialise in topics, languages, libraries, and tools. Their complexity is part of the general difficulty of software creation, exacerbated by the one-size-fits-all approach, closing the circle.

What we need is some system that not only lets us create software in a way that is "close to the problem domain" as decided by the user-developer, but also can augment or change itself to adapt to a different "way of creating". Existing systems seem to only have one of these properties without the other. Smalltalk and LISP try to minimise arbitrary commitments of language *semantics* to be adaptable, but their being textual languages is a fairly tough commitment to break out of. And it is not so hard to make a specific, *hard-baked* visual or alternative programming tool --- but it is hard to make it re-programmable *without* having to go back to *its* textual source code.

Again, if someone wants to type out pictures in ASCII, let them --- whether they do it for a challenge, or even if they find that more natural for themselves. But equally, if I want to do it another way, then please give me that affordance. This is how I segue into the software artefact for which I have been attempting to build a natural representation. True, it is a programmer's artefact, but it is still representative of what any normal person has to do, insofar as:

a) Wanting to create a piece of software (for whatever reason)
b) Having in mind a natural way to represent it as it's being built.

## The OROM system

When I first read the paper Open, Reusable Object Models, I was hooked on its idea of a small but expressive starting system that could be self-improved into anything. It describes a late-bound^[Fewer commitments; more things determined by runtime conditions], Smalltalk-style^[OOP with more emphasis on object instances and messaging (methods) as in a distributed system; less emphasis on class hierarchies implementing traditional data structures] objects and messaging environment that the authors call "Id" --- but which I refer to as OROM, for pronunciation and Googleability.

In summary, an object is a key-value mappings of state which can change as a result of messages received by it. A message is sent by first *bind*-ing its name to its implementation, i.e. specific code which is then run in the context of the receiver. "Bind" is accomplished via another message send, this time to the receiver's *vtable*, or "behaviour". This is another object whose state defines a particular way of associating "message name" to "implementation code". This continues up the vtable-chain, and terminates at a base case. The system as a whole is "bootstrapped" into existence by its initialisation code. Each step of this code makes use of any parts of the system set up by the previous steps.

The paper itself consists of mostly prose, several code listings, and full C sources for a sample implementation at the end. It also provides several diagrams. But to understand it, I repeatedly found myself drawing *extra* diagrams. For example, the first acts of the running system boil down to initialising the three or so objects. This consists of allocating memory, interpreting it as a C struct and then filling in fields in a mundane manner. I had great difficulty following the specifics in my head, but when I drew tables in the style of their diagrams I readily saw what what going on. I personally would have preferred these to have been in the paper in the first place, but I am not necessarily representative of those who read it. The "one-size-fits-all" approach is perhaps unavoidable for static media like print.

Other areas like messaging semantics could still be quite confusing. After all, should we expect to be able to predict the entire future evolution of a dynamical system from a static description of its initial state, such as source code? Is this not why debuggers exist? Having "de-compiled" English text and C source code into object diagrams, it is a shame to have to compile it all back to struct member assignments.

Worst of all, the reference system does not even have text I/O when it is run, let alone some sort of GUI. That is, the (un)intended user interface for this project is a C debugger! Faced with the necessity of adding *some* UI, it seemed a waste of effort to end up with a system that must be continually polled for its current state at a terminal prompt. If I naturally think of this system as 2D tables, why can't that be how the running system looks? I do not have to keep polling my eyes for what state my diagrams are in.

But further than that --- why can't the system be *built* out of tables in the first place? Shouldn't this be the main takeaway from the amount of time we spend prototyping, explaining and designing software as diagrams on paper? Why must the "natural representation" be restricted to the finished product?

Thus was my natural representation decided. My first attempt to make it a reality was a partial success: a webpage made of HTML tables, evolved via JavaScript.

### OROM as HTML tables

(OROM/HTML screenshot)

I was grateful for the browser's management of graphical layout, resizable text fields, and keeping the DOM tree synchronised with what you actually see. This last property enabled me to make the decision to *directly* encode much of the system state in the DOM, achieving basic liveness (the thing on the screen is the actual thing) for the keys and values of obj-dicts. For each obj-dict I used a two-column `<table>` within a `<div>`, matching the diagrams, and gave the rows CSS class names matching the keys for easy lookup. Sending messages relied on the JavaScript console, but existing values in text boxes (such as method implementations) could be edited directly. Also thanks to the browser, I could easily make text boxes and `<div>`s resizable as necessary.

However, the choice of ordinary HTML as a substrate proved rather two-edged. The browser requires many features to do its job of rendering complex web pages. And sadly, as its client, I could only make use of those capabilities which the W3C had decided, at the time of authorship, were worth the effort exposing in JavaScript. For anything else, the browser is a black box, and this was very frustrating in the following case.

#### The Radical Concept of Arrows That Stay On The Shapes

A key aspect of the OROM system is that there is an object *graph*. That is, obj-dicts can have entries pointing to other obj-dicts, without restriction to a tree structure. Drawing arrows between things to denote this is a no-brainer, and I wanted it in my substrate for OROM to match the diagrams.

A small problem to surmount first: even though I could hijack the `<table>` for its display properties, what element could I hijack to make arrows between arbitrary points? Luckily, there was SVG at my disposal, which could be persuaded to display over the HTML. However, another key feature of my intended substrate was to be able to rearrange and resize the boxes as desired. So I would also need to detect changes to the position and size of an element.

Bizarrely, there is no such facility provided for HTML elements. This, despite the fact the browser *needs* this functionality hence it must reside *somewhere* inside the black box.

Reluctantly, I stuck with my plan B: each object has a numerical ID and pointers are just fields containing a number, followed using a `deref()` function.

At this point it was starting to look like a mistake not to have done the whole thing in SVG. I would gain full graphical freedom, though also lose some benefits of the browser's managing it on my behalf. I already knew from experience the surprising complexity of a DIY approach to layout, model-view updates, and interactivity. But such an exercise would be an opportunity to carefully observe this tedium, and crystallise some of my intuitions about why it is so consistently frustrating.

### OROM as files and directories

> I would probably put this after the SVG part or perhaps even later once you discuss more
> general principles (like the idea of polyfilling to make a domain substrate into a programmable
> system). Then you can give this as another example.

### OROM as SVG trees

(Screenshot of OROM/SVG showing boxes, code and arrows)

In this version, obj-dicts are encoded as nested SVG `<rect>`s and other elements, reminiscent of diSessa's Boxer. This was a significant departure from the table representation, and even though SVG supports (some) nested HTML via `<foreignObject>`, I actually preferred the possibility of multiple levels of nesting.

OROM/SVG more or less realises my desired substrate for implementing OROM. Needless to say, this version was far more challenging and took much longer to reach a satisfactory state. However, it is precisely this drudgery that brings me to a better understanding of this paper's question: *what has it taken?* I shall discuss this in the form of broad patterns or themes that stand out to me from my development experience, hammered home by these OROM projects.

> Why is OROM/SVG more challenging? I think it would be useful to sketch here, because it
> reveals some useful principles. There is more polyfilling (arrows and resizing is not in the
> SVG substrate itself), but at least it's possible to add those (unlike in HTML)

##  Inevitable Requirements Of Most Software (and the work we must do to meet them)
As programmers, we have a maxim along the lines of: when you find yourself repeating the same thing over and over again, factor it into a "thing" and let the computer do the duplication. Some consider the "design pattern" to be simply what a "language feature" looks like when it's not part of the syntax.

> The jump from very general abstraction idea to design patterns and language features in the
> above is not exactly clear - it would be good to help the reader understand why are you
> talking about this here.

As I developed OROM/SVG I found myself implementing many such patterns. It seems that languages are often at the wrong level of abstraction for the requirements of modern software, necessitating the same boilerplate per project just to get up to basic functionality. This burden either falls on the author, or on the wider community to build and maintain higher-level frameworks, syntax extensions, etc.

By contrast, these languages seem much better adapted to e.g. batch-mode printf()-centric applications. That they fail for the *common case* should be concerning. I will now present what seem to be the inevitable demands of this common case.

> I'm not sure I understand what the above opening is trying to say - I suppose it might
> be because it is quite high-level/general. What is this section about more specifically?
> Is it about what certain kind of software consists of and what we need to build that?
> I would also be a bit careful about things like "most modern software" below. It would be
> good to instead characterize what kind of software are you interested in - end-user graphical
> systems? (a microservice or something like that does not need SVG...)

### As A "Mere Consumer"
I begin by describing expectations of software that even "end-users" hold, consigned as they are to more or less accept what we give them.

#### Retained-Mode Vector Graphics
Most software is designed for the subset of people who have a colour display they can perceive. So right away it is going to require ways to draw coloured shapes. There are usually libraries for this (though note: not part of the language), but some only provide *immediate mode*: commands to instantaneously rasterise pixels to a buffer. This is not enough for modern software, as we often expect animation, or at least to see things change as we interact. Most often we wish to see *small changes* to the *same* shapes, rather than completely different shapes altogether; the reification that this requires to persist between frames, is known as *retained mode.*

On this requirement, SVG fits the bill very well. Although it is not part of the JavaScript language *per se*, it is a standard and widely supported technology of the Web *platform*. We can observe that anyone with a browser *in principle* has access to a powerful vector graphics editor --- just one with no GUI. I will return to this later.

The SVG tree keeps the nice properties of the DOM, such as updating the display when shape parameters are changed. This is well-adapted to "I/O-bound" software like mine, where things change only in response to user input. If I wanted animation, this boils down to a regular "advance simulation" signal, and would require setting up some rendering loop. Alternatively, there is the W3C's chosen ontology of CSS animations, but see section ??.

#### Basic Assumptions About Physical Objects
In any software making use of vector graphics, there is usually some level of "physics" expected by users. This need not be nearly as exhaustive as the word "physics" might imply, as in e.g. physics engines for games; I feel it is important to recognise it for what it is instead of conceiving physics as an inherently complex thing to be found only in specialised simulations.

> People might not find this easy to believe - but I think you can convince them by saying
> that pretty much all mobile phone apps have some sort of "phone touch physics" (with sliding,
> opening menus etc.).

All humans learn a basic set of expectations about the things they see around them. Some of these, such as "things fall down", are not generally appropriate to software UIs --- perhaps because the screen has a role in our lives a more of a table work surface rather than a vertical wall, even if it is vertical in real life.

The level of physics in software tends to not involve force, or mass, or very much at all, merely position and space. One thing that all usable software must do, for example, is not crush many visually complex shapes, such as lines of text, into the same region, since it becomes unreadable. Such concepts of "solid objects do not intersect" or "only things at different layers may overlap" are basic rules inherited from the real world of graphical presentation.

I feel the need to point this out, because by default the computer does not know even the most obvious things about how space works, so we must laboriously algorithmise this intuitive concept. This is not only true in the case of 2-dimensional visual domains, but even in the 1-dimensional case of memory allocation. The physics of 1D memory are something like this:

- This number range 0000-FFFF is like a space, numbers = points
- Every point has at most one owner block
- These blocks are contiguous, finite ranges (i.e. 1D boxes)

Hence the boilerplate involved to realise this in any domain with something resembling space. Far from being a niche topic in games and graphics, spatial partitioning algorithms and data structures have surprising relevance to more ordinary software. Both memory allocation and graphical layout are essential to today's; shame that only one of those has been recognised as such and entered the runtime of modern languages.

##### Translationally Rigid Bodies
When you have both a screen and a pointing device (e.g. touch or mouse), immediately it becomes worth having ways to move things around in at least a minimally realistic way. We can debate the appropriateness of Direct Manipulation (DM) for various situations. But it does make a lot of sense in simple cases, such moving around subdivisions of space (e.g. windows) or elements of a graphical design.

In OROM, the obvious candidate for this is the obj-dicts, plus all nested boxes in OROM/SVG. If I move the top-level rect, then I expect its children to move with it. This is simply the translational physics of rigid bodies: this set of points all move together. Of course, proper rigid bodies might also rotate and have mass, but this is usually undesirable for UI elements.

Translational rigidity can be expressed as the points X and Y always having the same displacement from each other. Or, when one point is moved, the rest also move by the same delta. This is a problem of preserving the relationship over time, which was a significant area of OROM/SVG.

#### Maintaining Relationships Over Time
The model of state-mutation present in most imperative languages is what I call "dumb" state. The language provides an affordance to change any part of the state to a new value, but nothing else.

What more could there be? Well, in *every* software system there are certain rules, or "invariants" of internal consistency, such as "translational rigidity" above. Often, changes to any part of the system are permissible, but only if connected or dependent parts of the state change in response.

The job of keeping track of who depends on whom can fall either on the programmer, or the computer. If the programmer has to do this, they can only go so far managing and simulating in their head. As systems grow more complex, it is only natural to try and make the computer more intelligent to do this work. What I am building up to is that whenever we (or I) consider constraints, or "reactive" programming, or the "Observer" pattern as things you only wheel out on special occasions, we only deceive ourselves into doing the same work less explicitly. It seems that such "live state" should be the expected common case for software development.

If a platform does not provide a means to causally link and unlink bits of live state, then this must form part of the standard boilerplate.

Such was the case in OROM/SVG. I implemented the system in an OOP fashion, and the Observable class is the most widely used. It wraps a current value and a list of subscribers, notifying them when it changes. It can be seen that this supplanted JavaScript's own "dumb" state by the frequency of the change() function throughout the code.

Getting an object to follow the mouse pointer, for example when dragging, is conceptually very simple: an "always equal" relation. In OROM/SVG founded on live-state, this can be expressed in much the same way:

```
subscribe(object.position, pointer.position);
```

(By default, an Observable A responds to a change from Observable B by adopting B's new value.)

#### Nut-Cracking With Sledgehammers
Speaking about vector graphics, physics, layout and constraint maintenance might give the impression of high *conceptual* complexity at the heart of even simple software. This is not quite true, which makes it all the worse that there is yet still immense *incidental* or implementation complexity.

We are conditioned to only think of these in their most general forms. The vector graphics I use in OROM/SVG are just rects, lines, circles and text; a fraction of the full capability of SVG. The "basic physics" I use is dwarfed by fully general 2D or 3D physics engines. The only layout algorithm I had the patience to implement was a simple way to expand a list of boxes to fit in a new child at the bottom; the affordance to place and size boxes *manually* staves off the rest for the time being! Yet search for material on layout algorithms and it can seem like Fully General Linear Inequality Solvers like Cassowary are all there is.

The inevitable requirements I suggest here, do *not* necessitate Fully General anything. In fact, such representations would make it more cumbersome to express what I wanted in OROM. As the old wisdom goes, there's no point expressing a simple regex search as an arbitrary Turing machine; my boxes don't *have* a moment of inertia or a mass and I don't *need* a linear optimisation solver for my space management --- for the time being.

Unfortunately, there doesn't seem to be much interest on the smaller-scale instances of these problems. I suggest the name "geometric physics" for the subset of physics I have mentioned.

> I think the above section talks about 3 things - (i) it describes some of the things that you
> had to implement for OROM/SVG, (ii) it talks about some general patterns that arise there
> (like shapes and physics) and (iii) it mentions some implementation details.
> I found it a bit confusing to have these all mixed together. It reads a bit as if you were
> jumping from one random topic that you encountered when implementing this - but that makes
> the section very specific to your implementation. How can we make it clear that there are
> more general principles here? I think it might be better if you started with some larger
> example (hypothetical is fine!) to illustrate what kind of things you'd like to build - e.g.
> imagine you're building PowerPoint in OROM - what would be some of the things you'd need?
> (for both the end application and the system that you're using to build it). This would then
> nicely motivate the more specific topics (graphics, physics, relationships).

### As A "Developer"
I now turn to some things that were perhaps inevitable, in any case useful, as the *implementor* of OROM/SVG.

#### Practicality vs. High Aesthetics
There is the view that insists on provably-correct code written with strange Unicode symbols, and at the opposite end there is the attitude of "get the job done", high style be damned. Each has its merits, but for my task I quickly saw the latter route to be most suitable.

My favourite example of this has been the "encoding" of obj-dicts as DOM trees containing particular arrangements of children. In OROM/HTML, I would gleefully get/set state by calling code like this:

```
Entity.prototype.addState = function(key) {
  let tr = document.createElement('tr');
  tr.setAttribute('class', key);

  let td = document.createElement('td');
  td.setAttribute('class', 'key');
  td.textContent = key;
  tr.appendChild(td);
  ...
```

and in OROM/SVG the story is similar. It takes advantage of the powerful developer tools included in browsers (e.g. the DOM inspector), and avoids the need to manually synchronise separate Model and View for such encoded state. With a little work, it also allowed the system a large degree of externalisability --- see Section ??. I consider this as practical, expedient, "hijacking" of these substrates because it either goes against their intended use (HTML tables for presentation rather than semantics) or are simply "odd" (using certain arrangements of shapes to "encode" machine-readable semantics).

Contrast this with an approach that had to re-synthesise bits of the DOM whenever something changed. Admittedly this does still happen to a certain extent, but at least it was minimised where obvious.

Another example of practicality was in the issue of positioning and sizing. In Section ?? I mentioned that I was able to sidestep some layout work by offloading it to the user. While building the system I tended to want to draw boxes into existence, and for that my brain's existing aesthetic algorithms can decide where they go. There are areas where the machine must be able to figure this out itself --- I don't want to be constantly bothered by prompts to place boxes as they are allocated by some running code --- but for one-offs it is a very convenient way to do a little less yak-shearing.

> I think you could adapt the above discussion a bit and focus less on what you don't want
> (high modernism) and more on what you want - what is that? I think it's simplifying the problem
> along a different axis - to a certain domain with relatively simple interactions and aesthetics.
> (So rather than trying to make minimal formal calculus that's provably correct, you're trying
> to make minimal working interaction model that's interesting)

#### Positioning and Sizing
The simple desire to move and resize boxes with the mouse motivated a lot of the live-state and geometric physics ideas. This problem could be considered a microcosm of OROM/SVG: what's a natural way I *conceive* of this behaviour, and could I implement it that way?

> The above point (moving motivated live state and physics ideas) would be a lot more obvious
> if you followed the structure with motivating example first followed by an analysis...

It starts with a consideration of translational rigidity. In its most primitive form, this is a relation between two points. Thus it is natural to draw a line or "rod" between them. It seems that this rod transmits changes in one of its endpoints directly to the other endpoint. Since they both feel the same deltas, the displacement vector between them is preserved.

(Diagram of delta transmission)

I like to see what I'm doing, so I wanted these rods to be visible and thus somehow *present in the SVG*. This was not hard; in SVG I draw a `<line>`, though the background machinery of the Rod class does all the work. There is also a Point class that is used wherever manipulable points (SVG circles) are intended.

Resizing (of boxes at least) could be achieved through rods that stay horizontal or vertical. In the language of "small differences" spoken by my live-state infrastructure, this is expressed as a rod "transmitting deltas" in the vertical and horizontal, "absorbing" the other component into itself. Mirroring a DOM rect to these rods is as simple as subscribing its width and height to horizontal and vertical rods' length Observables. This way, boxes can be resized from whatever corner is convenient.

(Box demonstrating all three rod types)

I colour such "half-rigid" rods yellow and fully rigid rods red. The "absorb all endpoint changes" case is coloured green.

> I don't think you explained what 'half-rigid' means yet.

Unfortunately, with these rods came possibly the most frustrating technical challenges of the entire system. Initially I hoped to move boxes as rigid bodies by temporarily making their border rods rigid. However, the four border rods form a cyclic graph, as rods are not directed. This, coupled with the unintended depth-first semantics of Observable notification (a result of JavaScript function calls in a loop), led to duplicate deltas applied twice and other nightmares. This is the tip of an entire research iceberg stretching from Functional Reactive Programming to internet routing and distributed algorithms.

I did manage to surmount this through kludging and compromise. But I do not know whether these problems are merely a consequence of some design decision I could change to escape it, or if they are intrinsic to my (modest) UI goal.

> This section reads more as an implementation detail - even though it makes some interesting
> points about the physics & rods system. However, it might better to have it in a section
> that's more about implementation than about general principles. Or perhaps you could restructure
> Section 3 to have (i) example (ii) general lessons (like physics etc.) and (iii) specific
> points about implementation (e.g. your concrete physics system with rods, what you had to
> 'polyfill')

#### Visible Coordinate Systems
Rigidity in a flat world of sibling shapes is somewhat straightforward. However, rigidity in the SVG world is more involved.

First of all, SVG shapes (e.g. `<rect>`) are strictly leaf nodes, so if I wish to nest boxes within boxes, the visible "box" must be a mere *accessory* to the nestable element, in my case a `<g>` (group). This means that instead of resizing the x, y, width, height attributes of the `<rect>`, only its width and height change along with the transform attribute of its *parent* `<g>`. This was not too bad; just subscribe this attribute, instead of the `<rect>` position, to the top-left Point handle.

All child elements of a node transform with it, so already SVG has baked in a basic facility for translational rigidity. This is only available as a tree hierarchy, but it is still useful. However, it conflicts with my  early decision to have Point objects all share the global co-ordinate system. This way, connecting "this point" to the mouse pointer, etc. is not infuriating to express. Still, it was necessary in the case of certain elements --- especially those which must transcend the tree structure altogether, like arrows between boxes --- to bite this bullet, one way or another.

> Maybe mention that this is caused by the mismatch between the substrate and the programming
> system (substrate is tree, but programming is graphs)?

Again, I return to how we tend to work things out in the freedom of paper. Co-ordinate systems, here merely positionally displaced, have their origins here and there and have vectors between them. The rods thus far let me visually express relations between global Points; now was a question of expressing one global Point as a displacement from another (the `<g>` transform). New rod Observables `p2_from_p1` and `p1_from_p2` do the vector subtraction, which can then be propagated as local co-ordinates to children. It is nicer to express the relation (as well as see it!) this way --- see Figure ?? above.

#### Context-appropriate ontologies
Each API has its own conventions, including a way of naming and structuring expressions --- an ontology. The one-size-fits-all approach is exemplified in such interfaces. For example, in SVG we express a rectangle by `<rect x="10" y="10" width="600" height="400">`. The SVG specification *defines* to the user that a rect *is* a top-left corner, a width, and a height --- and that's it. However, this SVG-approved parametrisation of a rectangle is far from the only one(1)[https://www.shift-society.org/salon/papers/2018/critiques/critique-semprola.pdf], and thus is, unsurprisingly, ill-fitted to some contexts.

For example, I find it natural to resize boxes by dragging any of their four corners, so I wanted this in OROM/SVG. In this context, a "rectangle" is *seen as* four points: top-left, top-right, bottom-left, bottom-right. Obviously this is not a *minimal* description, since given e.g. the top-left and bottom-right, the other two points can be inferred. But one way or another, to be able to drag any of them, all four points must be present at *some* level. This alternative ontology was polyfilled in the form of a "rect controls" class that can be attached manually to any SVG `<rect>`. The SVG `x` and `y` are subscribed to the top-left Point; `width` and `height` are subscribed to Rod lengths.

Another example is to be found in the DOM's event listener model. Conceptually, many "events" are in fact changes to the state of some physical (or conceptual) device. Some of these genuinely are different. But both keyboard keys and mouse buttons, for example, have two states --- pressed, not pressed --- which ought to make them interchangeable to an extent. This is essentially the logic behind "key remapping" in many PC games. But the official ontology of the Web makes it nontrivial to do this.

To start with, the situation is modelled not as a time-varying value changing, but instead as a sort of Cartesian product of event listeners. Rather than, say, a `left_mouse_button` piece of live-state, we get `onmousedown` and `onmouseup`. Thankfully we do not have `onAdown`/`onAup`, `onBdown/onBup`, ... all the way to `onZdown`/`onZup`, just `onkeydown`/`onkeyup`. But this is just one of the many possible ways to slice this 3-dimensional^[Device (mouse, keyboard), sub-device (button, key), state (up, down)] space.

In OROM/SVG I did not quite want to re-map keys, but I did often want to have things follow the mouse when dragged. In order to do this, I reified the mouse pointer and its position, letting me write `subscribe(point.position, pointer.position)`. The Point has an `is-considering-me?` Observable wrapping `onmouseover`/`onmouseout`, and the LMB^[left mouse button] is reified into `left_mouse_button_is_down` to be explicit. The aforementioned subscription is set up whenever `is-considering-me?` and `left_mouse_button_is_down` become true, and torn down otherwise. I tended to think of this in the form "subscribe to pointer *only when* pointer is-considering-me *and* LMB is down", but I could live with this as a future polyfill in JavaScript.

It takes some frustration and experience to get used to the idea that you have a right to polyfill in an alternative representation. Before I came to this conclusion, I used to twist my head around translating my intention into the `x,y,width,height` parameters, and un-translating when reading back the code I had produced. Once you get used to having to adapt your mental imagery to a single way of doing things (i.e. learning to code), it makes sense to simply expect to see more of it --- especially when you know you are new, surrounded by veterans who see no problem, etc. But nowadays I take the position that these are simply *widespread* failings of our way of doing things, instead of *our* failure to adapt to the way software is.

What would it look like to support multiple ontologies? There are the two answers: anticipate the possibilities ahead of time, or support users adding their own.  The latter seems to imply polyfilling. As for the former: in general, anticipating the diversity of ways someone might look at the world is doomed to fail. But in the case of fairly *formalised* concepts such as geometrical shapes or mathematics, I could suggest that simple *under-specification* is the root of the problem in SVG. Instead of explaining in English that "`x` and `y` are the co-ordinates of the top left-hand corner...", it might be better to make these relations machine-readable or *embodied* in the API. For the rect this might look like:

A `rect` is...
- a `polygon` (defined elsewhere)
- defined by 4 *degrees of freedom* `x y width height` (internal representation)
- where there are 4 *vertices*, all `point`s
    + `[x,y]` "top-left"
    + `[x+width,y]` "top-right"
    + `[x,y+height]` "bot-left"
    + `[x+width,y+height]` "bot-right"

The hope is that if we then specify enough information --- say, the bot-left and top-right --- then the runtime has enough information to derive its internal 4 degrees of freedom. In a crude sense I have successfully anticipated the most obvious ontologies of a rectangle here. However, I missed out the "centre plus half-width and half-height" formulation, among many others.

Is this a futile effort even for precise mathematical knowledge structures, or could enough formalisation of Euclidean geometry in the Web platform put an end to this sort of polyfilling?^[This relates to my belief that type systems and other auto-reasoning tools are trapped in a doomed quest for "closed-form" AI, representable as a LaTeX formula.]

#### Extensional Functions
Time and time again we come across the same pattern of partitioning system state: trees or graphs of dictonaries, a.k.a. Maps, a.k.a. associative arrays. I am talking about filesystem paths `/path/to/some/file`, Python / Java modules `com.example.pkg.subpkg`, JavaScript objects `window.my_obj.component`. The common case is an association of a textual (string) name, to an arbitrary value. I find it useful to see this as a mathematical "function" defined *extensionally* by listing its input/output mappings -- this opposed to an *intensional* definition such as `x \mapsto 2x+3`, or a computer program.

Extensional functions are perhaps the most basic form of Knowledge Representation, and match natural language very well. "The bicycle's wheels' spokes are silver" straightforwardly translates to a function equation `root (bicycle) (wheels) (spokes) (colour) = root (silver)`. That is, whatever object is the output of `silver` in the top-level `root` function, the output of `colour` (in the function on the left) points to the same object. The ability to partition a system in this way enables what (2)[https://github.com/amb26/papers/blob/master/ppig-2016a/ppig2016a.pdf] calls a "natural co-ordinate system" for a piece of software, crucial for understanding and adaptability by others (so long as it is externalised).

It seems that this way of expressing the "parts" of a system is an inevitable requirement of any programming substrate. Some languages, such as C, do have static, *compile-time* associative arrays (`struct`s). In my experience this is not enough, and it's necessary to bring in a library or clutter the code with a home-grown approximation. Some parts of the OROM authors' C code were confusing until I realised they were just the guts of a basic associative-array implementation; when I switched to JavaScript, these lines vanished. Perhaps another strength of JavaScript is its low concrete syntax cost for *instances* or *literals* of associative arrays. Writing or reading

```javascript
a = {
  b1: { c1: z, c2: y },
  b2: { c3: x, c4: w }
};
```

is more WYSIWYG^[What You See Is What You Get] than the imperative-style

```javascript
a = new Map();
a.set('b1', new Map());
a.get('b1').set('c1', z);
a.get('b1').set('c2', y);
a.set('b2', new Map());
a.get('b2').set('c3', x);
a.get('b2').set('c4', w);
```

The latter is unfortunately still required in JavaScript for extensional functions with *non-string* inputs.

The decision to switch from the flat tabular representation in OROM/HTML to the nestable, Boxer-like structure in OROM/SVG permitted extensional (tree) functions in its substrate. True, I could always encode these in flat tables by having them reference each other. But this is like the second listing above: hard to follow. In the case of distinguishing between ordinary state mappings and the "method dictionary" of vtables, I actually stored method mappings with a "-" character to avoid doing this.

(Screenshot showing this)

In OROM/SVG, I can directly express the model I was thinking of: the vtable box has a `methods` box and that's where the method boxes go.

(Screenshot showing this)

#### Externalisability
This refers to exposing structured program state to the user. This data can then be saved and used to restore the system at a later date, but it can also be tweaked with corresponding changes reflected in the system.

Externalisability, or its weaker cousin *persistence*, was absolutely necessary to continue OROM/SVG development past a certain point.

Reference Antranig's stuff on this. How I dealt with event listeners etc

Necessity to development: frustrating to find bug, tear down, refresh, lose work, build it up again!

Inspect Element: copy to save works, arbitrary edits *should* work (cuz it's on demand)

Work required to parse SVG trees into objects "on demand"

Started heavyweight, ended lightweight (generate rods on demand, let SVG move children)

#### Polyfilling
Very advantageous to permit this e.g. JavaScript

Stupid lack of XYZ in JS or SVG due to come out in the next spec, etc

Syntax sugar (SVG tree ops, vector ops)

objects in JS user data

## The OROM system as a part of the solution
Meta-circularity as empowerment, not just "cool"

The allure

Other themes e.g. homoiconicity of code and data

Problems: cognitive vs. "official" complexity

Maxwell's eqns metaphor: omits the years of study compressed into the math symbols!

And yet, the allure of the Maxwell's Eqns of Software?

"Taming" SVG - ability to use SVG in a vaguely sane way (vector graphics editor)

Similarly for e.g. 3D OpenGL, Web Audio, sockets ...

### Tensions between philosophies
#### Stable or emergent? (Antranig against OOP dispatch)
#### Turing-complete? (Antranig against this)
#### Messaging vs Read-Write?

# Misc
A note about DIY and libraries

My other problem was one of cost-benefit. My aim was to ...
