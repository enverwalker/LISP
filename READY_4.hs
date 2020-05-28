--14. Определите функцию, вычисляющую глубину списка (самой глубокой ветви).
listDepth :: [[Float]] -> [Float]
listDepth [] = []
listDepth ([x]) = x
listDepth (x:xs) = listDepth xs
main =do
  putStrLn "Тесты к задаче №29"
  print(listDepth [[1, 2, 3], [1, 2, 3, 4], [1, 2, 3, 4, 5]])
  print(listDepth [])
  print(listDepth [[9]])
