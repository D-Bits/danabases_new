
# Run the dev server
dev:
	hugo server

# Build the site
build:
	hugo

# Test deploy to Netlify
test:
	hugo 
	netlify deploy 

# Final deploy to Netlify
prod:
	hugo
	netlify deploy --prod