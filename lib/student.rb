require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id 

  def initialize(id = nil, name, grade) 
    self.id = id
    self.name = name
    self.grade = grade
    self 
  end 
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
      id INTEGER PRIMARY KEY
      name TEXT 
      grade INTEGER)
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students   
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def save
    if self.id
    self.update
  else
    sql = <<-SQL
    INSERT INTO students(name, grade)
    VALUES(?, ?)
    SQL
  end 
  
    DB[:conn].execute(sql, self.name, self.grade)
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end 

  def self.create(name, grade)
    student = self.new(name, grade)
    student.save
    student 
  end 
  
  def self.new_from_db(db)
    student = self.new(db[0], db[1], db[3])
    student 
  end 
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL
    
    result = DB[:conn].execute(sql, name)[0]
    self.new(result[0], result[1], result[2])
  end 
  
  def update
    sql = <<-SQL 
      UPDATE 
    SQL
  end 
end
