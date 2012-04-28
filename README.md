# Formulate

Rails form builder with flexible markup and styles.

Formulate consists of a custom form builder, which replaces the default form
builder in Rails, and a Sass style sheet that can be customized with variables.


## Installation

Add this line to your application's `Gemfile`:

``` ruby
gem 'formulate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formulate


## Usage

The form builder will be used automatically, so you don't need to do anything.

If you'd like to use Formulate's style sheet, you'll need to include it in
a Sass file, like `app/assets/stylesheets/form.css.sass`, and add the following:

``` sass
@import formulate
```

Formulate's styles are all scoped under the selector
`form.formulate`, so it shouldn't clobber anything in your own applications.


### Customizing Styles

To customize the styles, you may set any of the variables used by the style
sheet before importing it:

``` sass
$input_focus_border_color: $blue
$submit-button-color: $blue

@import formulate
```

Take a look at the variables at the top of
`/vendor/assets/stylesheets/formulate.css.sass` to see what's available for
customization.

You can always override any of the styles after importing the Formulate style
sheet, too.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright © 2012 Tyler Hunt. See LICENSE for details.
