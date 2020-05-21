(write-line "")
(write-line "")
(write-line "------------------------------------|-----------------|--------------------------------------")
(write-line "------------------------------------|-- Lisp basics --|--------------------------------------")
(write-line "------------------------------------V-----------------V--------------------------------------")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №1 -------------------------------------------")
;Задача 1
;Определите макрос, который возвращает свой вызов.
;Код:
(defmacro getFunction (&rest x)
    
   `'(getFunction ,x)     
    
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (getFunction 'a 'b 'c))
(print (getFunction 'x 'y 'z)) 
(print (getFunction 'l 'm 'n)) 

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №2 -------------------------------------------")
;Задача 2
;Определите макрос (POP стек), который вычитает из стека верхний элемент и меняет значение переменной стека.
;Код:
(defmacro pop1 (stack)
  `(let ((first (car ,stack)))(setq ,stack (cdr ,stack))first))
(setq stack '(1 2 3 4 5))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print  (pop1 stack))
(print  (pop1 stack))
(print stack)

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №3 -------------------------------------------")
;Задача 3
;Определите лисповскую форму (IF условие p q) в виде макроса.
;Код:
(defmacro if1 (cond p l)
    `(if ,cond ,p ,l)
)
(setq x '(1 2 3))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (if1 (list x) 'True 'False))
(print (if1 (atom x) 'True 'False))
(print (if1 (list x) 'True 'False))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №4 -------------------------------------------")
;Задача 4
;Определите в виде макроса форму (FIF тест отр нуль полож).
;Код:
(defmacro FIF (test n z p)
    `(cond ((< ,test 0) ,n)
           ((> ,test 0) ,p)
           (t ,z)
     )
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (FIF (+ 1 2) 'Negative 'Zero 'Positive))
(print (FIF (- 5 10) 'Negative 'Zero 'Positive))
(print (FIF (* 5 0) 'Negative 'Zero 'Positive))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №5 -------------------------------------------")
;Задача 5
;Определите в виде макроса форму (REPEAT e UNTIL p) паскалевского типа.
;Код:
(defmacro repeat (e p)

    `(cond(,p nil)

          (t(and(print ,e)(repeat ,e ,p)))

     ) 

)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(setq i 0)
(repeat (setq  i (+ i 1)) (equal i 5))
