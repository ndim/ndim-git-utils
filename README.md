# ndim's git utilities

ndim's git utilities is a collection of scripts and docs around git.


## The utilities in detail

  * `git-amb` (status: stable)

    Makes building, installing, and testing multiple git branches of
    some source tree built with automake easy, clean and flexible.
    The name stands for "git **a**uto**m**ake **b**uild". For details, see
    `git-amb(1)` man page.

  * `git-buildmsg` (status: testing)

    Generate a `.h` file containing information about the current git
    working tree. Useful for programs' version messages in logs etc.
    Generating the version message from git describe output appears
    to be much cleaner, though, especially when done at autoconf time.

  * `git-rebase-subtree` (status: stale)

    Rebase not only a single branch, but a whole "subtree of branches".
    Useful for maintaining your own subtree of branches close to some
    upstream's branch, but is in dire need of proper error handling.
    NOT obsoleted by automatic `branch..rebase` setup in git 1.5.6.


## Resources

  * Home page: None.

  * Git repository:

        $ git clone https://github.com/ndim/ndim-git-utils.git


## License

Partly MIT, partly GPL. Shared parts dual-licensed.
