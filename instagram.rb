# A liquid tag for Jekyll to embed Instagram photos.
# OKUMURA Takahiro <hfm.garden@gmail.com>
#
# Usage:
#   {% instagram hash %}
# Params:
#   hash: When a short link has instagram.com/p/abcdefghij, a hash is abcdefghij
# access_token:
#   This file includes only your access_token for instagram.
#   see http://instagram.com/developer/authentication

require 'instagram'

module Jekyll
  class InstagramEmbedTag < Liquid::Tag
    def initialize(tag_name, hash, token)
      super
      @hash             = hash.strip
      access_token_file = File.expand_path('.instagram/access_token', File.dirname(__FILE__))
      @access_token     = File.open(access_token_file).gets.strip
    end

    def render(context)
      embed_code
    end

    def embed_code
      oembed.html
    end

    def oembed
      client.oembed("instagram.com/p/#{@hash}")
    end

    def client
      Instagram.client(access_token: @access_token)
    end
  end
end

Liquid::Template.register_tag("instagram", Jekyll::InstagramEmbedTag)
