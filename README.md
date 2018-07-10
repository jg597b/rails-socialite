# RAILS SOCIALITE

This coding test consists of implementing the following 2 features, adding the tables considered
necessary via rails migrations.

**User RSVP**:

_Host side_ (only hosts should have access to this)
* For upcoming event blocks of event type “invite”, add “Invite” button. Clicking on it will take
the host to a page where they can search for users and add them to the invite list.
* For all event blocks, add “Export RSVP List” button. Clicking on it will trigger a CSV file
download that contains all the users who have RSVPd for the event, showing the users who
have replied yes first, followed by the ones who have replied no. The CSV file should have the
following fields: status (yes / no), first_name, last_name, email, phone_number, guests

_User side_ (only users should have access to this)
* Users should now also see the events of type “invite” for which they've been invited, along with
public events.
* For all event blocks, add “RSVP” button (only if the current date is between the event's RSVP
start date and end date, and the number of guests for the event hasn't exceeded the event's
capacity; if the event is full, the text “Event Full” should be shown instead). Clicking on it will
take the user to a page with a dropdown (Yes / No), a text field to specify the number of extra
guests and a “Submit” button. Selecting “No” in the dropdown will remove the RSVP if the
event is public, but it will otherwise mark the invite's status as “No”.
* Add “My Agenda” button to the “Actions” block. Clicking on that button will take the user to a
page where they can see a list of their upcoming RSVPs with the following format: “Event Start
Date (e.g. Oct 24th, 2018 12:00pm) – Event Name – Event Location”.

**Host Awards**
Create a rake task “hosts:awards”, that prints a CSV file of the 5 hosts with the most positive RSVPs
across all events in a given year. Fields: Business Name, RSVPs
