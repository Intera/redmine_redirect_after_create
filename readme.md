# redmine_redirect_after_create

This Redmine plugin allows to specify a custom redirect URL when a new issue is created.

You can use it by appending the redirect_url parameter the the URL for creating a new issue.

For example:

http://my-redmine-url.tld/projects/myprojects/issues/new?redirect_url=/projects

This URL will redirect the user to the projects overview after the ticket was created.
