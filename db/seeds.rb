# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UserGroup.delete_all
UserGroup.create(ident: 'int', name: 'International', has_optin: false)
UserGroup.create(ident: 'ro', name: 'Romania', has_optin: false)
UserGroup.create(ident: 'surgery', name: 'Surgery', has_optin: false)
UserGroup.create(ident: 'orthodontics', name: 'Orthodontics', has_optin: false)
UserGroup.create(ident: 'prosthetics', name: 'Prosthetics', has_optin: false)
UserGroup.create(ident: 'endodontics', name: 'Endodontics', has_optin: false)
UserGroup.create(ident: 'ro.surgery', name: 'Chirurgie', has_optin: false)
UserGroup.create(ident: 'ro.orthodontics', name: 'Ortodontie', has_optin: false)
UserGroup.create(ident: 'ro.prosthetics', name: 'Protetica', has_optin: false)
UserGroup.create(ident: 'ro.endodontics', name: 'Endodontie', has_optin: false)