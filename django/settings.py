# Django settings for munki-do project.
from django.conf import global_settings
from system_settings import *

###########################################################################
# munkiwebadmin-specific
###########################################################################

# APPNAME is user-visible web app name
APPNAME = 'MunkiWebAdmin2'
# MUNKI_REPO_DIR holds the local filesystem path to the Munki repo
MUNKI_REPO_DIR = '/munki_repo'
#MUNKI_REPO_DIR = '/Volumes/repo'

# path to the makecatalogs binary
MAKECATALOGS_PATH = '/munki-tools/code/client/makecatalogs'

# provide the path to the git binary if you want MunkiWebAdmin to add and commit
# manifest edits to a git repo
# if GITPATH is undefined or None MunkiWebAdmin will not attempt to do a git add
# or commit
#GIT_PATH = '/usr/bin/git'
