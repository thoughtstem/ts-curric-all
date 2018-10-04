#lang scribble/manual


@title{ts-curric-all}

@section{General}

This repo lists as dependencies any curriculum we are currently intersted in.
Installing this repo as a racket package should pull in all current curriculum.
That, in turn, should pull in all langs and libraries that the curricula pertain to.

These docs will serve as generalized documentation on our curriculum organization as a
whoe.  Docs specific to any particular curriculum can go in those particular repos.

@section{Printing}

Printing of quest cards is a common task.  Here's a reasonably fast way to get printable
sheets...

@codeblock|{
  #lang racket

  (require ts-curric-game-engine)
  (require ts-racket)
  (require (only-in pict scale pict->bitmap))

  (define (shrink i)
    (scale i 0.25))

  (cards->pages (map (compose pict->bitmap shrink)
                     (first (quests))))
}|

