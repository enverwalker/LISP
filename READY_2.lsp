(write-line "")
(write-line "")
(write-line "------------------------------|-----------------------------|--------------------------------")
(write-line "------------------------------|-- Higher-orders functions --|--------------------------------")
(write-line "------------------------------V-----------------------------V--------------------------------")
(write-line "")
(write-line "")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №7 ------------------------------------------")
;Задача 7
;Определите фильтр (УДАЛИТЬ-ЕСЛИ-НЕ пред список), удаляющий из списка список все элементы,
;которые не обладают свойством, наличие которого проверяет предикат пред.
;Код:
(defun delIfNo (pred lst)
	(mapcan pred lst)
)
(setq a 10)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(delIfNo 'atom '((1 5) (7 3) 9)))
(print(delIfNo 'numberp '(x y)))
(print(delIfNo 'boundp '(a)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №13 -----------------------------------------")
;Задача 13
;Определите функцию, которая возвращает в качестве значения свое определение (лямбда-выражение).
;Код:
(setq retMe '( (lambda (x)
		(list x (list (quote quote) x)))
 		(quote (lambda (x)
 		(list x (list (quote quote) x))))))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(eval retMe))
(print(eval(eval retMe)))
(print(eval(eval (eval retMe))))
