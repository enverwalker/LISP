## Абибуллаев Энвер

# Практические задания по СЯП 1,12,16,17,29,35,36,38,46,48
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
 Input: (print (caar(cdaddr '(1 2 '(цель) 3 4))))
 Output: ЦЕЛЬ

 Input: (print (caar(cdadr(cadr '((1) (2 '(цель)) (3 (4)))))))
 Output: ЦЕЛЬ

 Input: (print (caadar(cddar(cdadar '((1 (2 (3 4 '(цель)))))))))
 Output: ЦЕЛЬ
  ```
</p>
</details>

### Задача 12
  Определите функцию, заменяющую в исходном списке два подряд идущих одинаковых элемента одним.
<details><summary>Код:</summary>
<p>
	
```lisp
(defun ReplaceInList (lst)
  ((lambda (x y)    
        (cond ((null y) lst)
             ((equal x (cadr lst)) (cons x (ReplaceInList (cddr lst))))
             (t (cons x (ReplaceInList y)))))  
  (car lst) 
  (cdr lst )))
```
</p>
</details>
<details><summary>Тесты:</summary>
<p>

```lisp
Input: (print (ReplaceInList '( a a b b c c c)))
Output: (A B C C)

Input: (print (ReplaceInList '( a a (b b c) (b b c) (b b c) c f f c)))
Output: (A (B B C) (B B C) C F C)

Input: (print (ReplaceInList '(1 1 1 1 1 1 4 5 67 7 7)))
Output: (1 1 1 4 5 67 7)
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
Input: (print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4))
Output: (1 2 3 4 "Put me Here" 5 7 8 9)

Input: (print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9))
Output: (1 2 3 4 5 7 8 9 NIL "Put me Here")
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

### Задача 35
  1. Определите функцию ПОДМНОЖЕСТВО, которая проверяет, является ли одно множество подмножеством другого.
<details><summary>Код:</summary>
<p>
	
```lisp
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
```  
</p>
</details>

<details><summary>Тесты:</summary>
<p>
	
```lisp
Input: (subset '(1 2 3) '(5 7 8))
Output: NIL

Input: (subset '(8 4 2) '(6 3 4 7 2 8))
Output: T
```  
</p>
</details>

  2. Определите также СОБСТВЕННОЕ-ПОДМНОЖЕСТВО.
<details><summary>Код:</summary>
<p>
	
```lisp
(defun proper-subset (a b)
    (and (subset a b) (not (equal a b)))
)
```  
</p>
</details>

<details><summary>Тесты:</summary>
<p>
	
```lisp
Input: (proper-subset '(1 2 3) '(1 2 3))
Output: NIL

Input: (proper-subset '(1 2 3) '(1 2 3 4 5 6 7 8))
Output: T
```  
</p>
</details>

### Задача 36
  Определите предикат НЕПЕРЕСЕКАЮЩИЕСЯ, проверяющий, что 2 множества не пересекаются, т.е. у них нет общих элементов.
<details><summary>Код:</summary>
<p>
	
```lisp
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
```  
</p>
</details>

<details><summary>Тесты:</summary>
<p>
	
```lisp
Input: (disjoint '(1 2 3) '(4 5 6))
Output: T

Input: (disjoint '(2 5 9 1) '(1 6 4 5))
Output: NIL
```  
</p>
</details>

### Задача 38
  Определите функцию ОБЪЕДИНЕНИЕ, формирующую объединение двух множеств.
<details><summary>Код:</summary>
<p>
	
```lisp
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
```  
</p>
</details>

<details><summary>Тесты:</summary>
<p>
	
```lisp
Input: (print (union~ '(a b c) '(b c d)))
Output: (A B C D)

Input: (print (union~ '(1 2 3 4 5) '(1 2 3 4 12 13 11)))
Output: (5 1 2 3 4 12 13 11)

Input: (print (union~ '() '()))
Output: NIL
```  
</p>
</details>

### Задача 46  
  Предположим, что отец и мать некоторого лица, хранятся как значения соответствующих свойств у символа, обозначающего это лицо. Напишите функцию (РОДИТЕЛИ x), которая возвращает в качестве значения родителей, и предикат (СЕСТРЫ-БРАТЬЯ x1 x2), который истинен в случае, если x1 и x2 — сестры или братья, родные или с одним общим родителем.
<details><summary>Код:</summary>
<p>    

```lisp
(defun parents (name)
    (
        list
        (getprop name `parent1)
        (getprop name `parent2)
    )
)

(defun sisterbrotherp (first_person second_person)
    (
        (lambda (first_person_parents second_person_parents)
            (cond
                ((null (intersectp first_person_parents second_person_parents)) T)
                (T NIL)
            )
        )
        (parents first_person)
        (parents second_person)
    )
)
```  
</p>
</details>  
<details><summary>Тесты:</summary>
<p>

```lisp
Input: (putprop `Alex `parent1 `Ann)
Input: (putprop `Alex `parent2 `Jury)
Input: (putprop `Jane `parent1 `Ann)
Input: (putprop `Jane `parent2 `Sebastian)
Input: (putprop `Bob `parent1 `Helga)
Input: (putprop `Bob `parent2 `Ron)

Input: (print (sisterbrotherp `Alex `Jane))
Output: T

Input: (print (sisterbrotherp `Alex `Bob))
Output: NIL
```  
</p>
</details>

### Задача 48
  Напишите предикат (ИМЕЕТ-СВОЙСТВО символ свойство), который проверяет, обладает ли символ данным свойством.
<details><summary>Код:</summary>
<p>

```lisp
(defun Has(x property)
	(Find property (symbol-plist x)) 
) 

(defun Find(property list) 
      (cond
      	((null list) nil) 
        ((equal property (car list)) T) 
        (t (Find property (cddr list)))
      )
) 

(setf (get 'car 'color) 'black) 
(setf (get 'car 'maxspeed) '140) 
(setf (get 'car 'mark) 'lada) 
```  
</p>
</details>

<details><summary>Тесты:</summary>
<p>

```lisp
Input: (print(ИМЕЕТ-СВОЙСТВО 'car 'color))
Output: T

Input: (print(ИМЕЕТ-СВОЙСТВО 'car 'maxspeed))
Output: T

Input: (print(ИМЕЕТ-СВОЙСТВО 'car 'country))
Output: NIL
```  
</p>
</details>
