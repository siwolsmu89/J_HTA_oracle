-- ����� ���� �� ���� ���� (�� ��ǻ�� ������ �������� ����)

-- ����ڸ� scott
-- ��й�ȣ tiger
CREATE USER scott IDENTIFIED BY tiger;

-- ������ ����ڿ��� �����ͺ��̽� ���� ���� �ο��ϱ�
GRANT CREATE SESSION TO scott;

-- �Ϲ� ����ڿ��� �ο��Ǵ� �ý��� ������ �׷�ȭ�س��� ���� �̿��ؼ� ���Ѻο��ϱ�
GRANT CONNECT, RESOURCE TO scott;

-- scott ������ contacts ���̺� ��ȸ�ϱ�
-- scott ����ڰ� GRANT������ ������ ��ȸ�ϱ� �Ұ���
SELECT *
FROM scott.contacts;

-- ��ȭ��ȣ �����ϱ�
UPDATE scott.contacts
SET
    contact_tel = '010-1122-3344'
WHERE contact_name = '������';

-- ������ ���� ���� name ���� ���ؼ��� UPDATE �۾� ���� �Ұ���
-- insufficient privileges : ���� ����
UPDATE scott.contacts
SET
    contact_name = '������'
WHERE contact_name = '������';

-- scott.contacts�� ���� ���̺��� ���Ǿ �����ϱ�
CREATE SYNONYM contacts FOR scott.contacts;

-- ���Ǿ ����� ��ȸ�ϱ�
SELECT *
FROM contacts;

-- �ý��� ���� ����
SELECT *
FROM ROLE_SYS_PRIVS;

-- �������̺� USER_TABLES ���� (������� ��� ���̺� ���� ��ȸ)
SELECT *
FROM USER_TABLES;

-- ������� ��� �� ���� ��ȸ
SELECT *
FROM USER_VIEWS;

-- ������� ��� ������ ���� ��ȸ
SELECT *
FROM USER_SEQUENCES;

-- ��� ����� ���� ��ȸ
SELECT *
FROM USER_USERS;

GRANT CREATE VIEW TO scott;

-- ���� ������ ����ϱ�
-- ��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
-- ������� �� ������ ǥ���ϱ�
SELECT employee_id, job_id 
FROM employees
UNION
SELECT employee_id, job_id 
FROM job_history;

-- ��� ����� ���� �μ����̵�� ���� �ҼӺμ� ���̵� ��ȸ�ϱ�
SELECT employee_id, department_id
FROM employees
UNION ALL
SELECT employee_id, department_id
FROM job_history;

-- ���� �����ϴ� ������ ���� �������� �����ϰ� �ִ� ����� ���̵�� �������̵� ��ȸ�ϱ�
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

-- ���� ����� ���� ������ ����� ����
SELECT E.employee_id, E.job_id
FROM employees E, job_history H
WHERE e.employee_id = H.employee_id
    AND e.job_id = H.job_id;

-- ������ ����� ���� ���� ����� ���̵� ��ȸ�ϱ�
SELECT employee_id
FROM employees
MINUS
SELECT employee_id
FROM job_history;

-- ������ ����� ���� ���� ����� ���̵�� �̸� ��ȸ�ϱ�
SELECT A.employee_id, B.first_name
FROM (SELECT employee_id
     FROM employees
     MINUS
     SELECT employee_id
     FROM job_history) A, employees B
WHERE A.employee_id = B.employee_id
ORDER BY 1;

-- ������ ����� ���� ���� ����� ���̵�, �̸�, ���� ����, �ҼӺμ����� ��ȸ�ϱ�
SELECT A.employee_id, E.first_name, E.job_id, D.department_name
FROM (SELECT employee_id
      FROM employees
      MINUS 
      SELECT employee_id
      FROM job_history) A
      , employees E
      , departments D
WHERE A.employee_id = E.employee_id
    AND E.department_id = D.department_id
ORDER BY 1;

-- ��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
-- ������̵�, ����, �޿��� ��ȸ�ϱ�
SELECT employee_id, job_id, salary
FROM employees
UNION 
SELECT employee_id, job_id, 0   
FROM job_history;