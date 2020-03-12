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
  ```lisp
  (1 2 цель 3 4)
  ((1) (2 цель) (3 (4)))
  ((1 (2 (3 4 цель))))
  ```
  Код:
  ```lisp
  (print (caar(cdaddr '(1 2 '(цель) 3 4)))) ; => ЦЕЛЬ

  (print (caar(cdadr(cadr '((1) (2 '(цель)) (3 (4))))))) ; => ЦЕЛЬ

  (print (caadar(cddar(cdadar '((1 (2 (3 4 '(цель))))))))) ; => ЦЕЛЬ
  ```
  Тесты:
  ```lisp
  (print (caar(cdaddr '(1 2 '(цель) 3 4))))

  (print (caar(cdadr(cadr '((1) (2 '(цель)) (3 (4)))))))

  (print (caadar(cddar(cdadar '((1 (2 (3 4 '(цель)))))))))
  ```
### Задача 12
  Определите функцию, заменяющую в исходном списке два подряд идущих одинаковых элемента одним.
  
  Код:
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
  Тесты:
```lisp
(print (ReplaceInList '(3 3 4 5 5 10 10 10 11))) ; => (3 4 5 10 11)

(print (ReplaceInList '(12 12 56 67 88 88))) ; => (12 56 67 88)

(print (ReplaceInList '(0 0 0 43 4))) ; => (0 43 4) 
```
### Задача 16
  Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.
  
  Код:
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
  Тесты:
```lisp
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4)) ; => (1 2 3 4 "Put me Here" 5 7 8 9)
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 0)) ; => ("Put me Here" 1 2 3 4 5 7 8 9)
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9)) ; => (1 2 3 4 5 7 8 9 NIL "Put me Here")
