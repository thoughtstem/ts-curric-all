#lang scribble/manual


@title{ts-curric-all}

@section{General}

This repo lists as dependencies any curriculum we are currently intersted in.
Installing this repo as a racket package should pull in all current curriculum.
That, in turn, should pull in all langs and libraries that the curricula pertain to.

The intention is that installing @racket[ts-curric-all] will install everything
needed on a device that students are using.

The other intention is that it gives teachers and admins an easy way to access
the curriculum materials they need: i.e. for editing, printing, review, making
new curriculum based on existing curriculum, etc.

These docs will serve as generalized documentation on our curriculum organizational
structure as a
whole.  Docs specific to any particular curriculum should go in those particular repos.

@section{Printing}

Printing of quest cards is a common task.  Here's a reasonably fast way to get printable
sheets for the first quest, with enough duplicates for everyone enrolled in course 1225.
This will propt you to choose a folder to save the images into.  Then you can use
whatever program your OS gives you for layout/printing/etc.

@codeblock|{
  #lang racket
  
  (require ts-racket)
  (require ts-curric-common)
  (set-env! PROD)

  (require ts-curric-k2-del-mar)

  (save-out-materials "test"
    (printable-quest 1 (course 1225)))
}|


@section{Overall organization}

There are 4 levels.

@itemlist[#:style 'ordered
          @item{@(colorize (disk 20) "blue")
           Top - just @racket[ts-curric-all].  This should always be the one thing that needs to be installed to get all the curriculum.
          This level doesn't need to provide anything.  It's info.rkt file is the only important thing.}
          @item{
                @(colorize (disk 20) "purple")
           Location-specific Curriculum.  This levels modules should provide both @racket[quests], which returns a list of lists of images, and @racket[printable-quest] which is a function
          that provides a list of images duplicated according to the number of students in a course.}
          @item{
                @(colorize (disk 20) "red")
           Project-based Curriculum.  This level should provide @racket[quests], a function that returns a list of quests.
           A quest is a list of curriculum materials.  Curriculum materials can be raw images or picts.  Or they
          can be marked as @racket[reusable-material] or @racket[disposable-material] to help manage how many to print for classes.
          Digital materials can be provided here too.  The rule of thumb is to think of developing
          curriculum as a project-based-learning activity for one student.  You can add things that
          are specific to multiple students in the next level up.  See above.}
          @item{
                @(colorize (disk 20) "orange")
           Technology.  This level is for underlying technologies, e.g. @racket[game-engine].}]

For users -- e.g. students and teachers -- they should only have to worry about installing @racket[ts-curric-all].
For curriculum developers, you'll need to make sure you're providing the right things at the right
levels

@(require pict
          racket)

@(define all (list "ts-curric-all"
                    (list "ts-curric-k2-del-mar"
                          (list "ts-curric-k2-scratch")
                          (list "ts-curric-k2-ozobots"))
                    (list "ts-curric-3rd-5th-general"
                          (list "ts-curric-game-engine-rpg"
                                (list "game-engine")
                                (list "game-engine-rpg")))
                    (list "ts-curric-3rd-5th-del-mar"
                          (list "ts-curric-circuit-playground"
                                (list "circuit-playground")))
                    (list "ts-curric-wetware")))

@(define (render l (level 0))
   (define node (frame
                 (inset
                  (scale
                   (text
                    (first l))
                   2)
                  10)))
   
   (vl-append (colorize node (match level
                               [0 "blue"]
                               [1 "purple"]
                               [2 "red"]
                               [3 "orange"]
                               [else "darkorange"]))
              (apply ht-append
                     (map (curryr render (add1 level))
                          (rest l)))))

@(render all)


