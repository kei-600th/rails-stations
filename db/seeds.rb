# db/seeds.rb

# screenレコードの作成
3.times do |i|
  Screen.create!(id: i + 1)
end

# sheetレコードの作成
['a', 'b', 'c'].each do |row|
  (1..5).each do |column|
    Sheet.create!(column: column, row: row)
  end
end

# screen_sheetレコードの作成
Screen.all.each do |screen|
  Sheet.all.each do |sheet|
    ScreenSheet.create!(screen: screen, sheet: sheet)
  end
end

3.times do |i|
  Cinema.create!(id: i + 1,name:"劇場#{i + 1}号館")
end
