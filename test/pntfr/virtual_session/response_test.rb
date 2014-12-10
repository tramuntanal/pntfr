module Pntfr
  class ResponseTest < Minitest::Test
    #
    # Success response
    #
    def test_success_response_should_have_sent_msg_and_no_error
      rs= VirtualSession::SuccessResponse.new
      assert rs.success? and rs.msg_sent?
      refute rs.error?
      refute rs.failure?
      assert_nil rs.error
    end
    #
    # Android response
    #
    def test_gcm_200_responses_with_success_should_have_success_and_no_error
      json= {:body=>"{\"multicast_id\":1020305051281243425,\"success\":1,\"failure\":0,\"canonical_ids\":0,\"results\":[{\"message_id\":\"0:1418221082312345%88882f99f9fd7ecd\"}]}", :headers=>{"content-type"=>["application/json; charset=UTF-8"], "date"=>["Wed, 10 Dec 2014 14:18:02 GMT"], "expires"=>["Wed, 10 Dec 2014 14:18:02 GMT"], "cache-control"=>["private, max-age=0"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["SAMEORIGIN"], "x-xss-protection"=>["1; mode=block"], "server"=>["GSE"], "alternate-protocol"=>["443:quic,p=0.02"], "connection"=>["close"]}, :status_code=>200, :response=>"success", :canonical_ids=>[], :not_registered_ids=>[]}
      rs= VirtualSession::GcmResponse.new(json)
      assert rs.success?
      refute rs.error?
      assert_nil rs.error
    end
    def test_gcm_200_responses_with_invalid_registration_should_have_failed_and_report_error
      json= {:body=>"{\"multicast_id\":6867269885611677069,\"success\":0,\"failure\":1,\"canonical_ids\":0,\"results\":[{\"error\":\"InvalidRegistration\"}]}", :headers=>{"content-type"=>["application/json; charset=UTF-8"], "date"=>["Tue, 09 Dec 2014 21:28:02 GMT"], "expires"=>["Tue, 09 Dec 2014 21:28:02 GMT"], "cache-control"=>["private, max-age=0"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["SAMEORIGIN"], "x-xss-protection"=>["1; mode=block"], "server"=>["GSE"], "alternate-protocol"=>["443:quic,p=0.02"], "connection"=>["close"]}, :status_code=>200, :response=>"success", :canonical_ids=>[], :not_registered_ids=>[]}
      rs= VirtualSession::GcmResponse.new(json)
      refute rs.failure?
      refute rs.msg_sent?
      assert rs.success? and rs.error?
      assert_equal 'InvalidRegistration', rs.error
    end
    def test_gcm_200_responses_with_mismatch_sender_id_should_have_failed_and_report_error
      json= {:body=>"{\"multicast_id\":5372261104801760966,\"success\":0,\"failure\":1,\"canonical_ids\":0,\"results\":[{\"error\":\"MismatchSenderId\"}]}", :headers=>{"content-type"=>["application/json; charset=UTF-8"], "date"=>["Tue, 09 Dec 2014 20:41:01 GMT"], "expires"=>["Tue, 09 Dec 2014 20:41:01 GMT"], "cache-control"=>["private, max-age=0"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["SAMEORIGIN"], "x-xss-protection"=>["1; mode=block"], "server"=>["GSE"], "alternate-protocol"=>["443:quic,p=0.02"], "connection"=>["close"]}, :status_code=>200, :response=>"success", :canonical_ids=>[], :not_registered_ids=>[]}
      rs= VirtualSession::GcmResponse.new(json)
      assert rs.success?
      refute rs.msg_sent?
      assert rs.error?
      refute rs.failure?
      assert_equal 'MismatchSenderId', rs.error
    end
    def test_gcm_400_responses_should_have_failed_and_report_error
      json= {:body=>"\"registration_ids\" field is not a JSON array\n", :headers=>{"content-type"=>["text/plain; charset=UTF-8"], "date"=>["Tue, 09 Dec 2014 21:27:30 GMT"], "expires"=>["Tue, 09 Dec 2014 21:27:30 GMT"], "cache-control"=>["private, max-age=0"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["SAMEORIGIN"], "x-xss-protection"=>["1; mode=block"], "server"=>["GSE"], "alternate-protocol"=>["443:quic,p=0.02"], "connection"=>["close"]}, :status_code=>400, :response=>"Only applies for JSON requests. Indicates that the request could not be parsed as JSON, or it contained invalid fields."}
      rs= VirtualSession::GcmResponse.new(json)
      refute rs.success? and rs.error?
      assert rs.failure?
      expected= "\"registration_ids\" field is not a JSON array\n->Only applies for JSON requests. Indicates that the request could not be parsed as JSON, or it contained invalid fields."
      assert_equal expected, rs.failure
    end
  end
end
