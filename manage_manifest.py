from office365.runtime.auth.authentication_context import AuthenticationContext
from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.user_credential import UserCredential
from office365.sharepoint.listitems.listitem import ListItem
import pandas as pd
import os
import sys


repo_name = sys.argv[1]
action_type = sys.argv[2]
print(repo_name)
print(action_type)

### Set up Sharepoint connection

url='https://xxxx.sharepoint.com/sites/CPSBusinessIntelligenceAnalytics'
appid= os.environ['sharepoint_appid']  
appsecret=os.environ['sharepoint_api_key']

ctx_auth = AuthenticationContext(url)
ctx_auth.acquire_token_for_app(appid,appsecret)
ctx = ClientContext(url, ctx_auth)

list_title = "dbt_manifests"  ## this is the directory on sharepoint



if action_type=='pull_request':
    # this is a pull request so we need to get the last manifest.json
    file_url = "/sites/CPSBusinessIntelligenceAnalytics/dbt_manifests/" + repo_name + ".json"
    download_path="manifest.json"
    with open(download_path, "wb") as local_file:
        file = ctx.web.get_file_by_server_relative_path(file_url).download(local_file).execute_query()
else:
    # we need to upload the latest manifest.json
    path = "./target/manifest.json"
    with open(path, 'rb') as content_file:
        file_content = content_file.read()
    target_folder = ctx.web.lists.get_by_title(list_title).root_folder
    name = repo_name + ".json"
    target_file = target_folder.upload_file(name, file_content).execute_query()
