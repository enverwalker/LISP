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
-- 12. Определите функцию, разбивающую список (a, b, c, d, ...) на пары ((a, b), (c, d), ...).
couples :: [Float] -> [[Float]]
couples [] = []
couples (a:b:tail) = [a, b]:(couples tail)
main = do
print $ (couples [0.1, 1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1])
