## README


This is the code for the website at bmoreonrails.org. If you'd like to help out, make a change, add a feature then come to a B'more on Rails hack night!

### Setup

* Install ruby 2.0
* `bundle install`
* `touch config/database.yml`
* Add the code below to your database.yml
```
development:
  adapter:  postgresql
  encoding: unicode
  host:     localhost
  database: bmoreonrails_development
```
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
  email:       'makes@gravatar.work'
```

The `avatar_file` field is a 200x200-pixel picture of you. If you have ImageMagick installed, you can find a command to resize your image in the ["Convert member images to square thumbnails"](https://github.com/bmoreonrails/bmoreonrails.org#convert-member-images-to-square-thumbnails) section at the bottom of this README.

It needs to be in the `app/assets/images/members` directory to be displayed.

If you have your Gravatar set up you can ignore the avatar file instructions and just specify the `email` field and your image will get pulled from Gravatar! It's really convenient, so go check it out if you haven't already: ["Get Gravatar"](http://en.gravatar.com/)

## Deployment instructions

The site is deployed to Heroku, contact a B'more on Rails organizer to be added as a collaborator to the heroku app.

## Notes

### Convert member images to square thumbnails

This command requires that you have ImageMagick installed on your machine. If you are on OS X and you have [Homebrew](http://brew.sh) installed, you can run `brew install imagemagick` to install ImageMagick to get this command. On Linux, you can install it with your distribution's package manager.

    for f in `ls -1 *.jpeg`; do convert -define jpeg:size=200x200 $f -thumbnail 200x200^ -gravity center -extent 200x200 app/assets/images/members/$f ; done

To resize one image:

    convert -define jpeg:size=200x200 original_avatar.jpg -thumbnail 200x200^ -gravity center -extent 200x200  your_avatar.jpg

### Meetup integration

#### API key management

We use an ["API key signed URL"](https://www.meetup.com/meetup_api/auth/#keysign) to pull meetups from our meetup page onto the site. If this key is removed, a brave soul will be tasked with forming a new `UPCOMING_EVENTS_URL` in the Meetup model. This is accomplished by:

1) ["Getting or generating your API key"](https://secure.meetup.com/meetup_api/key/) from meetup.
2) Making the desired request with your API key: https://api.meetup.com/2/events?key=(YOUR_KEY_HERE)&group_id=347566&sign=true&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=20&fields=&time=%2C5w
3) Update the `UPCOMING_EVENTS_URL` in the Meetup model using the `signed_url` returned in the meta response

You shouldn't update the `UPCOMING_EVENTS_URL` value with the URL you use in step 2 because that contains your API key, which anyone can use to make authorized requests against the meetup API, as well as to pull information from YOUR meetup account.

#### Updating meetups in development

In production meetups are updated with a scheduled job, in order to update the meetups locally you have to use the rake task `rake update_meetups`.
