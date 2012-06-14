= TooFactor Site

This is the marketing site and account management site for TooFactor.


= Deployment

== Environment Variables

The following variables are used by TooFactor when deploying. To set an environment variable on heroku use the heroku gem as follows:

```
  heroku config:add VARIABLE=value
```

To see a list of all environment variables and their current values for a heroku instance use:

```
  heroku config --app appname
```