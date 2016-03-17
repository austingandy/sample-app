require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
    test "invalid sign up info" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, user: { name: "",
                                    email: "user@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
        end
        assert_template 'users/new'
    end

    test "valid sign up info" do
        get signup_path
        assert_difference 'User.count', 1 do
            post_via_redirect users_path,
                            user: { name: "Austin Gandy",
                                    email: "austin.gandy@berkeley.edu",
                                    password: "something",
                                    password_confirmation: "something" }
        end
        assert_template 'users/show'
    end
end
