title: Wanting to push static to the limit
date: 2026-08-26 00:02
summary: What can we get away with in terms of "static website"?
tags: 
---

## The idea

### Hoot and Goblins
So I'm a big fan of static websites. They're fast, they don't require code execution every page load, and you can pretty much keep everything in git. Neat, right? In fact, this site is built in [Haunt](https://dthompson.us/projects/haunt.html), a static website generator (implemented in guile scheme, of course).

But also I like the idea of strange ways to make a site dynamic. JavaScript is probably the gold standard when it comes to doing so. And yet, I keep looking longingly at wasm and [Spritely Hoot](https://spritely.institute/hoot/), which is a scheme that compiles to wasm and has an awesome capability based security model. AND it also supports Spritely's other project (and my favorite thing ever) [Spritely Goblins](https://spritely.institute/goblins/). Goblins is an interesting library which combines the actor model, object capabilities, and a protocol for connecting to other actors over the net.

Which means that I could in theory create a wasm binary using hoot which incorporates goblins in order to do some weird and wonderful experiments. The structure for the code of this website was [already set up to make that easy](https://trop.in/blog/a-sane-directory-structure-for-software-projects).

The other interesting thing is that hoot wasm binaries are apparently already compatible with the node.js wasm engines. Whiiiich makes sense, but still has some interesting applications as well.

More simpily, it could also just be a way to let people leave comments.

### ActivityPub?

Since ActivityPub requires well known endpoints, is that something we can use? I know that the IndieWeb movement likes to embed endpoints within the HTML itself, perhaps ActivityPub could work the same way?

## Architecture Ideas and Issues

Sadly, there would need to be at least one persistently running server to essentially act as a bridge to interact with whatever outside systems. It'd basically serve as just a relay to facilitate peer to peer connections, or connections to other servers/services. Once the connection is established, it should be able to drop references for p2p netlayers (such as tor). Though with a websocket bridge it'd probably need other considerations.

The fact that haunt is scheme means that it could in theory call a goblins vat during build time, which returns the sxml required to build the components for that particular service, meaning that we could have dynamic templates on the fly.
