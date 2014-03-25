define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class ParserOptionView extends Backbone.View
      className: "form-group"

      # 初期化
      initialize: ->
        @init_model_events()

      init_model_events: ->
        @model.on "change", =>
          @update()

      update: ->
        switch @model.get "type"
          when "text"
            # type=text
            input_tag = @$el.find(".input-text")
            model_value = @model.get_value()
            # モデルとDOMの値が異なるときはDOMの値を設定しなおし
            # changeイベントを発火させる
            input_tag.val(model_value).trigger("change") unless model_value == input_tag.val()
          when "select"
            # type=select
            select_tag = @$el.find(".select-option")
            select_tag.empty()
            _(@model.get "options").each (option)->
              select_tag.append "<option value=\"#{option}\">#{option}</option>"
            model_value = @model.get_value()
            select_tag.val(model_value).trigger("change") unless model_value == select_tag.val()
          when "multiselect"
            # type=multiselect
            multiselect = @$el.find '.multiselect'
            multiselect.empty()
            select_id_list = @model.get "select_id_list"
            _(@model.get "options").each (option, index_of_option)=>
              multiselect_option_tag = undefined
              if _(select_id_list).include index_of_option
                multiselect_option_tag = $ '<div class="checkbox"><label><input value="' + option + '" checked="checked" type="checkbox" class="multiselect-option checkbox">' + option + '</label></div>'
              else
                multiselect_option_tag = $ '<div class="checkbox"><label><input value="' + option + '" type="checkbox" class="multiselect-option checkbox">' + option + '</label></div>'
              multiselect_option_tag.on "change", =>
                multiselect_option_tag.find('input:checked').each (k, element)=>
                  @model.set_value $(element).val()
              multiselect.append multiselect_option_tag
          when "flag"
            # type=flag
            checkbox = @$el.find('.flag')
            model_value = @model.get_value()
            checkbox.prop 'checked', model_value unless checkbox.prop('checked') == model_value
          when "hidden"
            # type=hidden
            input_tag = @$el.find(".input-text")
            model_value = @model.get_value()
            # モデルとDOMの値が異なるときはDOMの値を設定しなおし
            # changeイベントを発火させる
            input_tag.val(model_value).trigger("change") unless model_value == input_tag.val()
          else
            throw new Error "ERROR_B90Z1Q: Unknown Parser Option Type"

      # DOMの描画
      render: ->
        @$el.empty()
        switch @model.get "type"
          when "text"
            # type=text
            input_tag = $ '<input type="text" class="input-text form-control">'
            @$el.append input_tag
            input_tag.on "change", =>
              @model.set_value input_tag.val()
          when "select"
            # type=select
            select_tag = $ '<select class="select-option form-control"></select>'
            select_tag.on "change", =>
              @model.set_value select_tag.val() if select_tag.val()
            @$el.append select_tag
          when "multiselect"
            # type=multiselect
            multiselect = $ '<div class="multiselect"></div>'
            @$el.append multiselect
          when "flag"
            checkbox = $ '<div class="checkbox"><label><input type="checkbox" value="' + @model.get('name') + '" class="flag checkbox">' + @model.get('name') + '</label></div>'
            checkbox.on "change", =>
              @model.set_value checkbox.find('.flag').prop('checked')
            @$el.append checkbox
          when "hidden"
            # type=hidden
            input_tag = $ '<input type="hidden" class="input-text">'
            @$el.append input_tag
            input_tag.on "change", =>
              @model.set_value input_tag.val()
          else
            throw new Error "ERROR_EHRPOZ: Unknown Parser Option Type: #{@model.get "type"}"
        @update()
        @
)
