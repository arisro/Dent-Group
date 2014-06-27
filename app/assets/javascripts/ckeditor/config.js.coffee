$(document).ready ->
    CKEDITOR.editorConfig = (config) ->
        config.language = 'en'
        config.filebrowserImageBrowseUrl = '/ckeditor/pictures'
        config.filebrowserImageUploadUrl = '/ckeditor/pictures'
        config.toolbar_Pure = [
            { name: 'document', items: [ 'Maximize', '-', 'Source','-','Preview','Print'] },
            { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
            { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
            { name: 'insert', items: [ 'Image', 'Youtube', 'Flash', 'Table', 'HorizontalRule', 'SpecialChar' ] },
            '/',
            { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'FontSize', 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
            { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
        ]
        config.toolbar = 'Pure'
        config.extraPlugins = 'youtube'


        config.filebrowserParams = ->
          metas = document.getElementsByTagName('meta')
          params = new Object()
         
          arr = Array.prototype.slice.call(metas)
          for meta in arr
            switch meta.name
              when "csrf-token"
                csrf_token = meta.content
              when "csrf-param"
                csrf_param = meta.content
          
          if csrf_param != undefined && csrf_token != undefined
            params[csrf_param] = csrf_token
          return params
          
        config.addQueryString = (url, params) ->
          queryString = []
          
          if !params
            return url
          else
            for i of params
              queryString.push( i + "=" + encodeURIComponent(params[i]) )

          if url.indexOf("?") != -1
            url = url + "&"
          else
            url = url + "?"
          return url + queryString.join( "&" )
      
        CKEDITOR.on  'dialogDefinition', (ev) ->
            dialogName = ev.data.name
            dialogDefinition = ev.data.definition
        
            if CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1
              content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'))
              upload = content
              if upload != null
                upload = content.get('upload')
            
              if upload && upload.filebrowser && upload.filebrowser['params'] == undefined
                upload.filebrowser['params'] = config.filebrowserParams()
                upload.action = config.addQueryString(upload.action, upload.filebrowser['params'])
            true

        true