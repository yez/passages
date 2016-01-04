## Passages

![Build Status](https://travis-ci.org/yez/passages.svg?branch=master)

## Purpose

This Rails Engine adds the ability to search over different attributes of Ruby on Rails routes within an application.

For example, an internal (or very permissive external) API can now expose a single page that will answer simple questions like: *"What was the HTTP verb for the `/users/clear_password` route?"* or *"Does a v2 or v3 version for this route exist?"*.

## Demo

![Demo](demo.gif)

## Install

In your `Gemfile`

```ruby
source 'https://rubygems.org'
gem 'passages'
```

`bundle install`

The `Passages` engine will **prepend** a `/passages` route to the application's routes. This means that if a project's `routes.rb` specifically defines a `/passages` route, the `Passages` Engine will not overwrite that.

Visiting `/passages` will display a search box and list of all known routes in an application.

## Authorization

Since there are no environment dependent checks, the `/passages` page uses configurable http basic authentication.

Default username: **username**

Default password: **password**

## Contributing

Please feel free to fork and contribute your own changes to the Passages project. Single commits are preferred with a description of why the contribution is useful.
