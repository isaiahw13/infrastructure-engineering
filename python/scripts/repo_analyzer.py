import os
import requests
import json
import sys

print('---- GitHub Repo Analyzer ----')

# Get github repo info from user
gh_user = input('Enter a GitHub Username/Organization: ')
if not gh_user:
    gh_user = input('Username/Organization cannot be blank. Enter a name: ')

gh_repo = input('Enter the GitHub Repo Name: ')
if not gh_repo:
    gh_user = input('Repo Name cannot be blank. Enter a name: ')

# Grab repo data from GitHub API
url = 'https://api.github.com/repos/'+gh_user+'/'+gh_repo
headers = {'accept': 'application/vnd.github.object', 
           'X-GitHub-Api-Version': '2022-11-28'}
r = requests.get(url, headers=headers)

# Confirm that the request was successful
status = r.status_code
match status:
    case 301:
        print("ERROR 301: REPOSITORY MOVED PERMANENTLY")
        sys.exit(301)
    case 403:
        print("ERROR 403: FORBIDDEN")
        sys.exit(403)
    case 404:
        print("ERROR 404: REPOSITORY NOT FOUND")
        sys.exit(404)

# Parse response JSON
repo = r.json()

# Print repo info to console
print('\n---- ' + gh_user+'/'+gh_repo + ' Repo Information: ----')
print('Description: ' + repo['description'])
print('Primary Language: ' + repo['language'])
print('Stars: ' + str(repo['stargazers_count']))
print('Forks: ' + str(repo['forks_count']))
print('Open Issues: ' + str(repo['open_issues_count']))