define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class ParserOptionView extends Backbone.View
      className: "form-group"

      events:
        "change input.multiselect-option": "change_multiselect_option"

      change_multiselect_option: (event)=>
        option_key = $(event.target).val()
        @model.set_value option_key if @model.get_value() != $(event.target).prop('checked')

      # 初期化
      initialize: ->
        @init_model_events()

      init_model_events: ->
        @update()
        @model.on "change", =>
          @update()

      # モデルが更新されたときの処理
      # @return [ParserOptionView] void
      update: ->
        switch @model.get "type"
          when "text"
            @update_text()
          when "select"
            @update_select()
          when "multiselect"
            @update_multiselect()
          when "flag"
            @update_flag()
          when "hidden"
            @update_hidden()
          else
            throw new Error "ERROR_B90Z1Q: Unknown Parser Option Type"

      # type=textでモデルが更新されたときの処理
      # @return [ParserOptionView] void
      update_text: ->
        # type=text
        input_tag = @$el.find(".input-text")
        model_value = @model.get_value()
        # モデルとDOMの値が異なるときはDOMの値を設定しなおし
        # changeイベントを発火させる
        input_tag.val(model_value).trigger("change") unless model_value == input_tag.val()

      # type=selectでモデルが更新されたときの処理
      # @return [ParserOptionView] void
      update_select: ->
        # type=select
        select_tag = @$el.find(".select-option")
        select_tag.empty()
        # optionタグを追加していく
        _(@model.get "options").each (option)->
          select_tag.append "<option value=\"#{option}\">#{option}</option>"
        model_value = @model.get_value()
        # 新しく追加されたときは最初の要素を選択しておく
        unless model_value && @model.get("options").length
          model_value = @model.get("options")[0]
        select_tag.val(model_value).trigger("change") unless model_value == select_tag.val()
        select_tag.val(model_value).trigger("change") unless !! select_tag.val()
        @

      # type=multiselectでモデルが更新されたときの処理
      # @return [ParserOptionView] void
      update_multiselect: ->
        # type=multiselect
        multiselect = @$el.find '.multiselect'
        multiselect.empty()
        select_id_list = @model.get "select_id_list"
        _(@model.get "options").each (option, index_of_option)=>
          multiselect_option_tag = undefined
          if _(select_id_list).include index_of_option
            multiselect_option_tag = $ '<div class="checkbox"><label><input value="' + option + '" checked="checked" type="checkbox" class="multiselect-option">' + option + '</label></div>'
          else
            multiselect_option_tag = $ '<div class="checkbox"><label><input value="' + option + '" type="checkbox" class="multiselect-option">' + option + '</label></div>'
          multiselect.append multiselect_option_tag

      # type=flagでモデルが更新されたときの処理
      # @return [ParserOptionView] void
      update_flag: ->
        # type=flag
        checkbox = @$el.find('.flag')
        model_value = @model.get_value()
        checkbox.prop 'checked', model_value unless checkbox.prop('checked') == model_value

      # type=flagでモデルが更新されたときの処理
      # @return [ParserOptionView] void
      update_hidden: ->
        # type=hidden
        input_tag = @$el.find(".input-text")
        model_value = @model.get_value()
        # モデルとDOMの値が異なるときはDOMの値を設定しなおし
        # changeイベントを発火させる
        input_tag.val(model_value).trigger("change") unless model_value == input_tag.val()

      # DOMの描画
      render: ->
        @$el.empty()
        switch @model.get "type"
          when "text"
            @render_text()
          when "select"
            @render_select()
          when "multiselect"
            @render_multiselect()
          when "flag"
            @render_flag()
          when "hidden"
            @render_hidden()
          else
            throw new Error "ERROR_EHRPOZ: Unknown Parser Option Type: #{@model.get "type"}"
        @update()
        @

      # type=textに関するDOMの描画
      # @return [ParserOptionView] void
      render_text: ->
        # type=text
        input_tag = $ '<input type="text" class="input-text form-control">'
        @$el.append input_tag
        input_tag.on "change", =>
          @model.set_value input_tag.val()
        @

      # type=selectに関するDOMの描画
      # @return [ParserOptionView] void
      render_select: ->
        # type=select
        select_tag = $ '<select class="select-option form-control"></select>'
        select_tag.on "change", =>
          if select_tag.val()
            @model.set_value select_tag.val() unless select_tag.val() == @model.get_value()
        @$el.append select_tag
        @

      # type=multiselectに関するDOMの描画
      # @return [ParserOptionView] void
      render_multiselect: ->
        # type=multiselect
        multiselect = $ '<div class="multiselect"></div>'
        @$el.append multiselect
        @

      # type=flagに関するDOMの描画
      # @return [ParserOptionView] void
      render_flag: ->
        checkbox = $ '<div class="checkbox"><label><input type="checkbox" value="' + @model.get('name') + '" class="flag">' + @model.get('name') + '</label></div>'
        checkbox.on "change", =>
          @model.set_value checkbox.find('.flag').prop('checked')
        @$el.append checkbox
        @

      # type=hiddenに関するDOMの描画
      # @return [ParserOptionView] void
      render_hidden: ->
        # type=hidden
        input_tag = $ '<input type="hidden" class="input-text">'
        @$el.append input_tag
        input_tag.on "change", =>
          @model.set_value input_tag.val()
        @

)
