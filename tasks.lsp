;������ 1
;�������� ������������������ ������� CAR � CDR, ���������� �� ���������� ���� ������� ������ ����.
;��������� ��� ������ � ������� ���������� ����������:
(1 2 ���� 3 4)
((1) (2 ����) (3 (4)))
((1 (2 (3 4 ����))))

;Input:
(print (caar(cdaddr '(1 2 '(����) 3 4))))
(print (caar(cdadr(cadr '((1) (2 '(����)) (3 (4)))))))
(print (caadar(cddar(cdadar '((1 (2 (3 4 '(����)))))))))

;Output: 
����
����
����

;������ 12
;���������� �������, ���������� � �������� ������ ��� ������ ������ ���������� �������� �����.
;���:

(defun ReplaceInList (lst)
  ((lambda (x y)    
        (cond ((null y) lst)
             ((equal x (cadr lst)) (cons x (ReplaceInList (cddr lst))))
             (t (cons x (ReplaceInList y)))))  
  (car lst) 
  (cdr lst )))

;�����:

;Input:
(print (ReplaceInList '(a a b b c c c)))
(print (ReplaceInList '(a a (b b c) (b b c) (b b c) c f f c)))
(print (ReplaceInList '(1 1 1 1 1 1 4 5 67 7 7)))

;Output:
(A B C C)
(A (B B C) (B B C) C F C)
(1 1 1 4 5 67 7)

;������ 16
;���������� �������, ����������� �������� ������ ������ �� ������ ������, ������� � �������� �������.
;���:
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
;�����:

;Input:
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 4))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 9))
(print(AddInList '(1 2 3 4 5 7 8 9) "Put me Here" 0))

;Output:
(1 2 3 4 "Put me Here" 5 7 8 9)
(1 2 3 4 5 7 8 9 NIL "Put me Here")
("Put me Here" 1 2 3 4 5 7 8 9)

;������ 29  
;���������� �������, ����������� ������� ������ (����� �������� �����).
;���:
(defun depth (lst)
	(if (or (atom lst) (null lst))
		0
		(max (+ 1 (depth (car lst))) 
                     (depth (cdr lst)))
	)
)	

;�����:

;Input:
(print (depth  '(1 2 3)))
(print (depth '((1) (2 (4) 5) (3))))
(print (depth '((1) (2) (3))))

;Output:
1
3
2

;������ 35
;1. ���������� ������� ������������, ������� ���������, �������� �� ���� ��������� ������������� �������.
;���:
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
;�����:

;Input:
(print (subset '(1 2 3) '(5 7 8)))
(print (subset '(8 4 2) '(6 3 4 7 2 8)))
(print (subset '(3 6 5 7) '(3)))

;Output:
NIL
T
NIL

;2. ���������� ����� �����������-������������.
;���:
(defun proper-subset (a b)
    (and (subset a b) (not (equal a b)))
)
;�����:

;Input:
(print (proper-subset '(1 2 3) '(1 2 3)))
(print (proper-subset '(1 2 3) '(1 2 3 4 5 6 7 8)))
(print (proper-subset '(0 5 7 7) '(1 2 3 4 5 0 7 5 7)))

;Output:
NIL
T
T

;������ 36
;���������� �������� ����������������, �����������, ��� 2 ��������� �� ������������, �.�. � ��� ���
;����� ���������.
;���:

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

;�����:

;Input: 
(print (disjoint '(1 2 3) '(4 5 6)))
(print (disjoint '(2 5 9 1) '(1 6 4 5)))
(print (disjoint '(1 2 3) '(1 2 3)))

;Output:
T
NIL
NIL

;������ 38
;���������� ������� �����������, ����������� ����������� ���� ��������.
;���:

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

;�����:

;Input:
(print (union~ '(a b c) '(b c d)))
(print (union~ '(1 2 3 4 5) '(1 2 3 4 12 13 11)))
(print (union~ '() '()))

;Output:
(A B C D)
(5 1 2 3 4 12 13 11)
 NIL
 
;������ 46  
;�����������, ��� ���� � ���� ���������� ����, �������� ��� �������� ��������������� ������� � �������,
;������������� ��� ����. �������� ������� (�������� x), ������� ���������� � �������� �������� ���������,
;� �������� (������-������ x1 x2), ������� ������� � ������, ���� x1 � x2 � ������ ��� ������, ������ ���
;� ����� ����� ���������.
;���:

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

;�����:

;Input: 
(print (parents 'x))
(print (brother 'y 'x))
(print (brother 'y 'z))

;Output:
(A B)
T
NIL

;������ 48
;�������� �������� (�����-�������� ������ ��������), ������� ���������, �������� �� ������ ������ ���������.
;���:

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

;�����:

;Input:
(print(Has 'car 'color))
(print(Has 'car 'maxspeed))
(print(Has 'car 'country))

;Output:
T
T
NIL