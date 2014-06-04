Listen to - RAILS
======================================
A quantitative way of sharing with people what you enjoy listening to.

Users add youtube songs they enjoy to their lists.
Listen to then compiles statistics about those songs, to give you some insight on your or someone else's preferences.

<hr>

Some statistics it gives you now:
----------
* View counts
* Like counts
* Favorite counts
* Average View Counts
* Average Likability Rating

Future statistics:
------
* Music publication time line
* Map of publication locations
* Likability Rating for individual songs



Look forward to:
--------
* User's current favorite song in stream form
* Search playlists for a certain song
* thumbnails from album art
* Youtube account connection
* upload playlists from Youtube
* sharing via Facebook and Twitter

<hr>

[![Code Climate](https://codeclimate.com/github/bebepeng/listen_to.png)](https://codeclimate.com/github/bebepeng/listen_to)
[![Build Status](https://travis-ci.org/bebepeng/listen_to.svg?branch=master)](https://travis-ci.org/bebepeng/listen_to)


URLs
====
* PivotalTracker - [https://www.pivotaltracker.com/n/projects/1072574](https://www.pivotaltracker.com/n/projects/1072574)
* Running Site - [http://calm-basin-9174.herokuapp.com/](http://calm-basin-9174.herokuapp.com/)


Setup Instructions
==================
1. Clone this repository
1. `bundle`
1. Create databases: `rake db:create`
1. Run migrations: `rake db:migrate`
1. Create a .env file using .env.example as a guide
1. Run Specs `rspec`
1. Run Local Server `rails s`

On Heroku
---------
1. `heroku run 'rake db:migrate' -a HEROKUAPP`

Admins
======
*
