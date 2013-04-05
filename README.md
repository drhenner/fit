#ROR Ecommerce

##Project Overview

Please create a ticket on github if you have issues.
They will be addressed ASAP.

Please look at the [homepage](http://www.ror-e.com) for more details.  Or take a look at the [github page](http://drhenner.github.com/ror_ecommerce/index.html)

![RoR Ecommerce](http://ror-e.com/images/logo.png "ROR Ecommerce").

This is a Rails e-commerce platform.
ROR Ecommerce is a *Rails 3 application* with the intent to allow developers to create an ecommerce solution easily.
This solution includes an Admin for *Purchase Orders*, *Product creation*, *Shipments*, *Fulfillment* and *creating Orders*.
There is a minimal customer facing shopping cart understanding that this will be customized.
The cart allows you to track your customers' *cart history* and includes a *double entry accounting system*.

The project has *Solr searching*, *Compass* and *Blueprint for CSS* and uses *jQuery*.
The gem list is quite large and the project still has a large wish list.
In spite of that, it is currently the most complete Rails solution, and it will only get better.

Please use *Ruby 1.9.3* and enjoy *Rails 3.2*.

ROR Ecommerce is designed so that if you understand Rails you will understand ROR_ecommerce.
There is nothing in this project besides what you might see in a normal Rails application.
If you don't like something, you are free to just change it like you would in any other Rails app.

Contributors are welcome!
We will always need help with UI, documentation, and code, so feel free to pitch in.
To get started, simply fork this repo, make *any* changes (big or small), and create a pull request.

##DEMO

Take a look at [The Demo](https://ror-e.herokuapp.com).
The login name is test@ror-e.com with a password => test123

##Getting Started

Please feel free to ask/answer questions in our [Google Group](http://groups.google.com/group/ror_ecommerce).

Install RVM with Ruby 1.9.3.
If you have 1.9.3 on your system you're good to go.
Please refer to the [RVM](http://beginrescueend.com/rvm/basics/) site for more details.

Copy the `database.yml` for your setup.
For SQLite3, `cp config/database.yml.sqlite3 config/database.yml`.
For MySQL, `cp config/database.yml.mysql config/database.yml` and update your username/password.

If you are using the mysql dmg file to install mysql you will need to edit your ~/.bash_profile and include this:

  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

Run `rake secret` and copy/paste the output as `encryption_key` in `config/config.yml`.

    gem install bundler
    bundle install
    rake db:create:all
    rake db:migrate db:seed
    rake db:test:prepare

Once everything is set up, start the server with `rails server` and direct your web browser to [localhost:3000/admin/overviews](http://localhost:3000/admin/overviews).
Write down the username/password (these are only shown once) and follow the directions.

## Environmental Variables

Most users are using Amazon S3 or Heroku.
Thus we have decided to have a setup easy to get your site up and running as quickly as possible
in this production environment.  Hence you should add the following ENV variables:

    FOG_DIRECTORY     => your bucket on AWS
    AWS_ACCESS_KEY_ID => your access key on AWS
    AWS_ACCESS_KEY_ID => your secret key on AWS

On linux:

    export FOG_DIRECTORY=xxxxxxxxxxxxxxx
    export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
    export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

On Heroku:

    heroku config:add FOG_DIRECTORY=xxxxxxxxxxxxxxx
    heroku config:add AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
    heroku config:add AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    heroku labs:enable user-env-compile -a myapp

## Redis

Install redis

    $ wget http://redis.googlecode.com/files/redis-2.6.12.tar.gz
    $ tar xzf redis-2.6.12.tar.gz
    $ cd redis-2.6.12
    $ make

or

    $ curl -O http://redis.googlecode.com/files/redis-2.6.12.tar.gz
    $ tar xzf redis-2.6.12.tar.gz
    $ cd redis-2.6.12
    $ make

add redis to your PATH:

     export PATH="/Users/drhenner/redis-2.6.12/src:/usr/lib/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/local/heroku/bin:$PATH"

##Easy UFCfit development setup

First create a Procfile in the Rails route

now you can start memcached, and redis and set ENV variable right in the foreman Procfile

The Procfile should look like this:

```ruby
  memcached:  memcached -vv
  rails:      rails s --debugger
```

The .env file should look like:

```ruby
  FOG_DIRECTORY=xxxxxxxxxxxxxxx
  AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
  AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Ask the project manager for the values to fill in xxxxxxxxxxxxxxx

you also need to install foreman & start foreman

    bundle install
    foreman start


##ImageMagick and rMagick on OS X 10.8
------------------------------------

If installing rMagick on OS X 10.8 and using Homebrew to install ImageMagick, you will need to symlink across some files or rMagick will not be able to build.

Do the following in the case of a Homebrew installed ImageMagick(and homebrew had issues):

    * cd /usr/local/Cellar/imagemagick/6.8.0-10/lib
    * ln -s libMagick++-Q16.7.dylib   libMagick++.dylib
    * ln -s libMagickCore-Q16.7.dylib libMagickCore.dylib
    * ln -s libMagickWand-Q16.7.dylib libMagickWand.dylib

##YARDOCS

If you would like to read the docs, you can generate them with the following command:

    yardoc --no-private --protected app/models/*.rb

####Payment Gateways

First, create `config/settings.yml` and change the encryption key and paypal/auth.net information.
You can also change `config/settings.yml.example` to `config/settings.yml` until you get your real info.

## Paperclip

Paperclip will throw errors if not configured correctly.
You will need to find out where Imagemagick is installed.
Type: `which identify` in the terminal and set

```ruby
Paperclip.options[:command_path]
```

equal to that path in `config/paperclip.rb`.

Example:

Change:

```ruby
Paperclip.options[:command_path] = "/usr/local/bin"
```

Into:

```ruby
Paperclip.options[:command_path] = "/usr/bin"
```

##Adding Dalli For Cache and the Session Store

While optional, for a speedy site, using memcached is a good idea.

Install memcached.
If you're on a Mac, the easiest way to install Memcached is to use [homebrew](http://mxcl.github.com/homebrew/):

    brew install memcached

    memcached -vv


##Resque admin

Resque admin is accessible at /resque.

To run ensure that resque jobs run locally use forman to start the
server.

##Author

RoR Ecommerce was created by David Henner. [Contributors](https://github.com/drhenner/ror_ecommerce/blob/master/Contributors.md).

##FYI:

Shipping categories are categories based off price:

you might have two shipping categories (light items) & (heavy items)

Have fun!!!
