class Api::TodoItemsController < Api::ApiController
    before_filter :find_todo_list
    
    def create
        item = @list.todo_items.new(item_params)
        if item.save
            render status: 200, json: {
                message: "To-do item created successfully",
                todo_list: @list,
                todo_item: item
            }.to_json
        else
            render status: 500, json: {
                message: "To-do item failed to be created",
                todo_item: item
            }.to_json
        end
    end
    
    def update
        item = @list.todo_items.find(params[:id])
        if item.update(item_params)
            render status: 200, json: {
                message: "To-do item updated successfully",
                todo_list: @list,
                todo_item: item
            }.to_json
        else
            render status: 422, json: {
                message: "Something went wrong",
                todo_list: @list,
                todo_item: item
            }.to_json
        end
    end
    
    def destroy
        item = @list.todo_items.find(params[:id])
        item.destroy
        render status:200, json: {
            message: "To-do item deleted",
            todo_list: @list,
            todo_item: item
        }.to_json
    end
    
    private
    def item_params
        params.require("todo_item").permit("content")
    end
    
    def find_todo_list
        @list = TodoList.find(params[:todo_list_id])
    end
end