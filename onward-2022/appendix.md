# The Cutting Room Floor
Force \ref{escape-plaf} directed us to do without several advanced substrate features we were tempted to include. For example, it would be useful to attach state change listeners to keep parts of the state in sync with others. We could go even further and include constraint-based programming features.

On another note, our substrate is based on "maps" without a predefined ordering of the entries. However, there is always some order in which they will be displayed:

```
{ red: 100, green: 255, blue: 0 }
```

Thus it might be nice to be able to set this on a per-map basis. A convenient way to expose this in-system would be via another map, or "order map" which would be a list map of key names:

```
{ 1: 'red', 2: 'green', 3: 'blue' }
```

A practical use of this is for enabling iteration through a map's keys or entries. If we wish to be rigorous, the order map itself would have an order map, which would (by default) be the same for all order maps:

```
{ 1: 1, 2: 2, 3: 3 }
```

Of course, with such a conceptually infinite sequence of order maps, care must be taken to implement it in a finite, on-demand way. Perhaps some clever circular reference would work, as COLA does for its vtable relation\ \cite{OROM}. This raises the question of how to obtain an order map in-system. If we make it an ordinary key on all maps, we must be careful to render it only on-demand and to exclude it from ordinary iteration through keys. Plus, would we want the visual clutter of always displaying it? It might be better to make it accessible through a special instruction `order-map`.

We then face a further *synchronisation* problem, where we must alter the display order whenever the order map is changed, and insert or remove entries from the order map to match its source.

Other thoughts along these lines included *parent* maps for delegating lookups (similar to JavaScript's prototype system), *inverse* maps, and *meta* maps for possibly collecting all of these (drawing inspiration from Lua's metatables). Of these, we will only discuss inverse maps in more detail.

Inverse maps come from the view of a map as a mathematical function from key names to values. Often in advanced data structures (such as those for graphical diagrams) it is essential to know "who points to me" via some key. For example, the question "Is this node the `source` of anyone else?" is a natural one, but normally it is impossible to answer based on ordinary dictionary keys. In ordinary programming languages, this information needs to be kept track of separately; say, in a manually synchronised list called `sources` that lives on the node. It is frustrating that the "forward" question is trivially answered by just following a map entry, yet the "backward" question has to be hacked around like this.^[Norvig's "Relation" pattern\ \cite{dynpat} for dynamic languages is relevant to this sort of concern.]

An inverse map would somehow collect all references to a map from other ones. A user-level "map" would be implemented by two dictionary structures, the forward and backward halves, which are automatically kept in sync by the substrate implementation. The previously mentioned issues of access, mutation and others also rear their ugly heads here, so we can be forgiven for discarding the idea for the sake of making progress. Still, a properly worked out implementation would provide a valuable service for a high-level substrate.

# Graphs vs. Trees
A classic debate in the world of explicit structure is whether to use restricted *tree* structures or to allow arbitrary *graphs*. A tree has the advantage that every node has a single parent, which is a useful canonical answer to the question "what context am I in?". On the other hand, many practical problems do not fit inside a tree structure; either because they are DAGs, and a node can have multiple parents, or because they involve cyclic relations. Because we did not know what sort of things we would require in BootstrapLab, we erred on the side of freedom and supported full graph relations. This bit back at us in two ways, both involving the graphics domain.

Firstly, cyclic structures need to be rendered with care; a \naive\ depth-first search will never terminate. For a long time, we did not have any cyclic structures and got away with a depth-first approach to DOM generation in the temporary state view (Section\ \ref{temporary-infrastructure-in-bootstraplab}).

Secondly, while this was the case, the graphics sub-region of state needed to be a tree. Spatial containment and other visual nesting (e.g. for the tree editor) is a tree structure, as is the underlying parent-child relationship of THREE.js objects. Many aspects of rendering the tree editor required the ability to ask "what context am I in?" but this is unanswered by default in a graph substrate. Providing a "parent" key for each node would not do---this would be a cyclic reference. Instead, we kludged it: the first map to reference another map becomes its "parent", and this lasts until the reference is deleted. This parent property is available from JavaScript; as we port the tree editor to Masp, we will have to decide how to expose it in-system (probably through a special instruction).

Of course, we eventually did require cyclic structures---for the tree editor! Each graphics node in the editor has a `source` key providing a way for edits to propagate back to the source state node. All edit nodes live in the graphics tree, including the one corresponding to the root node of the state. In this case, the `source` points all the way upwards to this root node. This cycle broke our state view and there was much gnashing of teeth to hack around this. Eventually, we bit the bullet and improved the state view JavaScript to cope with cycles---having previously hoped we were done with this temporary infrastructure.

Let this be a warning that Alignment (Force\ \ref{alignment}) will come for you in the end. If your substrate allows cycles, your state view must tolerate them!

# The Minimal Random-Access Instruction Set (And Its Perils)
Recall Heuristic\ \ref{simple-asm} which instructed us to pursue an easy-to-implement instruction set. We pursued this goal to the extreme out of curiosity for what was possible. Of course, it turned out that the corresponding explosion in the number of instructions necessary to do a simple thing outweighed any implementation advantage...

We did this by breaking down higher-level instructions to their component operations until we felt we could go no further. This led to a sort of "microcode" level where each instruction's implementation corresponded to some single-line JavaScript operation. In other words, the platform itself blocked any further decomposition.

Our method for achieving this can be illustrated if we start with a hypothetical complex instruction, e.g. `copy a.b.c to x.y.z`. The actual *work* involved in executing this in JavaScript would involve three steps:

1. Traverse the path `a`, `b`, `c` and save the value in a local variable
2. Traverse the path `x`, `y` and save the (map) value too
3. Set the key `z` in the map to the saved value.

If we score *strictly by JavaScript implementation size* (a mistake, in hindsight), we could improve by simply splitting up these steps into instructions of their own. Any other "complex" instructions that used some of the same steps (e.g. path traversal) will also be covered by these, and the total JavaScript will be reduced.

For the first path traversal, we start at the root map (or more generally, any given starting map) and follow each of the keys in turn. We have only one step here (follow key) repeated three times. That's another micro-instruction!

At this stage, we have this truly simple instruction: `follow-key k`. It clearly relies on some implicit state register for the current map, and takes a single parameter. We pushed the limits of sanity by going further, factoring the parameter *out* into another state register, so the resulting instruction is just `follow-key` (we called it `index`). In other words, we applied the following heuristic:

\begin{heuristic}[Registers for parameters]
Factor out instruction ``parameters'' into special state registers where possible.
\label{reg-for-param}
\end{heuristic}

The motivation for this is a vague intuition about sharing parameter values. Under a parameter scheme, copying the same thing to multiple destinations will duplicate the "source" parameter many times, even though the only thing that's changing is the destination. The converse is true for operations with the same destination---maybe not overwriting copies, but arithmetic or other accumulating operations. By breaking these parameters into state, we set a source or destination once only. This has a subjective aesthetic appeal from the point of view of minimality, and an even more dubious efficiency value. We emphasise that it was an experiment and advise against it for the purposes of implementing a system quickly.

As mentioned at the end of Section\ \ref{designing-the-instruction-set}, we end up with only four registers (`next_instruction`, `focus`, `map`, `source`) and five^[Or six, if we analyse the overloaded `store` instruction as `store-reg` and `store-map`.] core instructions (`load`, `store`, `deref`, `index`, `js`). These have a structural representation in-system, but also a convenient textual syntax for brevity in textual media (like this essay).

Combinations of these express the expected copying and jumping operations. For example, `load source-reg`, `deref`, `store dest-reg` copies the value in top-level `source-reg` to `dest-reg`. The first instruction loads the literal string `source-reg` into the `focus`; the second replaces `focus` with the contents of its named register; the third copies the `focus` to the named destination.^[It turns out that, if you extract the destination parameter from `store`, you meet an infinite regress and will be unable to store to any top-level register. For example, if we extract the parameter to `dest_reg`, we have to somehow give it the value it previously took in the instruction---but this is precisely a `store` operation and we're already in the middle of one.]

The `copy a.b.c to x.y.z` from earlier would decompose as follows:

1. `load a`, `deref`, `store map`, `load b`, `index`, `load c`, `index`, `load map`, `deref`, `store source`
2. `load x`, `deref`, `store map`, `load y`, `index`
3. `load z`, `store`

(Recall that `index` replaces `map` with the result of following its key named by `focus`, and `store` without any arguments copies from `source` to the `focus` key entry within `map`.)

A jump is accomplished by overwriting the address in `next_instruction` (i.e. a map containing a `map` field and a `key` field). The map or the key can be overwritten in a single instruction, but if an entirely new address is required, this needs to be built up separately and overwritten atomically. In other words, we cannot overwrite the `map` and then overwrite the `key`. The ugly reality is, after overwriting the `map`, it will have jumped to a different instruction somewhere else!

A conditional jump is sneaked in by indexing a map to obtain the new list of instructions (which is the map that will overwrite the `map` under `next_instruction`). For example, in the following register snapshot:

```
...
weather: 'stormy'
map: {
    sunny: { ... sunny code sequence ... }
    rainy: { ... rainy code sequence ... }
    _:     { ... other code sequence ... }
}
```

One of the three code paths will be selected according to whatever happens to be in the `weather` register via the following instructions: `load weather`, `deref`, `store focus`, `index`. The `map` register will hold the result, in this case the "other" code sequence (recall that the special key `_` is used as an "else" clause for lookups). What remains is then to copy this within `next_instruction`.

It is easy to see how this applies for strict equality matching, but what about comparisons? We simply turn the condition into one of a fixed set of constants. For $3 < 7$ we would subtract to get $-4$ and then apply the mathematical `sign` function to obtain $-1$ (the other possibilities being 0 or 1). we would then index a map containing keys `-1`, `0` and `1`.

Finally, operations like subtraction and `sign` were included as special instructions or achieved via the `js` escape hatch into JavaScript. We continued to experiment with other arithmetic instructions, including vector arithmetic (useful for graphics), but never got round to implementing an operand stack.

\joel{ NOPE
# Appendix: Tree Editor
One interesting issue is the "display update" problem. For the JS tree view, we simply intercept all state updates and use `querySelector` to lookup the DOM node with the map's internal ID. Internal IDs are not currently accessible in-system, though we could provide instructions for this purpose. How, then, can we ensure that the relevant "display state" for a map entry is updated when it changes?

Even if we had an answer for this, there is a bigger problem. The DOM state is not part of the "state" of our substrate. When our state changes, this triggers a DOM state change. But the system's graphics are based on a special region of ordinary system state. Therefore, a state change will trigger another state change (to the graphics state.) What if the "graphics state" is being visualised in the tree editor? It will need to change too! And so on.

State change should cause state change (finite extent) in scene tree, if that state is visualised there.

In other words, there exists some address `->` graphics node mapping (e.g. in map metadata) inside the substrate.

Analogous to Virtual Memory Management GDT, LDT descriptor tables.

Yet, this makes too much complexity e.g. the graphics tree format part of the substrate!!

Alternatively: consider the humble hex editor. It doesn't change memory, trigger a hardware interrupt, and then sync the display data to match. Causality goes not:

```
Edit --> Mem --> OnMemChange --> Display
```

But:

```
Edit ---> Mem
     \--> Display
```

Aha! But how do machine-level debugger GUIs work? When instructions, the OS, or whatever ... change memory, how does it notice and display the changes??

It must either re-poll everything after a run/step, or get a changelog from OS...?

Changelog could be a special part of state expected to change constantly, so we just poll it on demand. We assume it's stale by default when looking at its visual representation.
}
