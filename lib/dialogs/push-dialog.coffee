Dialog = require './dialog'
git = require '../git'

module.exports =
class PushDialog extends Dialog
  @content: ->
    @div class: 'dialog', =>
      @div class: 'heading', =>
        @i class: 'icon x clickable',click: 'cancel'
        @strong 'Push'
      @div class: 'body', =>
        @label 'Push from branch'
        @input class: 'native-key-bindings',readonly: true,outlet: 'fromBranch'
        @label 'To branch'
        @select class: 'native-key-bindings',outlet: 'toBranch'
      @div class: 'buttons', =>
        @button class: 'active', click: 'push', =>
          @i class: 'icon push'
          @span 'Push'
        @button click: 'cancel', =>
          @i class: 'icon x'
          @span 'Cancel'

  activate: (remotes) ->
    @fromBranch.val(git.getLocalBranch())
    for remote in remotes
      @toBranch.append "<option value='#{remote}'>#{remote}</option>"
    return super()

  push: ->
    @deactivate()
    remote = @toBranch.val().split('/')[0]
    branch = @toBranch.val().split('/')[1]
    git.push(remote,branch)
    return
