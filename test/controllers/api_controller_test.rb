require 'test_helper'

class ApiControllerTest < ActionController::TestCase
	test "recibir bien los parámetros" do
		get(:buscar, {'tag' => 'instachile', 'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'})

		assert_response :success
    	assert_not_nil assigns(:tag)
    	assert_not_nil assigns(:token)
	end
end
