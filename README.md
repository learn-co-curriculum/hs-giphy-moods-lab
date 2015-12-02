

## Giphy Mood Translator

You're going to build your very own MVC application to translate moods into gifs. It might look a little something like this [demo app](https://giphy-moods.herokuapp.com/).

Let's do this!

###Part 1 - Using the Giphy API

**Step 1** - What's the first letter in MVC stand for? The models! Check out `giph.rb` in the models directory. We've set up a Giph class and some methods to help you connect to the Giphy API. Let's take a look at the `search` method.

Try testing it out by adding
```ruby
gipher = Giph.new
@photos = gipher.search("happy")
```

to the `'/'` route in your application controller. Now we've got some `@photos` that we can display in `index.erb`. That file is in which directory? Did you say views?

**Step 2** - The V in MVC. We've got `@photos` - an array of image urls - and we want to display each of these images in `index.erb` (for now). You know how to do that! Now go do it.

**Step 3** - Did you see some photos on your home page? Excellent. Not everyone is happy all the time though, right? We want our visitors to be able to share their mood with us and then perform a Giph search with that info. How do we get input from a user? Did you say forms? Because that is the correct answer.

Go to `index.erb` and create a form that takes in a user's mood and posts that mood to a `'/results'` route in your application controller. Hint: You'll need form tags and input tags with type and name attributes.

**Step 4** - We've covered the M and the V in MVC so what's left? Yep, onto the C - the application controller. First we need to create that `post '/results'` route for our form. Then let's take this code from our `'/'` route
```ruby
gipher = Giph.new
@photos = gipher.search("happy")
```
and move it into the `post '/results'` route. We don't want to always search for "happy" though right. How do we take the mood from our form and replace "happy" with that input? Make it happen. Hint: You'll need to call on your old friend params.

**Step 5** - We're going to need a new template to display all of our fabulous gifs. Set up a new `results.erb` template file in your views to display your gifs. Hint: You've already written some helpful code in `index.erb` that you can transfer over to here.

**Step 6** - Fire up shotgun and test it out!

Great job! You're probably getting some pretty incredible gifs. You might want to save your favorites, huh? Time to build a new feature - the ability to save your favorite gif from the list!

###Part 2 - Saving your favorite gif
Whenever you add a new feature you need to think about each portion of the MVC. So...

**Step 1** - The M. We'll start off with one model/table for Moods with the following attributes/columns:

```ruby
:mood
:image_url
```

Set up your Mood class in a `mood.rb` file in the models directory (don't forget to inherit from from ActiveRecord::Base) and create a migration for the moods table `rake db:create_migration NAME="create_moods"`. Add your `up` and `down` methods in the migration file then run it with `rake db:migrate`.

**Step 2** - The V. The M is covered, now let's move onto the V for views. We're already displaying all of our gifs in `results.erb` but now we need to get some input from our user on which one they want to save. How do we get input from users? Did you say a form?! Good answer.

Let's wrap all of our photos in a form and add a radio button next to each photo so that users can click on the photo they like best and then hit save. We'll also need a hidden input to submit our mood. It's going to look a little something like this:

```erb
<form action="/save" method="post">
  <input type="hidden" name="mood" value="<%= @mood %>">
  <% @photo_urls.each do |url| %>
    <p>
      <input type="radio" name="url" value="<%=url%>">
      <img src="<%=url%>">
    </p>
  <% end %>
  <input type="submit" class="btn btn-primary btn-lg">
</form>
```

But what good is a form if the input is on a road to nowhere? We've come to the third component in our MVC.

**Step 3** - The C. You'll need to set up a `'/save'` route in your application controller that takes the params from your form and uses them to create a new entry in your `moods`. I know that you can do this! Don't forget to redirect your user after you've saved the gif.

Enjoy the fruits of your labor!

## Bonus Challenges
+ Add delete buttons to your list of saved gifs.
  * Hint 1: There is an ActiveRecord method that you can use to delete something from a table. It targets a specific record by the id number and it works a little like `.find` that way.
  * Hint 2: One strategy you can try is creating a little form around each individual photo with a "Delete" button (similar to a submit button but with different text inside of it).
+ Set up your app with user accounts.
+ Allow users to save a personal list of their favorite mood/gif matches.
  * Hint: The easiest way to do this is to set up a has_many/belongs_to relationship between users and moods. A user has_many moods and a mood belongs_to a user.


<a href='https://learn.co/lessons/hs-giphy-moods-lab' data-visibility='hidden'>View this lesson on Learn.co</a>
