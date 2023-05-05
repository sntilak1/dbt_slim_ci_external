### Github workflow file run_dbt_model.yml

1. Line 33: Login into Github repo so that we can pull the dbt docker image stored in the repo packages
1. Line 37: Build the docker image from the base dbt docker package image using the Dockerfile of the repo.
1. Line 38: Run create and run the container with the dbt project in it.
1. Line 39: Remove the container.  
1. Line 43: Remove the image.
1. Line 49: Delete the working directory from the github runner.

### Entrypoint.sh

1. Line 5: if this is a pull request then pull the manifest.json from sharepoint for the repo
1. Line 6: run dbt with slim ci mode using state modified and defer to state copied from the downloaded manifest.json which represents the last successful dbt run
1. Line 8: if this is not a pull request (regular production run) then install the dbt dependencies
1. Line 9: run the dbt project in fail fast mode
1. Line 12: if the dbt run is successful then move the manifest json to the sharepoint location and exit with code 0
1. Line 16: if the run is completes with any error then set exit code as 1

### Manage_Manifest.py

1. This file either puts the manifest.json on sharepoint or retrieves it to implement ci.