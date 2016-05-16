require 'test_helper'

class ApiControllerTest < ActionController::TestCase
	test "funcionamiento correcto api" do
		get(:buscar, {'tag' => 'instachile', 'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'})

		assert_response :success
	end

	test "parametros incorrectos 1" do
		get(:buscar, {'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'})

		assert_response(400, '')
	end

	test "parametros incorrectos 2" do
		get(:buscar, {'tag' => 'instachile'})

		assert_response(400, '')
	end

	#test "respuesta valida de conteo de posts" do
	#	get(:buscar, {'tag' => 'instachile', 'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'})

	#	assert_not_nil(@response.body["metadata"]["total"])
	#end
end
