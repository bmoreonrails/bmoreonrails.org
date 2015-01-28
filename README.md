## README


This is the code for the website at bmoreonrails.org. If you'd like to help out, make a change, add a feature then come to a B'more on Rails hack night!

### Setup

* Install ruby 2.0
* `bundle install`
* `rake db:create db:migrate`
* success!

## Adding yourself as a B'more on Rails member

The member list is in `config/members.yml`. To add yourself to the list, append a new entry in the following format:

```yaml
-
  name:        'Your name'
  github_name: 'your_github_handle'
  twitter:     'your_twitter_handle'
  avatar_file: 'your_avatar.jpg'
```

The `avatar_file` field is a 200x200-pixel picture of you. If you have ImageMagick installed, you can find a command to resize your image in the ["Convert member images to square thumbnails"](https://github.com/bmoreonrails/bmoreonrails.org#convert-member-images-to-square-thumbnails) section at the bottom of this README.

It needs to be in the `app/assets/images/members` directory to be displayed.

## Deployment instructions

The site is deployed to Heroku, contact a B'more on Rails organizer to be added as a collaborator to the heroku app.

## Notes

### Convert member images to square thumbnails

This command requires that you have ImageMagick installed on your machine. If you are on OS X and you have [Homebrew](http://brew.sh) installed, you can run `brew install imagemagick` to install ImageMagick to get this command. On Linux, you can install it with your distribution's package manager.

    for f in `ls -1 *.jpeg`; do convert -define jpeg:size=200x200 $f -thumbnail 200x200^ -gravity center -extent 200x200 app/assets/images/members/$f ; done

To resize one image:

    convert -define jpeg:size=200x200 original_avatar.jpg -thumbnail 200x200^ -gravity center -extent 200x200  your_avatar.jpg
