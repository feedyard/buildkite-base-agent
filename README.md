# feedyard/buildkite-base-agent

Based on [feedyard/buildkite-remote-docker](https://github.com/feedyard/buildkite-remote-docker). Includes common tools  
for building and testing docker images to be used as primary containers in infrastructure as code pipelines pipelines.

_additions_

apk/bin         | pip        |  gems
----------------|------------|---------
openrc          | pip        | inspec-bin
docker          | setuptools |
python3         | invoke     |
ruby            | pylint     |
ruby-bundler    | yamllint   |
ruby-bigdecimal |            |
ruby-webrick    |            |
curl            |            |
wget            |            |
gnupg           |            |
openssl         |            |
jq              |            |
hadolint        |            |

See CHANGELOG for list of installed packages/versions.
