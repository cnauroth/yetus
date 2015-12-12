#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

personality_plugins "all,-checkstyle"

function personality_globals
{
  # shellcheck disable=SC2034
  GITHUB_REPO="apache/zookeeper"
  # shellcheck disable=SC2034
  PATCH_BRANCH_DEFAULT=trunk
  # shellcheck disable=SC2034
  BUILDTOOL=ant
  #shellcheck disable=SC2034
  JIRA_ISSUE_RE='^ZOOKEEPER-[0-9]+$'
}

function personality_modules
{
  local repostatus=$1
  local testtype=$2
  local extra=""

  yetus_debug "Personality: ${repostatus} ${testtype}"

  clear_personality_queue

  case ${testtype} in
    findbugs)
      # shellcheck disable=SC2034
      ANT_FINDBUGSXML="${BASEDIR}/build/test/findbugs/zookeeper-findbugs-report.xml"
      extra="-Dfindbugs.home=${FINDBUGS_HOME}"
      ;;
  esac

  # shellcheck disable=SC2086
  personality_enqueue_module . ${extra}
}