#!/bin/bash

# This script help overcome git/gitsubmodule constrains
# - Genuine upstream information is lost, which is annoying.
# - Base repo and submodules origins are not alined.

# Solutions:
# - Fetch preserved upstream from one of the submodules (web) and set it up in base.
# - Update the origins and upstreams for all submodules.

# This repository is mixing two features.
# - Git submodule: reference other git repository in one for dev purposes.
# - The web container is built from the apps container which allow two stage development.
# - Docker-compose healthy check which allow health check deployments.


submodules="apps/blob_utils apps/core_composer_app apps/core_curate_app apps/core_dashboard_app apps/core_dashboard_common_app "
submodules=${submodules}"apps/core_explore_common_app apps/core_explore_example_app apps/core_explore_federated_search_app "
submodules=${submodules}"apps/core_explore_keyword_app apps/core_explore_oaipmh_app apps/core_exporters_app apps/core_federated_search_app "
submodules=${submodules}"apps/core_main_app apps/core_module_blob_host_app apps/core_module_chemical_composition_app apps/core_module_excel_uploader_app "
submodules=${submodules}"apps/core_module_periodic_table_app apps/core_module_text_area_app apps/core_oaipmh_common_app apps/core_oaipmh_harvester_app "
submodules=${submodules}"apps/core_oaipmh_provider_app apps/core_parser_app apps/core_website_app apps/signals_utils apps/xml_utils"

echo "Before going further you must fork all the submodules to a common github/gitlab/... userspace or group space:"
echo "+++List of submodules+++"
echo "   Submodule: web"
for f in ${submodules}; do
  echo "   Submodule: "${f}
done;

read -p "Enter your submodules origin url (https://github.com/username_group): " origin_url

if test -z "$origin_url"
then
    echo "You have not provided your submodules orign."
    echo "We will skip updating their origin."
else
    echo "You have provided {"${origin_url}"} as your submodyles origin. We will use it."
fi

echo "Fixing web..."
cd web;
git checkout central-dev
git remote remove origin
if test -z "$origin_url"
then
    echo "..."
else
    git remote add origin ${origin_url}/MDCS-2.0.git
fi
git remote add upstream https://github.com/faical-yannick-congo/MDCS-2.0.git
cd ..
echo "...web fixed"

for f in ${submodules}; do
  repo=`echo $f | cut -d \/ -f 2`
  echo "Fixing "${repo}"...";
  cd ${f};
  git checkout central-dev
  git remote remove origin
  if test -z "$origin_url"
  then
        echo "..."
  else
      git remote add origin ${origin_url}/${repo}.git
  fi
  git remote add upstream https://github.com/usnistgov/${repo}.git
  cd ../..
  echo "..."${repo}" fixed"
done;
