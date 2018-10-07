# cni-hello-world

## Tools
- tfenv `brew install tfenv`
- terraform `tfenv install 0.11.8`
- alias `tf=terraform`
- nodejs 8.12.0
- docker latest

## Notes
- terraform state could be saved/locked remotely in a team setting
- could pull variables from remote state, like repository
- renamed a module `terraform state mv module.cluster module.environment`
- https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_cannot_pull_image.html

## Reference
- https://www.terraform.io/docs/providers/aws/index.html

## TODO
- check tags
- check config defaults
- check variables sections
- scaling
