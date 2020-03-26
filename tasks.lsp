## ���������� �����

# ������������ ������� �� ���
- [������ ����� LISP](#������-�����-LISP)
  - [������ 1](#������-1)
  - [������ 12](#������-12)
  - [������ 16](#������-16)
  - [������ 17](#������-17)
  - [������ 29](#������-29)
  - [������ 35](#������-35)
  - [������ 36](#������-36)
  - [������ 38](#������-38)
  - [������ 46](#������-46)
  - [������ 48](#������-48)
- [������� ������ ��������](#�������-������-��������)
- [�������](#�������)
  
## ������ ����� LISP
### ������ 1
  �������� ������������������ ������� CAR � CDR, ���������� �� ���������� ���� ������� ������ ����. ��������� ��� ������ � ������� ���������� ����������:
<details><summary>������:</summary>
<p>
 
  ```lisp
  (1 2 ���� 3 4)
  ((1) (2 ����) (3 (4)))
  ((1 (2 (3 4 ����))))
  ```
</p>
</details>
<details><summary>���:</summary>
<p>
	
  ```lisp
 Input:
 (print (caar(cdaddr '(1 2 '(����) 3 4))))
 (print (caar(cdadr(cadr '((1) (2 '(����)) (3 (4)))))))
 (print (caadar(cddar(cdadar '((1 (2 (3 4 '(����)))))))))
 
 Output: 
 ����
 ����
 ����
  ```
</p>
</details>

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

### ������ 12
  ���������� �������, ���������� � �������� ������ ��� ������ ������ ���������� �������� �����.
<details><summary>���:</summary>
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

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>

```lisp
Input:
(print (ReplaceInList '(a a b b c c c)))
(print (ReplaceInList '(a a (b b c) (b b c) (b b c) c f f c)))
(print (ReplaceInList '(1 1 1 1 1 1 4 5 67 7 7)))

Output:
(A B C C)
(A (B B C) (B B C) C F C)
(1 1 1 4 5 67 7)
```
</p>
</details>

### ������ 16
  ���������� �������, ����������� �������� ������ ������ �� ������ ������, ������� � �������� �������.
<details><summary>���:</summary>
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

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input:
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 0))

Output:
(1 2 3 4 "Put me Here" 5 7 8 9)
(1 2 3 4 5 7 8 9 NIL "Put me Here")
("Put me Here" 1 2 3 4 5 7 8 9)
```
</p>
</details>

### ������ 29  
  ���������� �������, ����������� ������� ������ (����� �������� �����).
<details><summary>���:</summary>
<p>
	
```lisp
(defun depth (lst)
	(if (or (atom lst) (null lst))
		0
		(max (+ 1 (depth (car lst))) 
                     (depth (cdr lst)))
	)
)	
```  
</p>
</details>

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input:
(print (depth  '(1 2 3)))
(print (depth '((1) (2 (4) 5) (3))))
(print (depth '((1) (2) (3))))

Output:
1
3
2
```  
</p>
</details>

### ������ 35
  1. ���������� ������� ������������, ������� ���������, �������� �� ���� ��������� ������������� �������.
<details><summary>���:</summary>
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

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input: (print (subset '(1 2 3) '(5 7 8)))
(print (subset '(8 4 2) '(6 3 4 7 2 8)))
(print (subset '(3 6 5 7) '(3)))

Output:
NIL
T
NIL
```  
</p>
</details>

  2. ���������� ����� �����������-������������.
<details><summary>���:</summary>
<p>
	
```lisp
(defun proper-subset (a b)
    (and (subset a b) (not (equal a b)))
)
```  
</p>
</details>

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input:
(print (proper-subset '(1 2 3) '(1 2 3)))
(print (proper-subset '(1 2 3) '(1 2 3 4 5 6 7 8)))
(print (proper-subset '(0 5 7 7) '(1 2 3 4 5 0 7 5 7)))

Output:
NIL
T
T
```  
</p>
</details>

### ������ 36
  ���������� �������� ����������������, �����������, ��� 2 ��������� �� ������������, �.�. � ��� ��� ����� ���������.
<details><summary>���:</summary>
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

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input: 
(print (disjoint '(1 2 3) '(4 5 6)))
(print (disjoint '(2 5 9 1) '(1 6 4 5)))
(print (disjoint '(1 2 3) '(1 2 3)))

Output:
T
NIL
NIL
```  
</p>
</details>

### ������ 38
  ���������� ������� �����������, ����������� ����������� ���� ��������.
<details><summary>���:</summary>
<p>
	
```lisp
(defun in-predicate (a l)
    (cond
        ((null l) nil) ;������� �� ����� ������������ ������� ���������
        ((eq a (car l)) t) ;������� ����������� ���������, ���� � �� ����������
        (t (in-predicate a (cdr l))) ; ���������� ��������
    )
)

(defun union~ (a b)
    (cond ((null a) b)  
        ((null b) a)
        ((in-predicate (car a) b) (union~ (cdr a) b)) ;��������� ����������� �� a � b, ���� ���, �� ��� ������
        (t (cons (car a) (union~ (cdr a) b)))
    )
)
```  
</p>
</details>

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>
	
```lisp
Input:
(print (union~ '(a b c) '(b c d)))
(print (union~ '(1 2 3 4 5) '(1 2 3 4 12 13 11)))
(print (union~ '() '()))

Output:
(A B C D)
(5 1 2 3 4 12 13 11)
 NIL
```  
</p>
</details>

### ������ 46  
  �����������, ��� ���� � ���� ���������� ����, �������� ��� �������� ��������������� ������� � �������, ������������� ��� ����. �������� ������� (�������� x), ������� ���������� � �������� �������� ���������, � �������� (������-������ x1 x2), ������� ������� � ������, ���� x1 � x2 � ������ ��� ������, ������ ��� � ����� ����� ���������.
<details><summary>���:</summary>
<p>    

```lisp
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
```  
</p>
</details>

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>

```lisp
Input: (print (parents 'x))
(print (brother 'y 'x))
(print (brother 'y 'z))
Output:
(A B)
T
NIL
```  
</p>
</details>

### ������ 48
  �������� �������� (�����-�������� ������ ��������), ������� ���������, �������� �� ������ ������ ���������.
<details><summary>���:</summary>
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

[������-����������](https://rextester.com/l/common_lisp_online_compiler)

<details><summary>�����:</summary>
<p>

```lisp
Input: (print(Has 'car 'color))
(print(Has 'car 'maxspeed))
(print(Has 'car 'country))
Output:
T
T
NIL
```  
</p>
</details>
