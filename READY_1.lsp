(write-line "")
(write-line "")
(write-line "------------------------------------|-----------------|--------------------------------------")
(write-line "------------------------------------|-- Lisp basics --|--------------------------------------")
(write-line "------------------------------------V-----------------V--------------------------------------")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №16 ------------------------------------------")
;Задача 16
;Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.
;Код:
  (defun AddInList (list additionalList index) 
    ((lambda (head tail) 
      (cond ((equal 0 index) (cons additionalList list))
        (t (cons head (AddInList tail additionalList (- index 1))))
        )
      )
      (car list)
      (cdr list)
    )
  )

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 0))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №17 ------------------------------------------")
;Задача 17
;Создайте предикат, порождающий всевозможные перестановки исходного множества
;Код:
(defun insert (a b c)
  (cond ((null c) (list (append b (list a))))
     (t (cons (append b (list a) c) (insert a (append b (list (car c))) (cdr c))))))
(defun rotate (lst)
  (cond ((null (cdr lst)) (list lst))
     (t (apply 'append (mapcar (lambda (x) (insert (car lst) nil x)) (rotate (cdr lst)))))))
(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(rotate '(k l)))
(print(rotate '(k l m)))
(print(rotate '(k l m n)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №35 ------------------------------------------")
;Задача 35
;1. Определите функцию ПОДМНОЖЕСТВО, которая проверяет, является ли одно множество подмножеством другого.
;Код:
(defun my-member (a li)
	(cond ((null li) nil) ((equal a (car li)) T)
		(t (my-member a (cdr li)))
	)
)
(defun subset (a b)
	(not (mapcan (lambda (el)
		(cond ((not (my-member el b)) (list T)))
                )
        a)
	)
)

(write-line "")
(write-line "Part 1. Test-cases:")

;Тесты:
(print (subset '(1 2 3) '(5 7 8)))
(print (subset '(8 4 2) '(6 3 4 7 2 8)))
(print (subset '(3 6 5 7) '(3)))

(write-line "")

;2. Определите также СОБСТВЕННОЕ-ПОДМНОЖЕСТВО.
;Код:
(defun proper-subset (a b)
    (and (subset a b) (not (equal a b)))
)

(write-line "")
(write-line "Part 2. Test-cases:")

;Тесты:
(print (proper-subset '(1 2 3) '(1 2 3)))
(print (proper-subset '(1 2 3) '(1 2 3 4 5 6 7 8)))
(print (proper-subset '(0 5 7 7) '(1 2 3 4 5 0 7 5 7)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №36 ------------------------------------------")
;Задача 36
;Определите предикат НЕПЕРЕСЕКАЮЩИЕСЯ, проверяющий, что 2 множества не пересекаются, т.е. у них нет
;общих элементов.
;Код:

(defun my-member (a li)
	(cond
		((null li) nil)
		((equal a (car li)) T)
		(t (my-member a (cdr li)))
	)
)
(defun disjoint (a b)
	(not (mapcan (lambda (el)
			(cond 
				((my-member el b) (list T))
	     		)) a) 
	)
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (disjoint '(1 2 3) '(4 5 6)))
(print (disjoint '(2 5 9 1) '(1 6 4 5)))
(print (disjoint '(1 2 3) '(1 2 3)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №38 ------------------------------------------")
;Задача 38
;Определите функцию ОБЪЕДИНЕНИЕ, формирующую объединение двух множеств.
;Код:

(defun in-predicate (a l)
    (cond
        ((null l) nil) ;элемент не может принадлежать пустому множеству
        ((eq a (car l)) t) ;элемент принадлежит множеству, если в нём содержится
        (t (in-predicate a (cdr l))) ; продолжаем проверку
    )
)
(defun union~ (a b)
    (cond ((null a) b)  
        ((null b) a)
        ((in-predicate (car a) b) (union~ (cdr a) b)) ;проверяем принадлежит ли a к b, если нет, то идём дальше
        (t (cons (car a) (union~ (cdr a) b)))
    )
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (union~ '(a b c) '(b c d)))
(print (union~ '(1 2 3 4 5) '(1 2 3 4 12 13 11)))
(print (union~ '() '()))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №46 ------------------------------------------")
;Задача 46  
;Предположим, что отец и мать некоторого лица, хранятся как значения соответствующих свойств у символа,
;обозначающего это лицо. Напишите функцию (РОДИТЕЛИ x), которая возвращает в качестве значения родителей,
;и предикат (СЕСТРЫ-БРАТЬЯ x1 x2), который истинен в случае, если x1 и x2 — сестры или братья, родные или
;с одним общим родителем.
;Код:

(defun parents (x)
	(list (get x 'mom) (get x 'dad))
)
(defun brother (x y)
	(or (eq (get x 'mom) (get y 'mom))
		(eq (get x 'dad) (get y 'dad))
	)
)
(setf (get 'x 'mom) 'a)
(setf (get 'x 'dad) 'b)
(setf (get 'y 'mom) 'a)
(setf (get 'y 'dad) 'b)
(setf (get 'z 'mom) 'c)
(setf (get 'z 'dad) 'd)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (parents 'x))
(print (brother 'y 'x))
(print (brother 'y 'z))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №48 ------------------------------------------")
;Задача 48
;Напишите предикат (ИМЕЕТ-СВОЙСТВО символ свойство), который проверяет, обладает ли символ данным свойством.
;Код:

(defun Hass(x property)
	(Find property (symbol-plist x)) 
)
(defun Findd(property list) 
      (cond
      	((null list) nil) 
        ((equal property (car list)) T) 
        (t (Findd property (cddr list)))
      )
) 

(setf (get 'car 'color) 'black) 
(setf (get 'car 'maxspeed) '140) 
(setf (get 'car 'mark) 'lada)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(Hass 'car 'color))
(print(Hass 'car 'maxspeed))
(print(Hass 'car 'country))

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

(write-line "")
(write-line "")
(write-line "------------------------------------|-----------------|--------------------------------------")
(write-line "------------------------------------|---- Зачтены ----|--------------------------------------")
(write-line "------------------------------------V-----------------V--------------------------------------")
(write-line "")
(write-line "")
(write-line "")
(write-line "")
(write-line "------------------------------------|-----------------|--------------------------------------")
(write-line "------------------------------------|-- Lisp basics --|--------------------------------------")
(write-line "------------------------------------V-----------------V--------------------------------------")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №1 -------------------------------------------")
;Задача  1
;Запишите последовательности вызовов CAR и CDR, выделяющие из приведённых ниже списков символ цель.
;Упростите эти вызовы с помощью комбинации селекторов:
;(1 2 цель 3 4)
;((1) (2 цель) (3 (4)))
;((1 (2 (3 4 цель))))

(write-line "")
(write-line "Test-cases:")

;Input:
(print (caar(cdaddr '(1 2 '(цель) 3 4))))
(print (caar(cdadr(cadr '((1) (2 '(цель)) (3 (4)))))))
(print (caadar(cddar(cdadar '((1 (2 (3 4 '(цель)))))))))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №12 ------------------------------------------")
;Задача 12
;Определите функцию, заменяющую в исходном списке два подряд идущих одинаковых элемента одним.
;Код:
(defun ReplaceInList (lst)
  ((lambda (x y)    
        (cond ((null y) lst)
             ((equal x (cadr lst)) (cons x (ReplaceInList (cddr lst))))
             (t (cons x (ReplaceInList y)))))  
  (car lst) 
  (cdr lst )))

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (ReplaceInList '(a a b b c c c)))
(print (ReplaceInList '(a a (b b c) (b b c) (b b c) c f f c)))
(print (ReplaceInList '(1 1 1 1 1 1 4 5 67 7 7)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №29 ------------------------------------------")
;Задача 29
;Определите функцию, вычисляющую глубину списка (самой глубокой ветви).
;Код:
(defun depth (lst)
	(if (or (atom lst) (null lst))
		0
		(max (+ 1 (depth (car lst))) 
                     (depth (cdr lst)))
	)
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (depth  '(1 2 3)))
(print (depth '((1) (2 (4) 5) (3))))
(print (depth '((1) (2) (3))))

(write-line "")
(write-line "")
(write-line "------------------------------|-----------------------------|--------------------------------")
(write-line "------------------------------|-- Higher-orders functions --|--------------------------------")
(write-line "------------------------------V-----------------------------V--------------------------------")
(write-line "")
(write-line "")
