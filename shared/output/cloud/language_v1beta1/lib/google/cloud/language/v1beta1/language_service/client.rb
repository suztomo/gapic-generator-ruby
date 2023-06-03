# frozen_string_literal: true

# Copyright 2023 Google LLC
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

# Auto-generated by gapic-generator-ruby. DO NOT EDIT!

require "google/cloud/errors"
require "google/cloud/language/v1beta1/language_service_pb"

module Google
  module Cloud
    module Language
      module V1beta1
        module LanguageService
          ##
          # Client for the LanguageService service.
          #
          # Provides text analysis operations such as sentiment analysis and entity
          # recognition.
          #
          class Client
            # @private
            attr_reader :language_service_stub

            ##
            # Configure the LanguageService Client class.
            #
            # See {::Google::Cloud::Language::V1beta1::LanguageService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # @example
            #
            #   # Modify the configuration for all LanguageService clients
            #   ::Google::Cloud::Language::V1beta1::LanguageService::Client.configure do |config|
            #     config.timeout = 10.0
            #   end
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def self.configure
              @configure ||= begin
                namespace = ["Google", "Cloud", "Language", "V1beta1"]
                parent_config = while namespace.any?
                                  parent_name = namespace.join "::"
                                  parent_const = const_get parent_name
                                  break parent_const.configure if parent_const.respond_to? :configure
                                  namespace.pop
                                end
                default_config = Client::Configuration.new parent_config

                default_config
              end
              yield @configure if block_given?
              @configure
            end

            ##
            # Configure the LanguageService Client instance.
            #
            # The configuration is set to the derived mode, meaning that values can be changed,
            # but structural changes (adding new fields, etc.) are not allowed. Structural changes
            # should be made on {Client.configure}.
            #
            # See {::Google::Cloud::Language::V1beta1::LanguageService::Client::Configuration}
            # for a description of the configuration fields.
            #
            # @yield [config] Configure the Client client.
            # @yieldparam config [Client::Configuration]
            #
            # @return [Client::Configuration]
            #
            def configure
              yield @config if block_given?
              @config
            end

            ##
            # Create a new LanguageService client object.
            #
            # @example
            #
            #   # Create a client using the default configuration
            #   client = ::Google::Cloud::Language::V1beta1::LanguageService::Client.new
            #
            #   # Create a client using a custom configuration
            #   client = ::Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
            #     config.timeout = 10.0
            #   end
            #
            # @yield [config] Configure the LanguageService client.
            # @yieldparam config [Client::Configuration]
            #
            def initialize
              # These require statements are intentionally placed here to initialize
              # the gRPC module only when it's required.
              # See https://github.com/googleapis/toolkit/issues/446
              require "gapic/grpc"
              require "google/cloud/language/v1beta1/language_service_services_pb"

              # Create the configuration object
              @config = Configuration.new Client.configure

              # Yield the configuration if needed
              yield @config if block_given?

              # Create credentials
              credentials = @config.credentials
              # Use self-signed JWT if the endpoint is unchanged from default,
              # but only if the default endpoint does not have a region prefix.
              enable_self_signed_jwt = @config.endpoint == Configuration::DEFAULT_ENDPOINT &&
                                       !@config.endpoint.split(".").first.include?("-")
              credentials ||= Credentials.default scope: @config.scope,
                                                  enable_self_signed_jwt: enable_self_signed_jwt
              if credentials.is_a?(::String) || credentials.is_a?(::Hash)
                credentials = Credentials.new credentials, scope: @config.scope
              end
              @quota_project_id = @config.quota_project
              @quota_project_id ||= credentials.quota_project_id if credentials.respond_to? :quota_project_id

              @language_service_stub = ::Gapic::ServiceStub.new(
                ::Google::Cloud::Language::V1beta1::LanguageService::Stub,
                credentials:  credentials,
                endpoint:     @config.endpoint,
                channel_args: @config.channel_args,
                interceptors: @config.interceptors
              )
            end

            # Service calls

            ##
            # Analyzes the sentiment of the provided text.
            #
            # @overload analyze_sentiment(request, options = nil)
            #   Pass arguments to `analyze_sentiment` via a request object, either of type
            #   {::Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_sentiment(document: nil, encoding_type: nil)
            #   Pass arguments to `analyze_sentiment` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param document [::Google::Cloud::Language::V1beta1::Document, ::Hash]
            #     Input document.
            #   @param encoding_type [::Google::Cloud::Language::V1beta1::EncodingType]
            #     The encoding type used by the API to calculate sentence offsets for the
            #     sentence sentiment.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            # @example Basic example
            #   require "google/cloud/language/v1beta1"
            #
            #   # Create a client object. The client can be reused for multiple calls.
            #   client = Google::Cloud::Language::V1beta1::LanguageService::Client.new
            #
            #   # Create a request. To set request fields, pass in keyword arguments.
            #   request = Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest.new
            #
            #   # Call the analyze_sentiment method.
            #   result = client.analyze_sentiment request
            #
            #   # The returned object is of type Google::Cloud::Language::V1beta1::AnalyzeSentimentResponse.
            #   p result
            #
            def analyze_sentiment request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Language::V1beta1::AnalyzeSentimentRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_sentiment.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Language::V1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.analyze_sentiment.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_sentiment.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_sentiment, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Finds named entities (currently proper names and common nouns) in the text
            # along with entity types, salience, mentions for each entity, and
            # other properties.
            #
            # @overload analyze_entities(request, options = nil)
            #   Pass arguments to `analyze_entities` via a request object, either of type
            #   {::Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_entities(document: nil, encoding_type: nil)
            #   Pass arguments to `analyze_entities` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param document [::Google::Cloud::Language::V1beta1::Document, ::Hash]
            #     Input document.
            #   @param encoding_type [::Google::Cloud::Language::V1beta1::EncodingType]
            #     The encoding type used by the API to calculate offsets.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            # @example Basic example
            #   require "google/cloud/language/v1beta1"
            #
            #   # Create a client object. The client can be reused for multiple calls.
            #   client = Google::Cloud::Language::V1beta1::LanguageService::Client.new
            #
            #   # Create a request. To set request fields, pass in keyword arguments.
            #   request = Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest.new
            #
            #   # Call the analyze_entities method.
            #   result = client.analyze_entities request
            #
            #   # The returned object is of type Google::Cloud::Language::V1beta1::AnalyzeEntitiesResponse.
            #   p result
            #
            def analyze_entities request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Language::V1beta1::AnalyzeEntitiesRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_entities.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Language::V1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.analyze_entities.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_entities.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_entities, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Analyzes the syntax of the text and provides sentence boundaries and
            # tokenization along with part of speech tags, dependency trees, and other
            # properties.
            #
            # @overload analyze_syntax(request, options = nil)
            #   Pass arguments to `analyze_syntax` via a request object, either of type
            #   {::Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload analyze_syntax(document: nil, encoding_type: nil)
            #   Pass arguments to `analyze_syntax` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param document [::Google::Cloud::Language::V1beta1::Document, ::Hash]
            #     Input document.
            #   @param encoding_type [::Google::Cloud::Language::V1beta1::EncodingType]
            #     The encoding type used by the API to calculate offsets.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            # @example Basic example
            #   require "google/cloud/language/v1beta1"
            #
            #   # Create a client object. The client can be reused for multiple calls.
            #   client = Google::Cloud::Language::V1beta1::LanguageService::Client.new
            #
            #   # Create a request. To set request fields, pass in keyword arguments.
            #   request = Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest.new
            #
            #   # Call the analyze_syntax method.
            #   result = client.analyze_syntax request
            #
            #   # The returned object is of type Google::Cloud::Language::V1beta1::AnalyzeSyntaxResponse.
            #   p result
            #
            def analyze_syntax request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Language::V1beta1::AnalyzeSyntaxRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.analyze_syntax.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Language::V1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.analyze_syntax.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.analyze_syntax.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :analyze_syntax, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # A convenience method that provides all the features that analyzeSentiment,
            # analyzeEntities, and analyzeSyntax provide in one call.
            #
            # @overload annotate_text(request, options = nil)
            #   Pass arguments to `annotate_text` via a request object, either of type
            #   {::Google::Cloud::Language::V1beta1::AnnotateTextRequest} or an equivalent Hash.
            #
            #   @param request [::Google::Cloud::Language::V1beta1::AnnotateTextRequest, ::Hash]
            #     A request object representing the call parameters. Required. To specify no
            #     parameters, or to keep all the default parameter values, pass an empty Hash.
            #   @param options [::Gapic::CallOptions, ::Hash]
            #     Overrides the default settings for this call, e.g, timeout, retries, etc. Optional.
            #
            # @overload annotate_text(document: nil, features: nil, encoding_type: nil)
            #   Pass arguments to `annotate_text` via keyword arguments. Note that at
            #   least one keyword argument is required. To specify no parameters, or to keep all
            #   the default parameter values, pass an empty Hash as a request object (see above).
            #
            #   @param document [::Google::Cloud::Language::V1beta1::Document, ::Hash]
            #     Input document.
            #   @param features [::Google::Cloud::Language::V1beta1::AnnotateTextRequest::Features, ::Hash]
            #     The enabled features.
            #   @param encoding_type [::Google::Cloud::Language::V1beta1::EncodingType]
            #     The encoding type used by the API to calculate offsets.
            #
            # @yield [response, operation] Access the result along with the RPC operation
            # @yieldparam response [::Google::Cloud::Language::V1beta1::AnnotateTextResponse]
            # @yieldparam operation [::GRPC::ActiveCall::Operation]
            #
            # @return [::Google::Cloud::Language::V1beta1::AnnotateTextResponse]
            #
            # @raise [::Google::Cloud::Error] if the RPC is aborted.
            #
            # @example Basic example
            #   require "google/cloud/language/v1beta1"
            #
            #   # Create a client object. The client can be reused for multiple calls.
            #   client = Google::Cloud::Language::V1beta1::LanguageService::Client.new
            #
            #   # Create a request. To set request fields, pass in keyword arguments.
            #   request = Google::Cloud::Language::V1beta1::AnnotateTextRequest.new
            #
            #   # Call the annotate_text method.
            #   result = client.annotate_text request
            #
            #   # The returned object is of type Google::Cloud::Language::V1beta1::AnnotateTextResponse.
            #   p result
            #
            def annotate_text request, options = nil
              raise ::ArgumentError, "request must be provided" if request.nil?

              request = ::Gapic::Protobuf.coerce request, to: ::Google::Cloud::Language::V1beta1::AnnotateTextRequest

              # Converts hash and nil to an options object
              options = ::Gapic::CallOptions.new(**options.to_h) if options.respond_to? :to_h

              # Customize the options with defaults
              metadata = @config.rpcs.annotate_text.metadata.to_h

              # Set x-goog-api-client and x-goog-user-project headers
              metadata[:"x-goog-api-client"] ||= ::Gapic::Headers.x_goog_api_client \
                lib_name: @config.lib_name, lib_version: @config.lib_version,
                gapic_version: ::Google::Cloud::Language::V1beta1::VERSION
              metadata[:"x-goog-user-project"] = @quota_project_id if @quota_project_id

              options.apply_defaults timeout:      @config.rpcs.annotate_text.timeout,
                                     metadata:     metadata,
                                     retry_policy: @config.rpcs.annotate_text.retry_policy

              options.apply_defaults timeout:      @config.timeout,
                                     metadata:     @config.metadata,
                                     retry_policy: @config.retry_policy

              @language_service_stub.call_rpc :annotate_text, request, options: options do |response, operation|
                yield response, operation if block_given?
                return response
              end
            rescue ::GRPC::BadStatus => e
              raise ::Google::Cloud::Error.from_error(e)
            end

            ##
            # Configuration class for the LanguageService API.
            #
            # This class represents the configuration for LanguageService,
            # providing control over timeouts, retry behavior, logging, transport
            # parameters, and other low-level controls. Certain parameters can also be
            # applied individually to specific RPCs. See
            # {::Google::Cloud::Language::V1beta1::LanguageService::Client::Configuration::Rpcs}
            # for a list of RPCs that can be configured independently.
            #
            # Configuration can be applied globally to all clients, or to a single client
            # on construction.
            #
            # @example
            #
            #   # Modify the global config, setting the timeout for
            #   # analyze_sentiment to 20 seconds,
            #   # and all remaining timeouts to 10 seconds.
            #   ::Google::Cloud::Language::V1beta1::LanguageService::Client.configure do |config|
            #     config.timeout = 10.0
            #     config.rpcs.analyze_sentiment.timeout = 20.0
            #   end
            #
            #   # Apply the above configuration only to a new client.
            #   client = ::Google::Cloud::Language::V1beta1::LanguageService::Client.new do |config|
            #     config.timeout = 10.0
            #     config.rpcs.analyze_sentiment.timeout = 20.0
            #   end
            #
            # @!attribute [rw] endpoint
            #   The hostname or hostname:port of the service endpoint.
            #   Defaults to `"language.googleapis.com"`.
            #   @return [::String]
            # @!attribute [rw] credentials
            #   Credentials to send with calls. You may provide any of the following types:
            #    *  (`String`) The path to a service account key file in JSON format
            #    *  (`Hash`) A service account key as a Hash
            #    *  (`Google::Auth::Credentials`) A googleauth credentials object
            #       (see the [googleauth docs](https://rubydoc.info/gems/googleauth/Google/Auth/Credentials))
            #    *  (`Signet::OAuth2::Client`) A signet oauth2 client object
            #       (see the [signet docs](https://rubydoc.info/gems/signet/Signet/OAuth2/Client))
            #    *  (`GRPC::Core::Channel`) a gRPC channel with included credentials
            #    *  (`GRPC::Core::ChannelCredentials`) a gRPC credentails object
            #    *  (`nil`) indicating no credentials
            #   @return [::Object]
            # @!attribute [rw] scope
            #   The OAuth scopes
            #   @return [::Array<::String>]
            # @!attribute [rw] lib_name
            #   The library name as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] lib_version
            #   The library version as recorded in instrumentation and logging
            #   @return [::String]
            # @!attribute [rw] channel_args
            #   Extra parameters passed to the gRPC channel. Note: this is ignored if a
            #   `GRPC::Core::Channel` object is provided as the credential.
            #   @return [::Hash]
            # @!attribute [rw] interceptors
            #   An array of interceptors that are run before calls are executed.
            #   @return [::Array<::GRPC::ClientInterceptor>]
            # @!attribute [rw] timeout
            #   The call timeout in seconds.
            #   @return [::Numeric]
            # @!attribute [rw] metadata
            #   Additional gRPC headers to be sent with the call.
            #   @return [::Hash{::Symbol=>::String}]
            # @!attribute [rw] retry_policy
            #   The retry policy. The value is a hash with the following keys:
            #    *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
            #    *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
            #    *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
            #    *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
            #       trigger a retry.
            #   @return [::Hash]
            # @!attribute [rw] quota_project
            #   A separate project against which to charge quota.
            #   @return [::String]
            #
            class Configuration
              extend ::Gapic::Config

              DEFAULT_ENDPOINT = "language.googleapis.com"

              config_attr :endpoint,      DEFAULT_ENDPOINT, ::String
              config_attr :credentials,   nil do |value|
                allowed = [::String, ::Hash, ::Proc, ::Symbol, ::Google::Auth::Credentials, ::Signet::OAuth2::Client, nil]
                allowed += [::GRPC::Core::Channel, ::GRPC::Core::ChannelCredentials] if defined? ::GRPC
                allowed.any? { |klass| klass === value }
              end
              config_attr :scope,         nil, ::String, ::Array, nil
              config_attr :lib_name,      nil, ::String, nil
              config_attr :lib_version,   nil, ::String, nil
              config_attr(:channel_args,  { "grpc.service_config_disable_resolution" => 1 }, ::Hash, nil)
              config_attr :interceptors,  nil, ::Array, nil
              config_attr :timeout,       nil, ::Numeric, nil
              config_attr :metadata,      nil, ::Hash, nil
              config_attr :retry_policy,  nil, ::Hash, ::Proc, nil
              config_attr :quota_project, nil, ::String, nil

              # @private
              def initialize parent_config = nil
                @parent_config = parent_config unless parent_config.nil?

                yield self if block_given?
              end

              ##
              # Configurations for individual RPCs
              # @return [Rpcs]
              #
              def rpcs
                @rpcs ||= begin
                  parent_rpcs = nil
                  parent_rpcs = @parent_config.rpcs if defined?(@parent_config) && @parent_config.respond_to?(:rpcs)
                  Rpcs.new parent_rpcs
                end
              end

              ##
              # Configuration RPC class for the LanguageService API.
              #
              # Includes fields providing the configuration for each RPC in this service.
              # Each configuration object is of type `Gapic::Config::Method` and includes
              # the following configuration fields:
              #
              #  *  `timeout` (*type:* `Numeric`) - The call timeout in seconds
              #  *  `metadata` (*type:* `Hash{Symbol=>String}`) - Additional gRPC headers
              #  *  `retry_policy (*type:* `Hash`) - The retry policy. The policy fields
              #     include the following keys:
              #      *  `:initial_delay` (*type:* `Numeric`) - The initial delay in seconds.
              #      *  `:max_delay` (*type:* `Numeric`) - The max delay in seconds.
              #      *  `:multiplier` (*type:* `Numeric`) - The incremental backoff multiplier.
              #      *  `:retry_codes` (*type:* `Array<String>`) - The error codes that should
              #         trigger a retry.
              #
              class Rpcs
                ##
                # RPC-specific configuration for `analyze_sentiment`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :analyze_sentiment
                ##
                # RPC-specific configuration for `analyze_entities`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :analyze_entities
                ##
                # RPC-specific configuration for `analyze_syntax`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :analyze_syntax
                ##
                # RPC-specific configuration for `annotate_text`
                # @return [::Gapic::Config::Method]
                #
                attr_reader :annotate_text

                # @private
                def initialize parent_rpcs = nil
                  analyze_sentiment_config = parent_rpcs.analyze_sentiment if parent_rpcs.respond_to? :analyze_sentiment
                  @analyze_sentiment = ::Gapic::Config::Method.new analyze_sentiment_config
                  analyze_entities_config = parent_rpcs.analyze_entities if parent_rpcs.respond_to? :analyze_entities
                  @analyze_entities = ::Gapic::Config::Method.new analyze_entities_config
                  analyze_syntax_config = parent_rpcs.analyze_syntax if parent_rpcs.respond_to? :analyze_syntax
                  @analyze_syntax = ::Gapic::Config::Method.new analyze_syntax_config
                  annotate_text_config = parent_rpcs.annotate_text if parent_rpcs.respond_to? :annotate_text
                  @annotate_text = ::Gapic::Config::Method.new annotate_text_config

                  yield self if block_given?
                end
              end
            end
          end
        end
      end
    end
  end
end
