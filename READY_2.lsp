(write-line "")
(write-line "")
(write-line "------------------------------|-----------------------------|--------------------------------")
(write-line "------------------------------|-- Higher-orders functions --|--------------------------------")
(write-line "------------------------------V-----------------------------V--------------------------------")
(write-line "")
(write-line "")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №1 ------------------------------------------")
;Задача 1
;Определите FUNCALL через функционал APPLY
;Код:
(defun funcall0 (f &rest a)
	(apply f a)
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(funcall0 '+ 12 13 54))
(print(funcall0 '- 12 13 54))
(print(funcall0 '* 12 13 54))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №3 ------------------------------------------")
;Задача 3
;Определите функционал (APL-APPLY f x), который применяет каждую функцию fi списка (f1 f2 ... fn)
;к соответствующему элементу списка x = (x1 x2 ... xn) и возвращает список, сформированный из результатов.
;Код:
(defun aplApply (f x)
	(mapcar 'apply f x)
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (aplApply '(+ - equal) '((10 5) (11 1 3 0) (nil 0))))
(print (aplApply '(+ - equal) '((7 13) (43 4 5) (1 1))))
(print (aplApply '(+ - equal) '((21 9) (3 4 ) (1 -1))))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №5 ------------------------------------------")
;Задача 5
;Определите функциональный предикат (НЕКОТОРЫЙ пред список), который истинен, когда, являющейся функциональным
;аргументом предикат пред истинен хотя бы для одного элемента списка список.
;Код:
(defun anyPredList (func_p args)
		(not (null (mapcan func_p args)))
)
(defun equalityTo1 (val)
    (cond ((eq val 2) (list t)) (t nil))
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (anyPredList `equalityTo1 `(1 3 5)))
(print (anyPredList `equalityTo1 `(1 2 3 4 5 1 2)))
(print (anyPredList `equalityTo1 `(1 2 3 1 2 3)))

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
(write-line "----------------------------------------- Task №9 ------------------------------------------")
;Задача 19
;Напишите генератор порождения чисел Фибоначчи: 0, 1, 1, 2, 3, 5, ...
;Код:
(defun fibNumbers ()
	(let
		((a 0) (b 1) (temp 0))
		(lambda () (and
			(setq temp b)
			(setq b (+ a b))
			(setq a temp)
			temp
		))
	)
)

(setq s1 (fibNumbers))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))
(print (funcall s1))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №11 -----------------------------------------")
;Задача 11
;Определите фукнционал МНОГОФУН, который использует функции, являющиеся аргументами, по следующей схеме:
;(МНОГОФУН ’(f g ... h) x) ⇔ (LIST (f x) (g x) ... (h x)).
;Код:
(defun multiFun (fs x)
  (mapcar (lambda (f) (apply f (list x))) fs))

(defun multiply (x) (* x 100))
(defun add (x) (+ x 100))
(defun divide (x) (/ x 100))
(defun subtract (x) (- x 100))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (multiFun `(multiply add divide) 11))
(print (multiFun `(divide multiply add) 12))
(print (multiFun `(multiply subtract divide) 13))
(print (multiFun `(subtract multiply add) 14))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №13 -----------------------------------------")
;Задача 13
;Определите функцию, которая возвращает в качестве значения свое определение (лямбда-выражение).
;Код:
(defun retMe (&rest args)
    (symbol-function 'retMe))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (retMe))
(print (retMe 'a))
(print (retMe 1 2 3 4 5))
