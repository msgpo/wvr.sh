# Add Travis CI to GitHub Repo

## If you don't already have an account:

1. Sign up for Travis at https://travis-ci.org
2. Click 'Sign up with GitHub' to use your GitHub account.

## Enable Travis for your repositories

* Can either do this individually
* Or click the big button that will be displayed on login to enable for all GH repos

## Make a `.travis.yml` file in your repo

Perform whatever task you need here, travis will have most tools installed already.

#### Example for a POSIX sh script:

```
script:
  - shellcheck -s sh your_script.sh
```

## Add a build badge

This is a handle tool to show if your build is passing from the repo `README.md`

#### To do this:

1. Go to the repo on [travis-ci.org](http://travis-ci.org) and click on the similar looking badge.
2. Select 'Markdown' from the dropdown menu
3. Copy paste to the top of your repo's `README.md`

#### Example:

[![Build Status](https://travis-ci.com/mitchweaver/sssg.svg?branch=master)](https://travis-ci.com/mitchweaver/sssg)
