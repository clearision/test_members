# README

This is a sample Rails 6 project

## Ruby version

`ruby-2.6.3`

## Installation

```
bundle install
rake db:migrate db:seed
```

## Members

Seeds create the following friendship relations:

```
John -> Jack
John -> Pete
Zoey -> Jack
Zoey -> Pete
```

So you can search for John's articles from Zoey's page and vice versa.
