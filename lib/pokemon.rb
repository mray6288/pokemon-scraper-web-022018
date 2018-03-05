class Pokemon
	attr_accessor :name, :id, :type, :db, :hp

	def initialize(args)
		args.each {|key, value| self.send("#{key}=", value)}
	end


	def self.save(name, type, hp=60, db)
		sql = <<-SQL
			insert into pokemon (name, type, hp) values (?, ?, ?)
		SQL

		db.execute(sql, name, type, hp)
	end

	def self.find(id, db)
		sql = <<-SQL
			select * from pokemon
			where id = ?
		SQL

		args = db.execute(sql, id)[0]
		Pokemon.new(id:args[0], name:args[1], type:args[2], hp:args[3], db:db)
	end


	def alter_hp(new_hp, db)
		db.execute("update pokemon set hp = ? where id = ?", new_hp, self.id)
	end
end
