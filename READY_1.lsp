(write-line "")
(write-line "")
(write-line "------------------------------------|-----------------|--------------------------------------")
(write-line "------------------------------------|-- Lisp basics --|--------------------------------------")
(write-line "------------------------------------V-----------------V--------------------------------------")
(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №17 ------------------------------------------")
;Задача 17
;Создайте предикат, порождающий всевозможные перестановки исходного множества
;Код:
(defun insert-elem-in-each-position (a b c)
  (cond 
      ((null c) (list (append b (list a))))
      (t
          (cons 
               (append b (list a) c) 
               (insert-elem-in-each-position a (append b (list (car c))) (cdr c))
           )
       )
   )
)
(defun add-elem-for-each-permutation (elem perm-lst)
	(cond
		((null perm-lst) nil)
		(t (append
				(insert-elem-in-each-position elem nil (car perm-lst))
				(add-elem-for-each-permutation elem (cdr perm-lst))))
	)
)
(defun permutations (lst)
	(cond
		((null lst) nil)
		((null (cdr lst)) (list lst))
		(t (add-elem-for-each-permutation
			(car lst)
			(permutations (cdr lst))))
	)
)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print(permutations '(1 2)))
(print(permutations '(1 2 3)))
(print(permutations '(1 2 3 4)))

(write-line "")
(write-line "")
(write-line "----------------------------------------- Task №35 ------------------------------------------")
;Задача 35
;1. Определите функцию ПОДМНОЖЕСТВО, которая проверяет, является ли одно множество подмножеством другого.
;Код:
(defun my-member (a li)
	(cond
		((null li) nil)
		((equal a (car li)) T)
		(t (my-member a (cdr li)))
	)
)

(defun set1-subset-set2 (set1 set2)
	(cond 
		((null set1) T)
        ((my-member (car set1) set2) (set1-subset-set2 (cdr set1) set2))
		(t nil)
    )
)

(write-line "")
(write-line "Part 1. Test-cases:")

;Тесты:
(print (set1-subset-set2 '(1 2 4) '(1 5 a 4 2)))
(print (set1-subset-set2 '(1 (a 5 v) 2) '(5 2 (a 5 v) 1 7)))
(print (set1-subset-set2 '(1 2 v 5) '(v 6 2 1)))

(write-line "")

;2. Определите также СОБСТВЕННОЕ-ПОДМНОЖЕСТВО.
;Код:
(defun set1-equal-set2 (set1 set2)
	(and
		(set1-subset-set2 set1 set2)
		(set1-subset-set2 set2 set1)
	)
)

(defun own-subset (set1 set2)
	(and 
		(not (null set1))
		(not (set1-equal-set2 set1 set2))
		(set1-subset-set2 set1 set2)
	)
)

(write-line "")
(write-line "Part 2. Test-cases:")

;Тесты:
(print (own-subset '(1 2 3) '(1 2 3)))
(print (own-subset '(1 2 3) '(1 2 3 4 5 6 7 8)))
(print (own-subset '(0 5 7 7) '(1 2 3 4 5 0 7 5 7)))

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

(defun link-parents(child mom dad)
    (setf (get child 'mom) mom)
    (setf (get child 'dad) dad)
)

(defun get-parents(child)
    (list (get-mom child) (get-dad child))
)

(defun get-dad(child)
    (get child 'dad)
)

(defun get-mom(child)
    (get child 'mom)
)

(defun sisters-brothers(child1 child2)
    (cond
        ((eq (get-mom child1) (get-mom child2)) T)
        ((eq (get-dad child1) (get-dad child2)) T)
        (T NIL)
    )
)

(link-parents 'child_1 'mom_1 'dad_1)
(link-parents 'child_2 'mom_2 'dad_2)
(link-parents 'child_3 'mom_2 'dad_1)
(link-parents 'child_4 'mom_3 'dad_3)

(write-line "")
(write-line "Test-cases:")

;Тесты:
(print (sisters-brothers 'child_1 'child_2))
(print (sisters-brothers 'child_2 'child_3))
(print (sisters-brothers 'child_3 'child_1))
(print (sisters-brothers 'child_2 'child_4))

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
