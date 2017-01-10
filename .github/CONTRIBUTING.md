# How to contribute
To keep our repositories as uniform as possible, and work together effectively please consider the following.

## Our Git workflow

Clearly, as we're on Github, we're using Git to manage our codebases, code review and versioning.  If you're new to Git, or Gitflow please see the following links:

* [Get Git Quickly](https://learnxinyminutes.com/docs/git/)
* [Git cheat sheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf)
* [Github Flow - basic concept](https://guides.github.com/introduction/flow/)
* [Atlassian Comparing Git Workflows](https://www.atlassian.com/git/tutorials/comparing-workflows/)
* [Atlassian Advanced Git Tutorials](https://www.atlassian.com/git/tutorials/advanced-overview/)

### Feature branch workflow - small projects

For smaller projects we're following this feature branch workflow that can be found [here](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)

### Gitflow workflow - larger projects

This [workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) is better suited to larger, ongoing projects with multiple releases and CI.

We use two primary branches. `master` and `develop`. `develop` is what you'll create pull requests against, and should be deployed to staging environments for testing.

Once enough work has gone in to create a deliverable and deployable piece of value, and all testing is complete we create a release branch (this is where we start adding version numbers, add documentation and do any prep related to the release).

This then gets merged into `master`, which will then be deployed to a production environment.

We should merge `master` back into `development`.  Ideally `master` should always represent what is in production.

### Contributing to the project
Always branch, and use the below naming schema for branches. Once you've completed the work for that branch, push it up to Github and open a pull request against `development`.

As with issues, and pull requests we're aiming to keep branches as short lived as possible, this reduces transaction costs, review time, merge conflicts and helps build momentum in the team.

#### Naming branches
We prefix our branch names to make it easier to see what branches relate to.

* `feature/<name>`  - a new feature
* `fix/<name>` - fixes an issue
* `style/<name>` - small front end updates
* `hotfix/<name>` - fixes against a release
* `release/<name>` - preparing for a release

### Pull requests
Pull requests should be kept as small as possible and solve a single problem. This eases review and avoids unnecessary merge conflicts. Pull requests should be reviewed by two team members.

**NB :** For front-end changes and style fixes, adding screenshots to the pull request is tremendously helpful in explaining what was done and why.

### Merging and deleting
Once two thumbs up :+1 have been received on a pull request, and all issues resolved, it should be merged quickly to avoid becoming "stale". Once merged, the branch should be deleted on Github.

### Commits and commit messages
Commits should also be kept as small as possible.

Commit titles should be 80 characters or shorter and additional descriptions should be used when necessary.

### Issues
If you think you've found a bug, or have a concern, check that its not already in the current issues, and then use the issue template if appropriate, if design/style related screenshots are helpful, and if it's a feature please describe it fully. If you're aware of who worked on the related functionality, mention them in the comments rather than assigning them.

### External contributors
Contributers external to Nona Creative who work on private repositories can be added on the settings page of that repository rather than adding them to teams. This allows for much more fine-grained access control.

### Versioning things
When it's neccessary to use versioning we should follow the Semver pattern as discussed [here](http://semver.org/).

We using a three number system, e.g.: `1.2.3`:

1. MAJOR version when you make incompatible API changes `1`
2. MINOR version when you add functionality in a backwards-compatible manner `2`
3. PATCH version when you make backwards-compatible bug fixes `3`

### Maintaining the ReadMe
This should be regularly updated with project details and developer instructions, particularly for setup, and any specific release instructions and notes.