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
