#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# RULES #

#/
# Runs JavaScript benchmarks consecutively.
#
# ## Notes
#
# -   The recipe assumes that benchmark files can be run via Node.js.
# -   This rule is useful when wanting to glob for JavaScript benchmark files (e.g., run all JavaScript benchmarks for a particular package).
#
#
# @param {string} [BENCHMARKS_FILTER] - file path pattern (e.g., `.*/utils/group-by/.*`)
#
# @example
# make benchmark-javascript
#
# @example
# make benchmark-javascript BENCHMARKS_FILTER=".*/utils/group-by/.*"
#/
benchmark-javascript: $(NODE_MODULES)
	$(QUIET) $(FIND_BENCHMARKS_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		NODE_ENV="$(NODE_ENV_BENCHMARK)" \
		NODE_PATH="$(NODE_PATH_BENCHMARK)" \
		$(NODE) $(NODE_FLAGS_BENCHMARK) $$file || exit 1; \
	done

.PHONY: benchmark-javascript

#/
# Runs a specified list of JavaScript benchmarks consecutively.
#
# ## Notes
#
# -   The recipe assumes that benchmark files can be run via Node.js.
# -   This rule is useful when wanting to run a list of JavaScript benchmark files generated by some other command (e.g., a list of changed JavaScript benchmark files obtained via `git diff`).
#
#
# @param {string} FILES - list of JavaScript benchmark file paths
#
# @example
# make benchmark-javascript-files FILES='/foo/benchmark.js /bar/benchmark.js'
#/
benchmark-javascript-files: $(NODE_MODULES)
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		NODE_ENV="$(NODE_ENV_BENCHMARK)" \
		NODE_PATH="$(NODE_PATH_BENCHMARK)" \
		$(NODE) $(NODE_FLAGS_BENCHMARK) $$file || exit 1; \
	done

.PHONY: benchmark-javascript-files
