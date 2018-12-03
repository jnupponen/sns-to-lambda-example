# define default target (which will be run if only 'make' command with no targets issued)
.DEFAULT_GOAL := help

# VARIABLES
ENVIRONMENT ?= dev
AWS_REGION ?= eu-west-1
AWS_STACK_NAME=sns-to-lambda-${ENVIRONMENT}

# TARGETS

# Taken from http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy:  ## Deploy application
	AWS_PROFILE=${AWS_PROFILE} aws cloudformation deploy \
		--template-file sns-to-lambda.template.yaml \
		--stack-name ${AWS_STACK_NAME} \
		--capabilities CAPABILITY_IAM \
		--no-fail-on-empty-changeset

remove: ## Destroy the stack
	AWS_PROFILE=${AWS_PROFILE} aws cloudformation delete-stack \
		--stack-name ${AWS_STACK_NAME}
