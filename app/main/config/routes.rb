# See https://github.com/voltrb/volt#routes for more info on routes


get '/about', _action: 'about'
#get '/jobs', _controller: 'jobs'
get '/jobs/{{_index}}', _action: 'jobs'
get '/jobs', _action: 'jobs'

# The main route, this should be last.  It will match any params not previously matched.
get '/', {}
