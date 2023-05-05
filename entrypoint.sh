#dbt run --profiles-dir .
echo "$repo_name"
if [[ "$github_action_type" = "pull_request" ]]
then
   python3 manage_manifest.py "$repo_name" "$github_action_type"
   dbt run --profiles-dir . --target ci --select state:modified+ --defer  --state ./
else
   dbt deps
   dbt -x run --profiles-dir . --target prod
   RESULT=$?
   if [ $RESULT -eq 0 ]; then
      python3 manage_manifest.py "$repo_name" "$github_action_type"
      echo "updated manifest to sharepoint"
      exit 0
   else
      exit 1
   fi
   #python3 manage_manifest.py "$repo_name" "$github_action_type"
fi

#echo "$etl_user_pw"
#ls -la
