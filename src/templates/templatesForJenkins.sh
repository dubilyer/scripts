#!/usr/bin/env bash

function cloneBaselineRepo {
	rm -rf GTForge_baseline || true
	echo "cloning git repository after cleanup"
	git clone git@github.com:gtforge/GTForge_baseline.git
	cd GTForge_baseline

	git fetch
	git checkout v7.8
	pwd
	sudo cp .pgpass ~
	chmod 0600 ~/.pgpass
	cd ~/sharedspace
}

