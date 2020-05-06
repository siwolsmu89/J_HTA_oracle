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