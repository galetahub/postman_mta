module PostmanMta
  class Label < ApplicationModel
    attr_reader :conversation_id

    def initialize(conversation_id)
      @conversation_id = conversation_id
    end

    def create(params)
      post("/api/v1/conversations/#{conversation_id}/labels", body: params)
    end

    def destroy(label_id)
      delete("/api/v1/conversations/#{conversation_id}/labels/#{label_id}")
    end
  end
end