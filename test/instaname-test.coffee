chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'instaname', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()

    require('../src/instaname')(@robot)
