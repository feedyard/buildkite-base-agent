from invoke import task

@task
def buildlocal(ctx):
    ctx.run('docker build -t local/buildkite-base-agent:latest .')

@task
def testlocal(ctx):
    ctx.run("bash testlocal.sh")

# export BUILDKITE_AGENT_TOKEN= value from Buildkite
@task
def runlocalagent(ctx):
    LAUNCH = "docker run -v \"/var/run/docker.sock:/var/run/docker.sock\" " \
             "-e VAL1 " \
             "-e VAL2 " \
             "-d -t local/buildkite-base-agent:latest start " \
             "--token $BUILDKITE_AGENT_TOKEN " \
             "--tags \"queue=bootstrap\" "

    ctx.run(LAUNCH)

# run the standard Buildkite
@task
def runvendoragent(ctx):
    LAUNCH = "docker run -v \"/var/run/docker.sock:/var/run/docker.sock\" " \
             "-e VAL1 " \
             "-e VAL2 " \
             "-d -t buildkite/agent:3 start " \
             "--token $BUILDKITE_AGENT_TOKEN " \
             "--tags \"queue=vendor\" "

    ctx.run(LAUNCH)
