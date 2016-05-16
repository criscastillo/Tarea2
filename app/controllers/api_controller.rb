require 'pg'
require 'rest-client'
require 'json'

class ApiController < ApplicationController

	skip_before_filter  :verify_authenticity_token

	$url = 'http://api.instagram.com/v1/tags/'
	$version = '1.0.0'

	def cantidadPosts(tag, token)
		respuesta = JSON.parse(RestClient.get $url + tag + '?access_token=' + token)
		puts 'api tag instagram: ' + respuesta.to_s

		total = respuesta["data"]["media_count"]
		puts 'total posts: ' + total.to_s

		return total
	end

	def obtenerPosts(tag, token)
		respuesta = RestClient.get $url + tag + '/media/recent?access_token=' + token
		posts = JSON.parse(respuesta)["data"]

		return posts
	end

	def informacionPosts(posts)
		cantidad = posts.length
		respuesta = Array.new(cantidad)

		i = 0
		while i < cantidad do
			info = {:tags => posts[i]["tags"],
				:username => posts[i]["user"]["username"],
				:likes => posts[i]["likes"]["count"],
				:url => posts[i]["images"]["standard_resolution"]["url"],
				:caption => posts[i]["caption"]["text"]
				}

			respuesta[i] = info

			i += 1
		end

		puts respuesta.to_s

		return respuesta
	end

	#tdi-tarea2.herokuapp.com/api/instagram/tag/buscar
	def buscar
		tag = params[:tag].to_s
		puts 'tag: ' + tag
		token = params[:access_token].to_s
		puts 'token: ' + token

		final = {:metadata =>  {:total => cantidadPosts(tag, token)},
			:posts => informacionPosts(obtenerPosts(tag, token)),
			:version => $version}

		puts 'respuesta de la api: ' + final.to_s

		render json: final.to_json, status: 200

		#excepciones
		rescue Exception => e
			render json: {}, status: 500
	end

end
