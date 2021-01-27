CLOUDFRONT_DISTRIBUTION = $(CLOUDFRONT_DISTRIBUTION)
all: send_to_s3 clear_cache

send_to_s3:
	. ./.env
	aws s3 cp ./ s3://jerkchickenradio.com.au/ --recursive \
	--acl public-read \
	--exclude "Makefile" \
	--exclude "README.md" \
	--exclude ".env" \
	--exclude ".gitignore" \
	--exclude "LICENSE" \
	--exclude ".git/*" \

clear_cache:
	. ./.env
	aws cloudfront create-invalidation \
	--distribution-id $${CLOUDFRONT_DISTRIBUTION} \
	--paths "/*"
