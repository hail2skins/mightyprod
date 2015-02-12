# When testing, make sure your owner has an id otherwise a nil foreign key will match on new records.
    # ability.rb - only update/destroy records you own
    # cannot [:update, :destroy], Note 
    # can [:update, :destroy], Note, owner_id: owner.id
    # ability_spec.rb
    # owner.new.should_not have_ability([:update, :destroy], for: Note.new
    # will fail since note.owner_id(nil) = owner.id(nil) even though owner is not the owner

    # e.g.:
    # @owner.should have_ability(:create, for: Post.new)
    # @owner.should have_ability([:create, :read], for: Post.new)
    # @owner.should have_ability({create: true, read: false, update: false, destroy: true}, for: Post.new)
    RSpec::Matchers.define :have_ability do |ability_hash, options = {}|
      match do |owner|
        ability         = Ability.new(owner)
        target          = options[:for]
        @ability_result = {}
        ability_hash    = {ability_hash => true} if ability_hash.is_a? Symbol # e.g.: :create => {:create => true}
        ability_hash    = ability_hash.inject({}){|_, i| _.merge({i=>true}) } if ability_hash.is_a? Array # e.g.: [:create, :read] => {:create=>true, :read=>true}
        ability_hash.each do |action, true_or_false|
          @ability_result[action] = ability.can?(action, target)
        end
        ability_hash == @ability_result
      end

      failure_message_for_should do |owner|
        ability_hash,options = expected
        ability_hash         = {ability_hash => true} if ability_hash.is_a? Symbol # e.g.: :create
        ability_hash         = ability_hash.inject({}){|_, i| _.merge({i=>true}) } if ability_hash.is_a? Array # e.g.: [:create, :read] => {:create=>true, :read=>true}
        target               = options[:for]
        message              = "expected owner:#{owner} to have ability:#{ability_hash} for #{target}, but actual result is #{@ability_result}"
      end

      #to clean up output of RSpec Documentation format
      description do
        target = expected.last[:for]
        target = if target.class == Symbol
          target.to_s.capitalize
        elsif target.class == Class || target.class == Module
          target.to_s.capitalize
        else
          target.class.name
        end
        authorized_abilities   = ability_hash.select{|key, val| val == true}
        authorized_string      = "authorized to #{authorized_abilities.keys.join(", ")}"
        unauthorized_abilities = ability_hash.select{|key, val| val == false}
        unauthorized_string    = "unauthorized to #{unauthorized_abilities.keys.join(", ")}"
        "be #{authorized_string unless authorized_abilities.empty?}" \
        "#{' and ' unless authorized_abilities.empty? || unauthorized_abilities.empty?}" \
        "#{unauthorized_string unless unauthorized_abilities.empty?}" \
        " for #{target}"
      end
    end