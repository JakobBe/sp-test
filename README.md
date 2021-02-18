# README

# About

This is a ruby script to analyze log data from a webserver provided in a log file. 

# Dependencies

- Ruby 2.6.6 or higher 
- RSpec 3.10 or higher (only needed to run the tests)

# Setup

To be able to run this script on your machine please:

### Clone project to your machine
    $ git clone git@github.com:JakobBe/sp-test.git
    $ cd sp-test

# Use script

You can start analyzing webserver logs by runnig: 
  (The repo comes with two sample log files inside the data folder)
    
    $ ruby lib.interface

You can analyze additional logs by adding a logfile to the data folder.

# Tests

The developemt of the script was test-driven. Modlues and Classes used in this script are fully tested by unit test. However, there are no end-to-end tests yet to test the user interface.

To start the tests run:

    $ rspec