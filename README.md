## Абибуллаев Энвер

# Практические задания по СЯП
- [Основы языка LISP](#Основы-языка-LISP)
  - [Задача 1](#Задача-1)
  - [Задача 12](#Задача-12)
  - [Задача 16](#Задача-16)
  - [Задача 17](#Задача-17)
  - [Задача 29](#Задача-29)
  - [Задача 35](#Задача-35)
  - [Задача 36](#Задача-36)
  - [Задача 38](#Задача-38)
  - [Задача 46](#Задача-46)
  - [Задача 48](#Задача-48)
- [Функции высших порядков](#Функции-высших-порядков)
- [Макросы](#Макросы)
  
## Основы языка LISP
### Задача 1
  Запишите последовательности вызовов CAR и CDR, выделяющие из приведённых ниже списков символ цель. Упростите эти вызовы с помощью комбинации селекторов:
<details><summary>Списки:</summary>
<p>
 
  ```lisp
  (1 2 цель 3 4)
  ((1) (2 цель) (3 (4)))
  ((1 (2 (3 4 цель))))
  ```
</p>
</details>
<details><summary>Код:</summary>
<p>
	
  ```lisp
  (print (caar(cdaddr '(1 2 '(цель) 3 4)))) ; => ЦЕЛЬ

  (print (caar(cdadr(cadr '((1) (2 '(цель)) (3 (4))))))) ; => ЦЕЛЬ

  (print (caadar(cddar(cdadar '((1 (2 (3 4 '(цель))))))))) ; => ЦЕЛЬ
  ```
</p>
</details>

### Задача 12
  Определите функцию, заменяющую в исходном списке два подряд идущих одинаковых элемента одним.
<details><summary>Код:</summary>
<p>
	
```lisp
(defun ReplaceInList (li)
	(if (null li)
		nil
		(( lambda (first second re-tail)
			(if (equal first second)
				re-tail 
				(cons first re-tail)
			)
		) (car li) (cadr li) (ReplaceInList (cdr li)) ) 
	)
)
```
</p>
</details>
<details><summary>Тесты:</summary>
<p>

```lisp
(print (ReplaceInList '(3 3 4 5 5 10 10 10 11))) ; => (3 4 5 10 11)

(print (ReplaceInList '(12 12 56 67 88 88))) ; => (12 56 67 88)

(print (ReplaceInList '(0 0 0 43 4))) ; => (0 43 4) 
```
</p>
</details>

### Задача 16
  Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.
<details><summary>Код:</summary>
<p>

  ```lisp
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
```
</p>
</details>
<details><summary>Тесты:</summary>
<p>
	
```lisp
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4)) ; => (1 2 3 4 "Put me Here" 5 7 8 9)
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 0)) ; => ("Put me Here" 1 2 3 4 5 7 8 9)
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9)) ; => (1 2 3 4 5 7 8 9 NIL "Put me Here")
```
</p>
</details>

### Задача 29  
  Определите функцию, вычисляющую глубину списка (самой глубокой ветви).
<details><summary>Код:</summary>
<p>
	
```lisp
(defun maxdeep (lst)(
        cond
        ((atom lst) 0)
        (t
            (
                max (+ 1 (maxdeep (car lst))) (maxdeep (cdr lst))
            )
        )
    )
)
```  
</p>
</details>

;;; Задача 35: Определите функцию ПОДМНОЖЕСТВО, которая проверяет, является ли одно множество подмножеством другого.
;;; Определите также СОБСТВЕННОЕ-ПОДМНОЖЕСТВО.

;;; 1. Без использования функционалов:

;~- Определение функции ПОДМНОЖЕСТВО
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

;~- Test cases

;	Input: (set1-subset-set2 '(1 2 4) '(1 5 a 4 2))
;	Output: T

;	Input: (set1-subset-set2 '(1 (a 5 v) 2) '(5 2 (a 5 v) 1 7))
;	Output: T

;	Input: (set1-subset-set2 '(1 2 v 5) '(v 6 2 1))
;	Output: NIL

;~- Множ-во А является собственным подмножеством множ-ва B, если А с B и A != B

;~- Определение функции СОБСТВЕННОЕ-ПОДМНОЖЕСТВО
(defun set1-equal-set2 (set1 set2)
	(and
		(set1-subset-set2 set1 set2)
		(set1-subset-set2 set2 set1)
	)
)

(defun set1-proper-subset-set2 (set1 set2)
	(and 
		(not (null set1))
		(not (set1-equal-set2 set1 set2))
		(set1-subset-set2 set1 set2)
	)
)

;~- Test cases

;	Input: (set1-proper-subset-set2 '(1 2 3) '(1 2 3))
;	Output: NIL

;	Input: (set1-proper-subset-set2 '(1 v a 4 d 3) '(1 6 3 a d 3 4 v))
;	Output: T

;;; 2. С использованием функционалов:

;~- Определение функции ПОДМНОЖЕСТВО
(defun my-member (a li)
	(cond
		((null li) nil)
		((equal a (car li)) T)
		(t (my-member a (cdr li)))
	)
)

(defun subset (a b)
    (not (mapcan (lambda (el)
						(cond 
							((not (my-member el b)) (list T))
						)) a)
	)
)

;~- Test cases

;	Input: (subset '(1 2 3) '(5 7 8))
;	Output: NIL

;	Input: (subset '(8 4 2) '(6 3 4 7 2 8))
;	Output: T

;~- Определение функции СОБСТВЕННОЕ-ПОДМНОЖЕСТВО
(defun proper-subset (a b)
    (and (subset a b) (not (equal a b)))
)

;~- Test cases

;	Input: (proper-subset '(1 2 3) '(1 2 3))
;	Output: NIL

;	Input: (proper-subset '(1 2 3) '(1 2 3 4 5 6 7 8))
;	Output: T

;;; Задача 36: Определите предикат НЕПЕРЕСЕКАЮЩИЕСЯ, проверяющий, что 2 множества не пересекаются,
;;; т.е. у них нет общих элементов.

;;; 1. Без использования функционалов:

(defun my-member (a li)
	(cond
		((null li) nil)
		((equal a (car li)) T)
		(t (my-member a (cdr li)))
	)
)

(defun inter-section (set1 set2)
	(cond 
		((null set1) nil)
		(t ((lambda (head tail) 
			(cond 
				((my-member head set2) (cons head tail))
				(t tail)
			)
		) 
		(car set1) (inter-section (cdr set1) set2)
		))
	)
)

(defun not-inter-section (set1 set2)
	(cond
		((null (inter-section set1 set2)) T)
		(t nill)
	)
) 

;~- Test cases

;	Input: (inter-section '(1 2 3) '(4 56 4))
;	Output: NIL

;	Input: (inter-section '(6 v e 5 30) '(8 u e 6 t v 30))
;	Output: (6 V E 30)

;	Input: (not-inter-section '(1 2 3) '(5 43 1 2))
;	Output: NIL

;	Input: (not-inter-section '(1 4 2) '(8 t e 5))
;	Output: T

;;; 2. С использованием функционалов:

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

;~- Test cases

;	Input: (disjoint '(1 2 3) '(4 5 6))
;	Output: T

;	Input: (disjoint '(2 5 9 1) '(1 6 4 5))
;	Output: NIL
