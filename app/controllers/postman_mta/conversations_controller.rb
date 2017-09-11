module PostmanMta
  class ConversationsController < ApplicationController
    def index
      render json: conversation.index(permitted_params).as_json
    end

    [:inbox, :sent, :spam, :trash].each do |folder|
      define_method folder do
        render conversation.folder(folder, permitted_params)
      end
    end

    def show
      render conversation.find(params[:id])
    end

    def read
      render conversation.mark_as_read(permitted_params)
    end

    def destroy
      render conversation.move_to_trash(params[:id])
    end

    private

    def conversation
      @conversation ||= PostmanMta::Conversation.new
    end

    def permitted_params
      params.permit!
    end
  end
end
