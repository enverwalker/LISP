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
(defun isMember (lst elem)
    (cond 
        ((null (mapcan (lambda(x) (list (eq elem x))) lst)) nil)
        (t t)
    )
)
(defun isHasProperty-p (x) 
    (isMember (symbol-plist x) 'p)
)
(defun delIfNo (pred lst)
    (mapcan (lambda(x)
                   (cond
                       ((funcall pred x) (list x))
                       (t nil)
                   )
            ) lst)
)
(setf (get 'A 'p) t)
(setf (get 'B 'p) t)
(setf (get 'C 'p) t)
(setf (get 'D 'p) nil)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (delIfNo 'isHasProperty-p '(A H B E C G D F)))
(print (delIfNo 'isHasProperty-p '(S W T Y G H)))
(print (delIfNo 'isHasProperty-p '(V L S K B C R D)))

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
