
# Run the dev server
dev:
	hugo server

# Build the site
build:
	hugo

# Test deploy to Netlify
test:
	netlify deploy 

# Final deploy to Netlify
prod:
	netlify deploy --prod