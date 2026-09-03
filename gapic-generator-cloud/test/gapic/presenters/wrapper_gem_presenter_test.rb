# frozen_string_literal: true

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "test_helper"

class WrapperGemPresenterTest < PresenterTest
  NEW_GEM_NAME = "gapic-test-foo"
  GAPIC_COMMON_NAME = "google-cloud-core"

  ##
  # Testing that we can add a new dependency with a one-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_simple_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of String, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[NEW_GEM_NAME]
  end

  ##
  # Testing that we can add a new dependency with a one-part gem pattern
  # without a space and have it reflected correctly in the gem presenter
  def test_gem_dependencies_simple_new_without_spaces
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>=0.4.1"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of String, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal ">= 0.4.1", presenter_param.dependencies[NEW_GEM_NAME]
  end

  ##
  # Testing that we can add a new dependency with a multi-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_complex_bar_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1|< 2.a"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of Array, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal 2, presenter_param.dependencies[NEW_GEM_NAME].length
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], "< 2.a"
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], ">= 0.4.1"
  end

  ##
  # Testing that we can add a new dependency with a multi-part gem pattern
  # and have it reflected correctly in the gem presenter
  def test_gem_dependencies_complex_plus_new
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1+<2.a"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? NEW_GEM_NAME
    assert_kind_of Array, presenter_param.dependencies[NEW_GEM_NAME]
    assert_equal 2, presenter_param.dependencies[NEW_GEM_NAME].length
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], "< 2.a"
    assert_includes presenter_param.dependencies[NEW_GEM_NAME], ">= 0.4.1"
  end

  ##
  # Testing that bad syntax causes the right exception
  def test_gem_dependencies_bad_syntax
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{NEW_GEM_NAME}=>= 0.4.1+foobar+< 2.a"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert_raises RuntimeError, "Bad syntax for extra_dependency: foobar" do
      presenter_param.dependencies
    end
  end

  ##
  # Testing that we can override an existing dependency with a one-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_simple_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=~>0.4.1"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of String, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal "~> 0.4.1", presenter_param.dependencies[GAPIC_COMMON_NAME]
  end

  ##
  # Testing that we can override an existing dependency with a multi-part gem pattern
  # and have it reflected correctly in the wrapper gem presenter
  def test_gem_dependencies_complex_override
    complex_version_param = {
      ":gem.:extra_dependencies" => "#{GAPIC_COMMON_NAME}=>= 0.4.1|< 2.a"
    }

    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert presenter_param.dependencies.key? GAPIC_COMMON_NAME
    assert_kind_of Array, presenter_param.dependencies[GAPIC_COMMON_NAME]
    assert_equal 2, presenter_param.dependencies[GAPIC_COMMON_NAME].length
    assert_includes presenter_param.dependencies[GAPIC_COMMON_NAME], "< 2.a"
    assert_includes presenter_param.dependencies[GAPIC_COMMON_NAME], ">= 0.4.1"
  end

  def test_services_omit_mixins
    api_param = api :testing
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param
    refute_includes presenter_param.services.map { |s| s.address.join "." }, "google.cloud.location.Locations"
  end

  def test_gem_readme_disabled_xrefs
    complex_version_param = {
      ":gem.:description" => "Typical Garbage Service using [MixIns][testing.mixins.ServiceWithLoc]"
    }
    api_param = api :testing, params_override: complex_version_param
    presenter_param = Gapic::Presenters::WrapperGemPresenter.new api_param
    assert_equal ["Typical Garbage Service using MixIns"], presenter_param.readme_description
  end

  def test_renamed_gem_google_cloud_run_client
    params = {
      ":gem.:name" => "google-cloud-run-client",
      ":gem.:renamed_from" => "google-cloud-run",
      ":gem.:version_dependencies" => "v2:0.17"
    }
    api_param = api :testing, params_override: params
    presenter = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert_equal "google-cloud-run-client", presenter.name
    assert_equal "google-cloud-run", presenter.renamed_from
    assert presenter.renamed_gem?
    assert_equal "Google::Cloud::Run", presenter.namespace
    assert_equal "Google::Cloud::Run::Client", presenter.gem_namespace
    assert_equal "Google::Cloud::Run::Client::VERSION", presenter.version_name_full
    assert_equal "google/cloud/run/client/version", presenter.version_require
    assert_equal "google/cloud/run/client/version.rb", presenter.version_file_path
    assert_equal ["google-cloud-run-v2"], presenter.versioned_gems
    assert_equal [">= 0.17", "< 2.a"], presenter.dependencies["google-cloud-run-v2"]
    assert_equal "run", presenter.google_cloud_short_name
    assert presenter.needs_entrypoint?
    assert presenter.needs_default_config_block?
  end

  def test_renamed_gem_google_iam_client
    params = {
      ":gem.:name" => "google-iam-client",
      ":gem.:renamed_from" => "google-iam",
      ":gem.:version_dependencies" => "v2:0.5"
    }
    api_param = api :testing, params_override: params
    presenter = Gapic::Presenters::WrapperGemPresenter.new api_param

    assert_equal "google-iam-client", presenter.name
    assert_equal "google-iam", presenter.renamed_from
    assert presenter.renamed_gem?
    assert_equal "Google::Iam", presenter.namespace
    assert_equal "Google::Iam::Client", presenter.gem_namespace
    assert_equal "Google::Iam::Client::VERSION", presenter.version_name_full
    assert_equal "google/iam/client/version", presenter.version_require
    assert_equal "google/iam/client/version.rb", presenter.version_file_path
    assert_equal ["google-iam-v2"], presenter.versioned_gems
    assert_equal [">= 0.5", "< 2.a"], presenter.dependencies["google-iam-v2"]
    assert_nil presenter.google_cloud_short_name
    assert presenter.needs_entrypoint?
    refute presenter.needs_default_config_block?
  end
end
