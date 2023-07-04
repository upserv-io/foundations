# UpservFoundations



TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/upserv_foundations`. To experiment with that code, run `bin/console` for an interactive prompt.

## Updates
1. Make updates
2. update version in lib/upserv_foundations/version.rb: `VERSION = "X.X.X"`
3. commit / push changes as usual
4. create new tag (note the "v"): `$ git tag vX.X.X`
5. push tag (note the "v"): `$ git push origin vX.X.X`
6. update versions in apps using this gem: `gem 'upserv_foundations', ref: 'vX.X.X', git: 'https://github.com/upserv-io/foundations'`
7. install update: `$ bundle`

### File Structure
asset: vendor/assets
 until I can figure out how to have multiple files that get complied into one file, you have to put all styles in one file. Use comments to separate what would be files
 - stylesheets: vendor/assets/stylesheets/upserv_foundations.scss
channels: lib/upserv_foundations/channels
controller: lib/upserv_foundations/controllers
helpers: lib/upserv_foundations/helpers
javascript - ???
jobs: lib/upserv_foundations/jobs
mailers: lib/upserv_foundations/mailers
models: lib/upserv_foundations/models
views - don't add views. Use helpers and content_tag if you want to make component esc things

### Classes
Namespace all classes under UpservFoundations
- ex. bad:  lib/upserv_foundations/controllers/example_controller.rb -> ExampleController
- ex. good:  lib/upserv_foundations/controllers/example_controller.rb -> UpservFoundations::ExampleController
use same convention for helpers, jobs, mailers, models, etc. (all ruby classes)

helpers
1. create helper file 
1. require file in lib/upserv_foundations.rb
1. include helper class in lib/upserv_foundations.rb

other classes / autoloading...??? idk

### CSS
You cannot use tailwind styles because tailwind only includes classes as they are used withing your rails app. So if your rails app never uses the tailwind class "hidden" for example, but this gem does, then the "hidden" class will have no effect because tailwind never added it.

## Installation
add to Gemfile (replace X.X.X with latest version)
```
# A bunch of shared / default code
gem 'upserv_foundations', ref: 'vX.X.X', git: 'https://github.com/upserv-io/foundations'
```
install
```
$ bundle
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/upserv_foundations. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/upserv_foundations/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UpservFoundations project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/upserv_foundations/blob/master/CODE_OF_CONDUCT.md).
