<p style='text-align: right;'><i><sub>April 2nd, 2020</sub></i></p>

# I Hate CVS.

***"No mention of openbsd on the internet is complete without a long thread about source control migration."*** ~ Ted Unangst

OpenBSD has a big problem. A version control problem.

For more than 20 years, OpenBSD has used [CVS](https://openbsd.org/anoncvs.html) as its version control system.

I absolutely loathe CVS. Despite my love for OpenBSD and all the
work their developers do, it dissuades me from contributing to their source.

In this post I'll lay out everything that comes to mind as to
how I despise this archaic versioning system and hopefully persuade
you to choose something else for your next project.

Most of this will be in comparison to [git](http://git-scm.com) as it's what I, 
*(and probably you as well)*, am most familiar with.

## Why CVS Sucks.

#### 1. You check out files instead of commits.

With git, we have the notion of checking out *"a point in history"* of the tree.

You get the *entire* source. This includes all branches and tags.

With CVS, you check out files.

This has benefits, such as not needing check out the entire tree, (and every branch),
of the source -- but the chaos of keeping track of files that ensues
is not worth the hassle in my opinion.

#### 2. There is no concept of a local tree.

With a [distributed](http://en.wikipedia.org/wiki/Distributed_revision_control) VCS like git, you do not need a network
connection to see other files in the tree, switch branches, or
commit changes.

However, CVS is centralized. Commits cannot be made without a network
connection. This has implications such has being unable to automatically
set date stamps for when an action was "committed".

#### 3. CVS commits are NOT [atomic](https://en.wikipedia.org/wiki/Atomic_commit).

This means interruptions during operations can leave the tree in
an inconsistant state, which can be difficult to debug.

If you make a large commit in CVS with many changes, and some go
through and some do not, you now have to hurry up and fix your mess
before someone else sees the disaster you've created on the public tree.

With git, data is only changed when operations succeed.

#### 4. CVS branches suck.

CVS is a "dumb" versioning system, and by that I mean it is ignorant
of merges -- where they came from and when they were made.  You
have to manually tag merges and branch points, and manually supply
the correct info for `cvs update -j`. This not only makes CVS more 
cumbersome to use but introduces room for error where there should
not be.

#### 5. No builtin support for file renaming.

When you rename a file, as far as CVS is concerned, the original
was deleted and one was made anew. All of its history will be lost.

There are some workarounds for this, but they are [very ugly](https://www.eyrie.org/~eagle/notes/cvs/renaming-files.html).

#### 6. No support for changing or rewording commits.

A common task with git is to change committed files, message wording,
or drop the commit altogether.

This is done with `git rebase`. Very handy, especially so when on
local feature branches, *(which CVS doesn't have)*.

With CVS, a commit is a commit. That's it. It's set in stone. If
you want to amend it, you have to create another commit on top with
an "oopsy" message and hope your peers won't flame you for it. Some
say this is a feature, rather than a bug, as to prevent mass-squashing
of bogus commits. That's wisdom in itself, but boy is it handy...

#### 7. It's ancient.

CVS is no longer actively developed, with its last release [*12 years ago*](https://savannah.nongnu.org/projects/cvs).

Yes, twelve... **YEARS**. And it's mailing list is a [ghost town](https://lists.nongnu.org/archive/html/cvs-announce).

- - -

# Where do we go from here?

OpenBSD cannot use git due to it being under the [GPL](https://git-scm.com/about/free-and-open-source).

Apache's [Subversion](https://subversion.apache.org) is under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0), but `svn`, while it
strives to be an improvement upon CVS, inevitably falls to all of
CVS shortcomings due to its centralized nature and yet manages to
introduce [problems of its own](https://kbyanc.blogspot.com/2010/04/subversion-sucks.html).

## The Alternative

A promising alternative being developed, *with a terrible pop-culture-reference name*, is [Game Of Trees](https://gameoftrees.org/).

`got` is intended to be a replacement for CVS targeted [specifically](http://gameoftrees.org/faq.html#openbsd) at OpenBSD developers.

* BSD licensed
* [Written from scratch](http://gameoftrees.org/faq.html#code)
* Uses the same data format as git
* Meant to have a simpler CLI interface than git

Currently it's in a useable state, but doesn't yet support [remote pushing](http://gameoftrees.org/got.1.html#SEE_ALSO).

Time will tell whether OpenBSD decides to adopt it.

- - -

## Quotes

> It's really not very easy to explain why CVS sucks. After all, sometimes 
> people who have used it for decades have a hard time understanding the 
> suckiness.

~ Linus Torvalds

> I credit CVS in a very very negative way. Because in many ways,
> when I designed git, it's "what would Jesus do", except that it's
> "what would CVS never ever do"-kind of approach to source control
> management. I've never actually used CVS for the kernel. For the
> first 10 years of kernel maintenance, we literally used tarballs
> and patches, which is a much superior source control management
> system than CVS is, but I did end up using CVS for 7 years at a
> commercial company, and I hate it with a passion.

~ Linus Torvalds

> If I try to commit in Subversion, but one of the files has a conflict,
> or is out-of-date, none of the files commits. In CVS, you’ve got a
> half-commited set of files that you have to fix RIGHT NOW.

~ Andy Lester

> I've contributed a bit to the OpenBSD kernel and core user space,
> but CVS is so much trouble that's it kept me away from fixing
> more things because of all the extra CVS-created work.
> If they switch to something from this millennium (which they now
> seem to be doing!) then I could help do more.

~ a poor CVS PTSD sufferer on [hackernews](https://news.ycombinator.com/item?id=20679534)

- - -

## Further Reading

* [Torvalds on SVN vs CVS](http://marc.info/?l=git&m=113072612805233&w=2)
* [Bye bye CVS, I've been Subverted](http://www.oreillynet.com/onlamp/blog/2004/09/byebye_cvs_ive_been_subverted.html)
* [Subversion sucks, get over it](http://andreasjacobsen.com/2008/10/26/subversion-sucks-get-over-it/)
* [Subversion - Considered Harmful](http://harmful.cat-v.org/software/svn/)
* [OpenBSD developer jcs stating he and others use git for local changes](https://old.reddit.com/r/openbsd/comments/dtac4o/fastest_way_to_get_into_openbsd_driver_development/f6wd1r1/)
