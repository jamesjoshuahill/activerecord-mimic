ActiveRecord Mimic
==================

This code test was set by a London tech company.

The challenge
-------------

The goal of this task is to create a body for BaseClass.

BaseClass should implement validations like ActiveRecord does.
Every class inheriting from BaseClass should be able to use validations.
`item.rb` and the tests in `item_test.rb` were provided as a basic specification.

The aim was to write nice, universal code that would work with other parameters.

My response
-----------

This was my first foray into class instance variables and inheritance, so it
may not be the most creative way to solve this problem!

I generalised part of the problem by overwriting `self.method_missing`. However,
there is still more DRYing out to be done for the instance methods.

Furthermore, if I have time I would like to add tests to cover the implementation
I have written.
