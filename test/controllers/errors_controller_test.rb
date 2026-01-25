require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest

  test "should get bad_request" do
    get bad_request_url
    assert_response :success
    assert_select ".error-code", text: "400"
    assert_select ".error-title", text: I18n.t("views.errors.bad_request.title")
  end

  test "should get forbidden" do
    get forbidden_url
    assert_response :success
    assert_select ".error-code", text: "403"
    assert_select ".error-title", text: I18n.t("views.errors.forbidden.title")
  end

  test "should get not_found" do
    get not_found_url
    assert_response :success
    assert_select ".error-code", text: "404"
    assert_select ".error-title", text: I18n.t("views.errors.not_found.title")
  end

  test "should get internal_error" do
    get internal_error_url
    assert_response :success
    assert_select ".error-code", text: "500"
    assert_select ".error-title", text: I18n.t("views.errors.internal_error.title")
  end

end
