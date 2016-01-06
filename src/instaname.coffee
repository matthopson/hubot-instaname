# Description:
#   Set your Instagram user and query others.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot set instagram @instagram_user - Sets your user's Instagram name.
#   hubot who the hell is @user - Returns a chat user's Instagram name.
#
# Notes:
#   It's pretty awesome. Try not to weep at its brilliance.
#
# Author:
#   matthopson

module.exports = (robot) ->

  # Searches users by id or name
  findUser = (search) ->
    foundUser = null

    if typeof search is 'number'
      searchProp = 'id'
    else
      searchProp = 'name'
    for index, user of robot.brain.data.users
      if user[searchProp].toLowerCase() == search.toLowerCase()
        foundUser = user
        break

    return foundUser


  # Sets a user's instagram
  robot.respond /set instagram(?: to)?(.*)/i, (res) ->
    instagram = res.match[1].trim()

    if instagram.charAt(0) is '@'
      instagram = instagram.substr 1
    myUser = res.message.user
    myUser.instagram = instagram

    res.reply "Your Instagram name has been set to `@#{instagram}`."


  # Retrieve instagram name for a given user.
  robot.respond /who(?:\s\w*)*?is\s*@?([a-zA-Z._\-0-9]*)/i, (res) ->
    userName = res.match[1].trim()
    if userName.charAt(0) is '@'
      userName = userName.substr 1

    user = findUser userName
    unless user?
      res.reply "I'm sorry, I could not find this user: `@#{userName}`"
    else
      instagram = user.instagram

      if instagram?
        res.reply "#{user.name} is the famous `@#{instagram}` on Instagram. Check 'em out at https://www.instagram.com/#{instagram}/"
      else
        res.reply "I don't know of any Instagram account for #{user.name}.
        Perhaps you could remind them to set it up?"


  # Retr all instagram users
  robot.respond /list instagrams/i, (res) ->
    instagrams = []

    for index, user of robot.brain.data.users
      if user.instagram?
        instagrams.push "`#{user.name}` is @#{user.instagram} on Instagram."

    if instagrams.length > 0
      instagramList = instagrams.join('\n')
      res.reply "Here are all the Instagrams I know about:\n\n#{instagramList}"
    else
      res.reply "I'm sorry, I don't know of any Instagrams here."
