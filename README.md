# rbenv-bundle-exec: The one true plugin for rbenv bundler integration

This plugin makes [rbenv](https://github.com/sstephenson/rbenv) `bundle exec` your ruby executables so you don't have to.

Unlike other rbenv bundler integration plugins out there, this plugin is extremely simple and uses significantly less code to offer a better solution to the same problem.
In fact, don't just take my word for it, go ahead and read the code yourself. The entire project is ~40 lines of code.

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

### Caveats (Please Read This Before Installing)

Before you install this plugin you need to clearly understand that after installing it, *every time* you run *any* ruby executable under any directory that has a Gemfile, this plugin will forward your command to `bundle exec`. Of course you already knew this. Afterall, you need things to run under `bundle exec` 90% of the time, and this is probably why you're here in the first place.

This section is meant to point your attention to some use-cases that belong to the remaining 10%, when `bundle exec` is not what you want, and should help you make sure that rbenv-bundle-exec stays out of the way when you're in such situations.

The reason I think this is so important is that, due to its fully-automated nature, it is extremely easy to completely forget about rbenv-bundle-exec when you try to run a ruby command that shouldn't be run through `bundle exec`. I will mention here some of the main pitfalls that you might encounter. Hopefully, having read this, you'll escape those pitfalls after a couple of seconds rather than after possibly endless hours.

1. Running `gem`:

  There aren't many good reasons why anyone would want gem to be *always* executed using `bundle exec` by default. What's more, there are so many ways that things could break if you try to run `bundle exec gem install`. For this reason, *The plugin will always ignore `gem` and not forward its commands to `bundle exec`*.

2. Running `irb`:

  When you run `irb`, it will be executed under the context of your current bundle (aka. `bundle exec irb`). This means that there will be no discrepency between what you see in `irb` and what your app does due to them using different versions of some gem. However, it also means that *requiring gems that don't belong to your bundle will not work unless you run `irb` with the plugin disabled*. If you find yourself wondering why `irb` is stubbornly refusing to require a gem that you know is installed, try to disable the plugin first before you curse the ghost inside the machine.

  If you use [pry](https://github.com/pry/pry) and have it in your Gemfile, I recommend checking out [pry-debundle](https://github.com/ConradIrwin/pry-debundle) which would allow you to require gems not in your Gemfile from pry.

3. Running ruby executables that are not in your project's Gemfile:

  Your development workflow might include running executables for static analysis gems or for irb replacements like the awesome [pry](https://github.com/pry/pry). Because everyone has their unique set of tools that they like to use, those tools are often not included in the Gemfiles of projects shared between several people. If that's the case, then you'll need to disable the plugin for those tools' commands to be able to run them. Of course if you forget to disable the plugin for some command, bundler will complain that it can't find it, which should remind you of rbenv-bundle-exec and the need to disable it to be able to run that command.

4. Other cases:

  I think I've covered the most common cases. However, that doesn't mean that I've covered them all. If you start getting extremely weird behavior from some of your gems, it's probably wise to try to disable this plugin (and others that might look suspicious) before you go and blame innocent people for my bad code or your bad memory.

### Disabling the Plugin

There are several good reasons why you would want to disable the plugin for a certain command. Some of these situations are mentioned in the "Caveats" section above. Regardless of your specific circumstances, there are several ways you could bypass the plugin for a command of your choice:

1. Setting the environmant variable `NO_BUNDLE_EXEC` to a non-empty string:

  ~~~ sh
  $ NO_BUNDLE_EXEC=1 pry
  ~~~

  Running the previous command will bypass rbenv-bundle-exec and run `pry` and not `bundle exec pry`. You can of course also use aliases so you won't have to type NO_BUNDLE_EXEC all the time:

  ~~~ sh
  $ alias pry='NO_BUNDLE_EXEC=1 pry'
  $ pry # All future invokations of pry will run without `bundle exec`
  ~~~

2. List the commands to be skipped in `$HOME/.no_bundle_exec`, each on a separate line. For example:

  ~~~ sh
  $ echo irb >> ~/.no_bundle_exec
  $ echo pry >> ~/.no_bundle_exec

  $ irb # All future invokations of irb, pry & other commands added to the .no_bundle_exec file will run without `bundle exec`
  ~~~

## Similar plugins

1. [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs) - Provides bundler integration by using binstubs. However, it requires that you manually install bundler binstubs for all of your projects. I don't like that.

2. [rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) - Provides bundler integration by adjusting rbenv's shims and the `rbenv which` command with respect to the current project's bundle. However, [its usage is not recommended by rbenv maintainers](https://github.com/carsomyr/rbenv-bundler/issues/32).

### Why use rbenv-bundle-exec instead of the ones listed above

I believe that this plugin offers the best of both worlds; it lets you enjoy the same benefits of fully automated integration that [rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) provides, without having to settle for less speed or less stability than those provided by [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs).

## License

Copyright (c) 2013 Marwan Al Jubeh - Released under the MIT-LICENSE.

