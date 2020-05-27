<h1 id="introduction">Введение в Haskell</h1>
<h2>Язык программирования Haskell</h2>
<h3> Первая программа на Haskell </h3>
> main = do
> print "What is your name?"
> name <- getLine
> print ("Hello " ++ name ++ "!")
<h3> Определение функций </h3>
<code class="zsh">
    f x y = x + y
</code>
<h3> Пример создания нового типа </h3>
ru: Обычно при написании программ, вы указываете тип функции. Но это не обязательно. Компилятор достаточно умен, чтобы сделать это за вас.
<code class="zsh">
    -- Мы определям тип используя ::
    f :: Int -> Int -> Int
    f x y = x*x + y*y
    main = print (f 2 3)
</code>
<code class="zsh">
    ~ runhaskell <scriptname>.lhs
    13
</code>
<code class="zsh">
    $ ghci <scriptname>.lhs
    GHCi, version 8.6.3: http://www.haskell.org/ghc/ :? for help
    [1 of 1] Compiling Main ( <scriptname>.lhs, interpreted )
    Ok, one module loaded.
    *Main> :type f
    f :: Num a => a -> a -> a
</code>
ru: На самом деле в Haskell-е ни одна функция не принимает на вход два
аргумента. 
ru: Вместо этого у всех функций — только один аргумент.
ru: Функцию от двух аргументов можно представить как функцию, принимающую первый аргумент и возвращающую функцию, принимающую второй аргумент в качестве параметра.
<code class="zsh">
    > g = f 3
    > g 7
    10
</code>
ru: Для создания функции можно использовать и лямбда-выражение:
<code class="zsh">
    > g = \y -> y * y
    > g 5
    25
</code>
<h3> Списки </h3>
<code class="zsh">
[ ] -- пустой список
[1, 2, 3] -- список целых чисел
[ ”foo”, ”bar”, ”baz” ] -- список строк (String)
1:[2, 3] [1, 2, 3], (:) -- присоединяет один элемент
1:2:[] -- [1, 2]
[1, 2] ++ [3, 4] -- [1, 2, 3, 4], (++) склеивает списки
[1, 2, 3] ++ [ ”foo” ]--  ОШИБКА String 6= Integral
[1..4] -- [1, 2, 3, 4]
[1, 3..10] -- [1, 3, 5, 7, 9]
[2, 3, 5, 8, 12..100] -- ОШИБКА! компилятор не настолько умен!
[10, 9..1] -- [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
</code>
<h3>Кортежи</h3>
ru: Задать пару можно следующим образом (a, b). Элементы кортежа могут
иметь различные типы.
<code class="zsh">
    -- Все эти кортежи - валидны
    (2, "foo")
    (3, 'a', [2, 3])
    ((2, "a"), "c", 3)
    fst (x, y) => x
    snd (x, y) => y
    fst (x, y, z) => ERROR: fst :: (a, b) -> a
    snd (x, y, z) => ERROR: snd :: (a, b) -> b
</code>
<h3>Скобки</h3>
ru: Чтобы избавиться от лишних скобок, вы можете воспользоваться этими
функциями: ($) и (.).
<code class="zsh">
    -- По умолчанию:
    f g h x < = > (((f g) h) x)
    -- $ заменяет скобки от $
    -- до конца выражения
    f g $ h x < = > f g (h x) < = > (f g) (h x)
    f $ g h x < = > f (g h x) < = > f ((g h) x)
    f $ g $ h x < = > f (g (h x))
    -- (.) композиция функций
    (f . g) x < = > f (g x)
    (f . g . h) x < = > f (g (h x))
</code>
ru: Объявлять тип функции перед ее определеним необязательно. 
ru: Haskell сам выведет наиболее общий тип. 
ru: Но указание типа функции — правило хорошего тона.
<h3>Полезные вещи для записи функций</h3>
<code class="zsh">
    x :: Int            ⇔ x is of type Int
    x :: a              ⇔ x can be of any type
    x :: Num a => a     ⇔ x can be any type a
                          such that a belongs to Num type class 
    f :: a -> b         ⇔ f is a function from a to b
    f :: a -> b -> c    ⇔ f is a function from a to (b→c)
    f :: (a -> b) -> c  ⇔ f is a function from (a→b) to c
</code>
Объявлять тип функции перед ее определеним необязательно. Haskell сам
выведет наиболее общий тип. Но указание типа функции — правило хорошего
тона.
<h3>Инфиксная запись</h3>
<code class="zsh">
    square :: Num a => a -> a
    square x = x^2
</code>
ru: Обратите внимание, что ˆ используется в инфиксной нотации. 
ru: Для каждого инфиксного оператора существует возможность префиксной записи. ru: Просто нужно заключить нужный оператор в скобки.
<code class="zsh">
    square' x = (^) x 2
    
    square'' x = (^2) x
</code>
ru: Мы можем убрать x из левой и правой части выражения! Это называется η-редукция.
<code class="zsh">
    square''' = (^2)
</code>
<h3>Функции высших порядков</h3>
<code class="zsh">
    filter :: (a -> Bool) -> [a] -> [a]
    map :: (a -> b) -> [a] -> [b]
    foldl :: (a -> b -> a) -> a -> [b] -> a
</code>
<code class="zsh">
    evenSum l = mysum 0 (filter even l)
        where
          mysum n [] = n
          mysum n (x:xs) = mysum (n+x) xs
</code>
ru: где
<code class="zsh">
    filter even [1..10] ⇔  [2,4,6,8,10]
</code>
ru: Следующим нашим действием будет упрощение цикла. 
ru: Для этого воспользуемся функцией foldl, которая позволяет аккумулировать значение:
<code class="zsh">
    myfunc list = foo initialValue list
    foo accumulated []     = accumulated
    foo tmpValue    (x:xs) = foo (bar tmpValue x) xs
</code>
ru: Код выше можно заменить на:
<code class="zsh">
    myfunc list = foldl bar initialValue list
</code>
ru: Код foldl приведен ниже:
<code class="zsh">
    foldl f z [] = z
    foldl f z (x:xs) = foldl f (f z x) xs
</code>
<code class="zsh">
    foldl f z [x1,...xn]  ⇔  f (... (f (f z x1) x2) ...) xn
</code>
<code class="zsh">
    evenSum l = foldl' mysum 0 (filter even l)
        where mysum acc value = acc + value
</code>
ru: Этот код можно упростить, используя лямбда-выражение. 
ru: Таким образом, мы избавимся от временного идентификатора mysum.
<code class="zsh">
    evenSum l = foldl' (\x y -> x+y) 0 (filter even l)
</code>
ru: И конечно, можно провести следующую замену
<code class="zsh">
    (\x y -> x+y) ⇔ (+)
</code>
<code class="zsh">
    evenSum :: Integral a => [a] -> a
    evenSum l = foldl (+) 0 (filter even l)
</code>
ru: Другая полезная функция высшего порядка это (.). 
ru: Функция (.) соответствует математической композиции.
<code class="zsh">
    (f . g . h) x < = > f ( g (h x))
</code>
ru: Мы можем ее использовать, чтобы еще дальше η-редуцировать нашу функцию:
<code class="zsh">
    import Data.List (foldl')
    evenSum :: Integral a => [a] -> a
    evenSum = (foldl' (+) 0) . (filter even)
</code>
ru: Можно еще так:
<code class="zsh">
    import Data.List (foldl')
    sum' :: (Num a) => [a] -> a
    sum' = foldl' (+) 0
    evenSum :: Integral a => [a] -> a
    evenSum = sum' . (filter even)
</code>
ru: Теперь напишем сумму квадратов
<code class="zsh">
    squareEvenSum = sum' . (filter even) . (map (^2))
    squareEvenSum' = evenSum . (map (^2))
    squareEvenSum'' = sum' . (map (^2)) . (filter even)
    squareEvenSum [1..10]  < = >  220
</code>
ru: Функция map просто применяет функцию-параметр ко всем элементам списка.
<code class="zsh">
    map (^2) [1..4] < = > [1, 4, 9, 16]
</code>
