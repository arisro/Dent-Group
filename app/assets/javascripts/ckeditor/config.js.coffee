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
        true