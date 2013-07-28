# rbenv-bundle-exec: The one true plugin for rbenv bundler integration

This plugin makes [rbenv](https://github.com/sstephenson/rbenv) `bundle exec` your ruby executables so you don't have to.

Unlike other rbenv bundler integration plugins out there, this plugin is extremely simple and uses significantly less code to offer a better solution to the same problem.
In fact, don't just take my word for it, go ahead and read this project's ~30 lines of code yourself.

## Installation

1. Obviously, before you get this plugin, you should have [rbenv](https://github.com/sstephenson/rbenv) up and running.

2. Clone this repository into your `~/.rbenv/plugins` directory:

    ~~~ sh
    $ git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec
    ~~~

3. You should probably also get [rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash), which, is a plugin that automatically runs `rbenv rehash` every time you install or uninstall a gem that exposes ruby executables.

    Without [rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash), you'll need to remember to run `rbenv rehash` every time you use `bundle install` to install new gems with executables. But seriously, just do yourself a favor and get the plugin, you'll thank yourself for it later.

4. Never have to run `bundle exec` ever again!

## Usage

This plugin will check if you have bundler installed, if so it will search for a Gemfile in the current directory and its ancestors (up to root). If a Gemfile is found, it will forward whatever ruby executable command you wrote to bundle exec. That's it.

### Disabling the plugin

If, for whatever reason, you decided you wanted to run a ruby executable under a directory that has a Gemfile, but didn't want this plugin to forward it to `bundle exec`, you can do so by setting the environmant variable `NO_BUNDLE_EXEC` to a non-empty string, for example:

~~~ sh
$ NO_BUNDLE_EXEC=1 rake --version
~~~

Running the previous command will bypass rbenv-bundle-exec and run `rake --version` and not `bundle exec rake --version` even if the current directory satisfies all the conditions mentioned above.

## Similar plugins

1. [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs) - Provides bundler integration by using binstubs. However, it requires that you manually install bundler binstubs for all of your projects. I don't like that.

2. [rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) - Provides bundler integration by adjusting rbenv's shims and the `rbenv which` command with respect to the current project's bundle. However, [its usage is not recommended by rbenv maintainers](https://github.com/carsomyr/rbenv-bundler/issues/32).

### Why use rbenv-bundle-exec instead of the ones listed above

I believe that this plugin offers the best of both worlds; it lets you enjoy the same benefits of fully automated integration that [rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) provides, without having to settle for less speed or less stability than those provided by [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs).

## License

Copyright (c) 2013 Marwan Al Jubeh - Released under the MIT-LICENSE.

