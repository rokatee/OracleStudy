SELECT USER
FROM DUAL;
--==>> HR

--���� ����ȭ (Nomalization) ����--

--�� ����ȭ��?
--   �� ����� �����ͺ��̽� ������ �޸� ���� ���� ����
--   � �ϳ��� ���̺���... �ĺ��ڸ� ������ ���� ���� ���̺�� ������ ������ ���Ѵ�
SELECT *
FROM EMPLOYEES;

-- ex) �����̰�...�������� �Ǹ��Ѵ�
--     ������Ʈ �� �ŷ�ó ���� ����� �����ִ� ��ø�� ������
--                   �����ͺ��̽�ȭ �Ϸ� �Ѵ�

-- ���̺�� : �ŷ�ó����
/*
  10Byte       10Byte       10Byte      10Byte     10Byte  10Byte  10Byte
--------------------------------------------------------------------------------
�ŷ�óȸ���  ȸ���ּ�    ȸ����ȭ    �ŷ�ó������  ����  �̸���     �޴���
--------------------------------------------------------------------------------
    LG       ���￩�ǵ�  02-345-6789     ���̰�     ����  jmk@na...   010-1...
    LG       ���￩�ǵ�  02-345-6789     ������     ����  jyj@na...   010-7...
    LG       ���￩�ǵ�  02-345-6789     ������     �븮  cyk@na...   010-3...
    LG       ���￩�ǵ�  02-345-6789     ����     ����  kys@na...   010-1...
    SK       ����Ұ���  02-987-6543     �ֳ���     ����  cny@da...   010-9...
    LG       �λ굿����  051-221-2111    ������     �븮  mcw@go...   010-1...
    SK       ����Ұ���  02-987-6543     ������     ����  ydh@na...   010-8...
                    
                                    :
--------------------------------------------------------------------------------

����) ���� ���ǵ� LG(����) ��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�� ���̶�� �����Ѵ�
      (�� ��(���ڵ�)�� 70Byte)

      ��� ��... ���� ���ǵ� �� ��ġ�� LG ���簡 ���д�����
      ����� �����ϰ� �Ǿ���
      ȸ���ּҴ� ���д� ���� �ٲ��, ȸ����ȭ�� 031-111-2222 �� �ٲ�� �Ǿ���

      �׷��� 100�� ���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�

      -- �̶� ����Ǿ�� �� ������ �� UPDATE 

      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
      WHERE �ŷ�óȸ��� = 'LG'
        AND ȸ���ּ� = '���￩�ǵ�';

      -- 100�� �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε���� �־�� �Ѵ�
         ��, 100�� * 70Byte �� ���
         �ϵ��ũ�󿡼� �о�ٰ� �޸𸮿� �ε���� �־�� �Ѵٴ� ���̴�

         �� �̴� ���̺��� ���谡 �߸��Ǿ����Ƿ�
            DB ������ ������ �޸� ���� ���� DOWN �� ���̴�

            �� �׷��Ƿ� ����ȭ ������ �����ؾ� �Ѵ�



����������������������������������������������������������������������������������   
�� 1 ����ȭ ��  �� 2 ����ȭ  ��  �� 3 ����ȭ  �� �� 4 ����ȭ  ��������ȭ(������ȭ)
����������������������������������������������������������������������������������    
    
��  �� 1 ����ȭ 

� �ϳ��� ���̺� �ݺ��Ǿ� �÷� ������ �����Ѵٸ� ������ �ݺ��Ǿ� 
������ �÷��� �и��Ͽ� ���ο� ���̺��� ������ش� .

-- ���̺��  : ȸ�� �� �θ� ���̺�

10Byte      10Byte         10Byte       10Byte    
-----------------------------------------------------
ȸ��ID  ���ŷ�óȸ��� ��  ȸ���ּ�  ��  ȸ����ȭ 
------
�����޴� �÷�
-----------------------------------------------------

    10          LG        ���￩�ǵ�    02-345-6789     
    20          SK        ����Ұ���    02-987-6543    
    30          LG        �λ굿����    051-221-2111   
-----------------------------------------------------


-- ���̺�� : ���� �� �ڽ� ���̺�

  10Byte       10Byte   10Byte     10Byte      10Byte
-------------------------------------------------------------

�ŷ�ó������ �� ���� ���̸���  ��  �޴���   �� ȸ��ID
                                               -------
                                               �����ϴ� �÷�
-------------------------------------------------------------

���̰�          ����   jmk@na...   010-1...      10
������          ����   jyj@na...   010-7...      10
������          �븮   cyk@na...   010-3...      10
����          ����   kys@na...   010-1...      10
�ֳ���          ����   cny@da...   010-9...      20
������          �븮   mcw@go...   010-1...      30
������          ����   ydh@na...   010-8...      20
    :
-------------------------------------------------------------
*/
--> �� 1 ����ȭ�� �����ϴ� �������� �и��� ���̺���
--  �� �ݵ�� �θ� ���̺�� �ڽ� ���̺��� ���踦 ���� �ȴ�. 

-->  �θ� ���̺� �� �����޴� �÷� �� PRIMARY KEY
--   �ڽ� ���̺� �� �����ϴ� �÷� �� FOREIGN KEY

--�� �����޴� �÷��� ���� Ư¡
--   �ݵ�� ������ ��(������)�� ���;� �Ѵ�
--   �ߺ��� ��(������)�� �־�� �ȵȴ�
--   ���������(NULL�� �־��) �ȵȴ�
--   ��, NOT NULL �̾�� �Ѵ�

--> �� 1 ����ȭ�� �����ϴ� ��������
--  �θ� ���̺��� PRIMARY KEY �� �׻� �ڽ� ���̺��� FOREIGN KEY �� ���̵ȴ�


/*
-- ���̺��� �и�(����)�Ǳ� ���� ���·� ��ȸ
SELECT A.�ŷ�óȸ���, A.ȸ���ּ�, A.ȸ����ȭ
     , B.�ŷ�ó������, B.����, B.�̸���, B.�޴���
FROM ȸ�� A, ���� B
WHERE A.ȸ��ID = B.ȸ��ID;

����) ���� ���ǵ� LG(����) ��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�� ���̶�� �����Ѵ�
      
      ��� ��... '���� ���ǵ�' �� ��ġ�� LG ���簡 ���д�����
      ����� �����ϰ� �Ǿ���
      ȸ���ּҴ� '���д�' ���� �ٲ��, ȸ����ȭ�� 031-111-2222 �� �ٲ�� �Ǿ���

      �׷��� ȸ�� ���̺��� 1���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�

      -- �̶� ����Ǿ�� �� ������ �� UPDATE 

      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
      WHERE �ŷ�óȸ��� = 'LG'
        AND ȸ���ּ� = '���￩�ǵ�';
        
      UPDATE ȸ��
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
      WHERE ȸ��ID = 10;

      -- 1 �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε���� �־�� �Ѵ�
         ��, 1 * 40Byte �� ���
         �ϵ��ũ�󿡼� �о�ٰ� �޸𸮿� �ε���� �־�� �Ѵٴ� ���̴�

         �� ����ȭ �������� 100�� ���� ó���ؾ� �� ��������
            1�Ǹ� ó���ϸ� �Ǵ� ������ �ٲ� ��Ȳ�̱� ������
            DB ������ �޸� ���� �Ͼ�� �ʰ� ���� ������ ó���� ���̴�



--�� ����ȭ ���� ���̺�                 | �� ����ȭ ���� ���̺�                                    
-- �ŷ�óȸ���, ȸ����ȭ               |
SELECT �ŷ�óȸ���, ȸ����ȭ           | SELECT �ŷ�óȸ���, ȸ����ȭ
FROM ȸ��;                              | FROM �ŷ�ó����;
--> 3 * 40 Byte                         | --> 200�� * 70 Byte
                                        
-- �ŷ�ó������, ����                   | 
SELECT �ŷ�ó������, ����               | SELECT �ŷ�ó������, ����
FROM ����;                              | FROM �ŷ�ó����;
--> 200�� * 50 Byte                     | --> 200�� * 70 Byte


-- �ŷ�óȸ���, �ŷ�ó������           | 
SELECT A.�ŷ�óȸ���, B.�ŷ�ó������   | SELECT �ŷ�óȸ���, �ŷ�ó������
FROM ȸ�� A JOIN ���� B                 | FROM �ŷ�ó����;
ON A.ȸ��ID = B.ȸ��ID ;                |  --> 200�� * 70 Byte
--> (3 * 40 Byte) + (200�� * 50 Byte)

*/




-- ���̺�� : �ֹ�
/*
--------------------------------------------------------------------------------
  ��ID                 ��ǰ�ڵ�                �ֹ�����           �ֹ�����
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                     (P.K)
--------------------------------------------------------------------------------
 KIK1174(���α�)      P-KKBK(�ܲʹ��)     2022-04-30 13:50:23         10
 KYL8335(������)      P-KKBC(����Ĩ)       2022-04-30 14:23:11         20
 MCW3235(������)      P-KKDS(��ũ�ٽ�)     2022-05-11 16:14:37         12
 CHH3235(������)      P-SWKK(�����)       2022-05-12 10:32:48         12
                            :
                            :

--------------------------------------------------------------------------------
*/

--�� �ϳ��� ���̺� �����ϴ� PRIMARY KEY �� �ִ� ������ 1���̴�
--   ������, PRIMARY KEY �� �̷��(�����ϴ�) �÷��� ������ ����(������)�� ���� �����ϴ�
--   �÷� 1���θ� ������ PRIMARY KEY �� SINGLE PRIMARY KEY ��� �θ���
--   (���� �����̸Ӹ� Ű)
--   �� �� �̻��� �÷����� ������ PRIMARY KEY �� COMPOSITE PRIMARY KEY ��� �θ���
--   (���� �����̸Ӹ� Ű)


-- �� 2 ����ȭ��... 
--> �� 1 ����ȭ�� ��ģ ��������� PRIMARY KEY �� SINGLE COLUMN �̶��
--  �� 2 ����ȭ�� �������� �ʴ´�.
--  ������ Primary KEY �� COMPOSITION COLUMN �̶��
--  �ݡڵ�ڽ� �� 2 ����ȭ�� �����ؾ� �Ѵ�. 


--> �ĺ��ڰ� �ƴ� �÷��� �ĺ��� ��ü �÷��� ���� �������̾�� �ϴµ�
--  �ĺ��� ��ü �÷��� �ƴ� �Ϻ� �ĺ��� �÷��� ���ؼ��� �������̶��
--  �̸� �и��Ͽ� ���ο� ���̺��� �������ش�. 
--  �� ������ �� 2 ����ȭ�� �Ѵ�

/*
-- ���̺�� : ���� �� �θ� ���̺�
--------------------------------------------------------------------------------------
�����ȣ    �����     ������ȣ     �����ڸ�    ���ǽ��ڵ�   ���ǽǼ���
++++++++               ++++++++
   (     PRIMARY KEY     )
--------------------------------------------------------------------------------------
J0101      �ڹٱ���       21        ������ó       A301      ����ǽ��� 3�� 30�� �Ը�
J0102      �ڹ��߱�       22        �׽���         T502      ���ڰ��а� 5�� 60�� �Ը�
03090      ����Ŭ�߱�     22        �׽���         A201      ����ǽ��� 2�� 30�� �Ը�
03010      ����Ŭ��ȭ     10        �念��         T502      ���ڰ��а� 5�� 60�� �Ը�
J3342      JSP����        20        �ƽ���         K101      �ι���ȸ�� 1�� 90�� �Ը�
                                        :
                                        :
--------------------------------------------------------------------------------------


-- ���̺�� : ���� �� �ڽ� ���̺�
--------------------------------------------------
�����ȣ    ������ȣ         �й�          ����
====================
    FORIGN KEY
++++++++                     +++++
    (        PRIMARY KEY       )
--------------------------------------------------
03090          22       2209130(���¹�)     92
03090          22       2209142(������)     80
03090          22       2209115(�ֳ���)     96
                     :
                     :
--------------------------------------------------

������ �и��Ѵ� �����ͼ��� �޸� ���� ���� ���ؼ� �ϳ��� ���̺��� �ĺ��ڸ� ���� ���̺�� ������ �� 
�θ����̺�� �ڽ����̺��� ����� ��Ÿ���� �����޴� �÷��� �ڽ����̺��� �����ϴ� �÷��� �ȴ�
�θ� ���̺��� �����޴� �÷��� Ư¡ 1. ������ ���´�(= �ߺ��� �����) 2. NOT NULL
�̰� ������ 2����ȭ �ؾ� �Ѵ�. �� ���� PRIMARY KEY�� ���� �����ϰ� �Ѿ�Դ�.
�� ���̺� �� ������ �� �� �ִ�. �����̸Ӹ�Ű�� ���� ���� �� �� �ִ�. �ϳ��� �����ϴ� �÷���
���� �÷��� �����ϴ�. �÷��� �ϳ��̸� ���� �����̸Ӹ� Ű �÷��� �� �� �̻� ���� �� �� ��� ����
�����̸Ӹ� Ű��� �θ���. 1����ȭ ����� ���� �����̸Ӹ�Ű�� �ʿ������ �����̶�� 2����ȭ �ؾ��Ѵ�.
�ĺ��� ��ü �÷��� �������̾�� �ϴµ� 
�Ϻ� �ĺ��ڿ��Ը� �������̶�� ....
���� ��� ������� �����ȣ���� �������̴�. �����ڸ��� �����ڹ�ȣ���� �������̴�. 
�� ���� �и��ؼ� ���ο� ���̺��� ������־�� �Ѵ�. �̰��� �� 2 ����ȭ



�� �� 3 ����ȭ

�ĺ��ڰ� �ƴ� �÷��� �ĺ��ڰ� �ƴ� �÷��� �������� ��Ȳ�̶��
�̸� �и��Ͽ� ���ο� ���̺��� �������־�� �Ѵ�.
�� ������ �� 3 �������̶� �Ѵ�


�� ����(Relation) �� ����
-- 1 : �ټ� �� ����
--> �� 1 ����ȭ�� �����Ͽ� ������ ��ģ ��������� ��Ÿ���� �ٶ����� ����
--  ������ �����ͺ��̽��� Ȱ���ϴ� �������� �߱��ؾ� �ϴ� ����

-- 1 : 1 �� ����
--> ����, ���������� ������ �� �ִ� �����̱� ������
--  ������ �����ͺ��̽� ���� �������� �������̸� ���ؾ� �� ����

-- �ټ� : �ټ� �� ����
--> ������ �𵨸����� ������ �� ������, 
    (�Ӹ��� �����غ��� ������ �� ������ �غ����� �ϸ� �� ��)
--  ���� �������� �𵨸������� ������ �� ���� ����


 - ���̺�� : ��                           - ���̺�� : ��ǰ
-------------------------------------    ------------------------------------------------
����ȣ  ����   �̸���    ��ȭ��ȣ     ��ǰ��ȣ   ��ǰ��  ��ǰ�ܰ�  ��ǰ����
++++++++                                  ++++++++
=====================================    ================================================
 1001     ����  abc@tes...  010-1        pswk      �����     500    ���찡 ����ִ�
 1002     ���α�  bcd@tes...  010-2        pkjk      ���ڱ�     600    ���ڰ� ����ִ�
 1003     ���¹�  cde@tes...  010-3        pkkm      ������   700    ������ ����ִ�
 1004     ������  def@tes...  010-4        pjkc      �ڰ�ġ     400    �ڰ��� ����ִ�
            :                                           :
-------------------------------------    ------------------------------------------------


 - ���̺�� : �ֹ�����(�Ǹ�)
--------------------------------------------------------
�ֹ���ȣ   ����ȣ    ��ǰ��ȣ    �ֹ�����    �ֹ�����
           ++++++++    +++++++++
========================================================
   27        1001       pswk      2022-06~..      10
   28        1001       pkjk      2022-06~..      30
   29        1001       pjkc      2022-06~..      20
   30        1002       pswk      2022-06~..      20
   31        1002       pswk      2022-06~..      50
                          :
--------------------------------------------------------
   
�� 4 ����ȭ : 
  ������ Ȯ���� ����� ���� '�� : �� ����' �� 
  '1 : �� ����' �� ���߸��� ������ �� 4 ����ȭ�� ���� �����̴�.
  �� �Ϲ������� �Ļ� ���̺� ���� �� �� : �� ���踦 1 : �� ����� ���߸��� ���� ����

  '1 : 1' �� �� ������ ��κ� ���ؾ��Ѵ�
  '1 : ��' �� ���� �̻����̴�, '1 : ��' �л��� ���� ���̿� ������û ���� ��4����ȭ�̴�.    
*/

/*
�� ������ȭ (������ȭ)

--==>> A ��� �� ������ȭ�� �������� �ʴ� ���� �ٶ����� ���

-- ���̺�� : �μ�            -- ���̺�� : ���
   10Byte     10    10          10      10     10   10    10      10         10
--------------------------   ------------------------------------------- + -------
-- �μ���ȣ �μ��� �ּ�       �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ    �μ���
--------------------------   ------------------------------------------- + -------
--   10 �� ���ڵ�(��)                  1,000,000 �� ���ڵ�(��)
--------------------------   ------------------------------------------- + -------

--> ��ȸ �����
---------------------------
-- �μ��� ����� ���� �޿�
---------------------------

--> '�μ�' ���̺�� '���' ���̺��� JOIN ���� ���� ũ��
--  (10 * 30 Byte) + (1,000,000 * 60 Byte) = 300 + 60,000,000 = 60,000,300 Byte

--> '���' ���̺��� ������ȭ �� �� �� ���̺� �о�� ���� ũ��
--  ��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���
--  1,000,000 * 70 Byte = 70,000,000 Byte




--==>> B ��� �� ������ȭ�� �����ϴ� ���� �ٶ����� ���

-- ���̺�� : �μ�            -- ���̺�� : ���
   10Byte     10    10          10      10     10   10    10      10         10
--------------------------   ------------------------------------------- + -------
-- �μ���ȣ �μ��� �ּ�       �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ    �μ���
--------------------------   ------------------------------------------- + -------
-- 500,000 �� ���ڵ�(��)                  1,000,000 �� ���ڵ�(��)
--------------------------   ------------------------------------------- + -------

--> ��ȸ �����
---------------------------
-- �μ��� ����� ���� �޿�
---------------------------

--> '�μ�' ���̺�� '���' ���̺��� JOIN ���� ���� ũ��
--  (500,000 * 30 Byte) + (1,000,000 * 60 Byte) = 15,000,000 + 60,000,000 = 71,000,000 Byte

--> '���' ���̺��� ������ȭ �� �� �� ���̺� �о�� ���� ũ��
--  ��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���
--  1,000,000 * 70 Byte = 70,000,000 Byte
--  ������ȭ�� ���� ���� JOIN ���� ������ ���̺��� �����ϴ� �޸� ũ�Ⱑ �۴�.
--  �̷� ������ ������ȭ�� ���� ������ ���� �ܼ��� �������ش�.
*/

--�� 
/*
1. ����(Relationship, relation)
    - ��� ��Ʈ��(entry)�� ���ϰ��� ������
    - �� �� (column)�� ������ �̸��� ������ ������ ���ǹ��ϴ�
    - ���̺��� ��� ��(row==Ʃ��==tuple)�� �������� ������ ������ ���ǹ��ϴ�
    
2. �Ӽ�(Attribute)
    - ���̺��� ��(column)�� ��Ÿ����.
    - �ڷ��� �̸��� ���� �ּ� ���� ���� : ��ü�� ����, ���� ���
    - �Ϲ� ����(file)�� �׸�(������==item==�ʵ�==field)�� �ش��Ѵ�
    - ��ƼƼ(entity)�� Ư���� ���¸� ���
    - �Ӽ�(Atrribute)�� �̸��� ��� �޶�� �Ѵ�.
    
3. Ʃ��(tuple)
    - ���̺��� ��(row==��ƼƼ=entity)
    - ������ �� ���� �Ӽ�(attribute) ���� ����
    - ���� ���� ����
    - �Ϲ� ����(file)�� ���ڵ�(record)�� �ش��Ѵ�
    - Ʃ�ú���(tuple variable)
        : Ʃ��(tuple)�� ����Ű�� ����, ��� Ʃ�� ������ ���������� �ϴ� ����
    
4. ������(domain)
    - �� �Ӽ�(attribute)�� ���� �� �ֵ��� ���� ������ ����
    - �Ӽ� ��� ������ ���� �ݵ�� ������ �ʿ�� ����
    - ��� �����̼ǿ��� ��� �Ӽ����� �������� ������(atomic)�̾�� ��
    - ������ ������.
        : �������� ���Ұ� �� �̻� �������� �� ���� ����ü�� ���� ��Ÿ��
    
5. �����̼�(relation)
    - ���� �ý��ۿ��� ���ϰ� ���� ����
    - �ߺ��� Ʃ��(tuple==entity==��ƼƼ)�� �������� �ʴ´� �� ��� ������(Ʃ���� ���ϼ�)
    - �����̼� = Ʃ��(��ƼƼ==entity)�� ����, ���� Ʃ���� ������ ���ǹ��ϴ�.
    - �Ӽ�(attribute) ������ ������ ����
*/


--------------------------------------------------------------------------------
/*
--���� ���Ἲ(Intergrity) ����--
1. ���Ἲ���� ��ü ���Ἲ(Entity Intergrity) 
              ���� ���Ἲ(Relational Intergrity)
              ������ ���Ἲ(Domain Intergrity) �� �ִ�.

2. ��ü ���Ἲ(Entity Intergrity) 
   ��ü ���Ἲ�� �����̼ǿ��� ����Ǵ� Ʃ��(tuple)�� 
   ���ϼ��� �����ϱ� ���� ���������̴�. 

3. ���� ���Ἲ(Relational Intergrity)
   ���� ���Ἲ�� �����̼� ���� ������ �ϰ����� �����ϱ� ���� ���������̴�. 

4. ������ ���Ἲ(Domain Intergrity) 
   ��ĳ����Ÿ������ 10�� ��� �׷��� �� �ȿ����� �Է°���
   ������ ���Ἲ�� ��� ������ ���� ������ �����ϱ� ���� ���������̴�

5. ���������� ����

    - PRIMARY KEY(PK or P) �θ����̺��� �����޴� �÷� �� �⺻Ű, ����Ű, �ĺ���, �ĺ���
      �ش� �÷��� �����ݵ�� �����ؾ� �ϸ�, �����ؾ� �Ѵ�.  
      (NOT NULL�� UNIQUE0RK �� ���յ� ����)
    
    - FOREIGN KEY(FK , F, R) �ڽ����̺��� �����ϴ� �÷� �� �ܷ�Ű �ܺ�Ű ����Ű
      �ش� �÷��� ���� �����Ǵ� ���̺��� �÷� �����͵� �� �ϳ��� ��ġ�ϰų� NULL�� ������.
    
    - UNIQUE(UK:U)
      ���̺����� �ش� �÷��� ���� �׻� �����ؾ� �Ѵ�. 
      PRIMARY�� ��� UNIQUE�� NOT NULL�� ������ ��
    
    - NOT NULL(NN:CK,C)üũ���������̴�.
      �ش� �÷��� NULL�� ������ �� ����.(����־ �ȵȴ�)
    
    - CHECK(CK:C)
      �ش� �÷����� ���� ������ �������� ���� ������ ������ ���Ѵ�.
*/

--���� PRIMARY KEY ����--

-- 1. ���̺� ���� �⺻Ű�� �����Ѵ�.

-- 2. ���̺��� �� ���� �����ϰ� �ĺ��ϴ� �÷� �Ǵ� �÷��� �����̴�.
--    �⺻ Ű�� ���̺� �� �ִ� �ϳ��� �����Ѵ�.
--    �׷��� �ݵ�� �ϳ��� �÷����θ� �����Ǵ� ���� �ƴϴ�.
--    NULL�� �� ����, �̹� ���̺� �����ϰ� �ִ� �����͸�
--    �ٽ� �Է��� �� ������ ó���ȴ�
--    UNIQUE INDEX�� �ڵ����� �����ȴ�. (����Ŭ�� ��ü������ �����.)

-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �ķ��� ������Ÿ��[CONSTRAINT CONSTRAINT��] PRIMARY KEY[(�÷���,...)]

-- �� ���̺� ��������N��
-- �÷��� ������Ÿ��
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONTSTRAINT��'PRIMARY KEY(�÷���[,...])

-- 4. CONSTRAINT �߰� �� CONSTRAINT ���� �����ϸ�
-- ����Ŭ ������ �ڵ������� CONTSTRAINT ���� �ο��ϰ� �ȴ�.
-- �Ϲ������� CONSTARINT ���� ���̺��_�÷���_CONSTRAINT ���
-- �������� ����Ѵ�.



--�� PK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST1
(  COL1 NUMBER(5)       PRIMARY KEY
,  COL2 VARCHAR(30)
);
--==>>Table TBL_TEST1��(��) �����Ǿ����ϴ�.


DESC TBL_TEST1;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/


--������ �Է�
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'TEST');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'TEST'); --> ���� �߻�
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'ABCD'); --> ���� �߻�
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(3,NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(COL1) VALUES(4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD'); --> �����߻�
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(5,'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(NULL,NULL); -->�����߻�
INSERT INTO TBL_TEST1(COL2) VALUES('STUDY'); --> �����߻�

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/
DESC TBL_TEST1;

/*
Ŀ�� �Ϸ�.
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
-- ����! NOT NULL �̶�� �� PRIMARY KEY��� �����ƴϴ�



-- �� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	SYS_C004102	            O	EMP_DETAILS_VIEW					            ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME		2014-05-29				
HR	JHIST_DATE_INTERVAL	    C	JOB_HISTORY	        end_date > start_date		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_JOB_NN	        C	JOB_HISTORY	        "JOB_ID" IS NOT NULL		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_END_DATE_NN	    C	JOB_HISTORY	        "END_DATE" IS NOT NULL		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_START_DATE_NN	    C	JOB_HISTORY	        "START_DATE" IS NOT NULL	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				                            :
                            :
*/
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TBL_TEST1';
/* OWNER    CONSTRAINT_NAME     CONSTRAINT_TYPE   TABLE_NAME    SEARCH_CONDITION    R_OWNER
----------------------------------------------------------------------------------------------
    HR	    SYS_C007096	            P	           TBL_TEST1	(null)	             (null)
*/


-- �� ���� ������ ������ �÷�Ȯ��(��ȸ)
SELECT *
FROM USER_CONS_COLUMNS;
--==>>
/*
HR	SYS_C007096	    TBL_TEST1	COL1	    1
HR	REGION_ID_NN	REGIONS	    REGION_ID	
HR	REG_ID_PK	    REGIONS	    REGION_ID	1
HR	LOC_CITY_NN	    LOCATIONS	CITY	
HR	LOC_ID_PK	    LOCATIONS	LOCATION_ID	1
            :
            :
*/


SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME ='TBL_TEST1';
--==>> HR	SYS_C007096	TBL_TEST1	COL1	1

-- �� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>>
/*
HR	REG_ID_PK	    REGIONS	    P	REGION_ID
HR	REGION_ID_NN	REGIONS	    C	REGION_ID
HR	COUNTRY_C_ID_PK	COUNTRIES	P	COUNTRY_ID
HR	COUNTR_REG_FK	COUNTRIES	R	REGION_ID
HR	COUNTRY_ID_NN	COUNTRIES	C	COUNTRY_ID
            :
            :
*/

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST1';
--==>> HR	SYS_C007096	TBL_TEST1	P	COL1
           --============  ����Ŭ�� �ڵ����� �ٿ��� ���������� �̸�



--�� PK ���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)       
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--===>>Table TBL_TEST2��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'TEST');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'TEST'); --> �����߻�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'ABCD'); --> �����߻�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2,'ABCD');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(3,NULL);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST2(COL1) VALUES(4);
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST2(COL1) VALUES(4);
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(5,'ABCD');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(NULL,NULL);-->�����߻�
INSERT INTO TBL_TEST2(COL2) VALUES('KKKKK'); --> �����߻�

COMMIT;

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/

-- �� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST2';
--==>> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1


--�� PK ���� �ǽ�(�� ���� �÷� PK ���� �� ���� �����̸Ӹ� Ű)
-- ���̺� ����
/*
CREATE TABLE TBL_TEST3
(  COL1 NUMBER(5)       
,   COL2 VARCHAR2(30)
,   CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL1)
,   CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL2)
);
*/
--==>> �̷��� �ϸ� �ȵȴ�

CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');    --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'TEST'); --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL); --> �����߻�

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	ABCD
1	TEST
2	ABCD
2	TEST
*/

-- �� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST3';
--==>> �� ���� �������Ǹ�(Ÿ��)�� �Ȱ��⿡ �����̸Ӹ�Ű�� 2���ΰ� �ƴ϶� 1����
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2
*/

--�� PK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰� ����)
-- ���̺� ����
CREATE TABLE TBL_TEST4
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST4��(��) �����Ǿ����ϴ�.

--�� ���� ������ �߰��Ϸ��� �ϴµ� �����ؾ� �� �� 
--   �̹� ����(������� �ִ�) ���̺� 
--   �ο��Ϸ��� ���������� ������ �����Ͱ� ���ԵǾ� ���� ���
--   �ش� ���̺� ���� ������ �߰��ϴ� ���� �Ұ����ϴ�.


-- ���� ���� �߰�
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4��(��) ����Ǿ����ϴ�.

-- �� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1


--�� �������� Ȯ�� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
    ,  UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
    ,  UC.TABLE_NAME "TABLE_NAME"  --���⼭ " TABLE_NAME" �� �̷��� �����ָ� �ȵǴ�������?
    ,  UC.CONSTRAINT_TYPE "CONSTRAINT TYPE"
    ,  UCC.COLUMN_NAME "COLUMN_NAME"
    ,  UC.SEARCH_CONDITION "SEARCH_CONDITION"
    ,  UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW)�� ���� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		

--------------------------------------------------------------------------------

--���� UNIQUE(UK:U) ����--

-- 1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ� ������ �� �ֵ��� �����ϴ� ��������
--    PRIMARY KEY �� ������ ��������������, NULL �� ����Ѵٴ� �������� �ִ�
--    ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ� �����ȴ�
--    �ϳ��� ���̺� ������ UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�
--    ��, �ϳ��� ���̺� UNIQUE ���������� ���� �� ����� ���� �����ϴٴ� ���̴�


-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������ Ÿ��[CONSTRAINT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� UNIQUE(�÷���[, ...])

--�� UK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)      PRIMARY KEY
, COL2  VARCHAR2(30)   UNIQUE
);
--==>>Table TBL_TEST5��(��) �����Ǿ����ϴ�.

-- ���� ���� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007100	TBL_TEST5	P	COL1		
HR	SYS_C007101	TBL_TEST5	U	COL2		
*/

-- ������ �Է�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1, 'TEST'); --> �����߻�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3, 'ABCD'); --> �����߻�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4);
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5, 'ABCD'); --> �����߻�

-- Ȯ��
SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/


--�� UK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>> 
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/

--�� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> ��ȸ ��� ����

-- �������� �߰�
/*
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
        +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);
        ��
*/
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>> Table TBL_TEST7��(��) ����Ǿ����ϴ�.


-- �������� �߰� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/


--------------------------------------------------------------------------------
--���� CHECK(CK:C) ����--

-- 1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������
--    �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ��� �Ѵ�
--    ����, �÷����� �����Ǵ� �����͸� �˻��Ͽ� ���ǿ� �´� �����ͷ� �����Ǵ� �͸� 
--    ����ϴ� ����� �����ϰ� �ȴ�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
--    �÷��� ������Ÿ��[CONSTRAINT CONSTRAINT��] CHECK (�÷�����)

-- �� ���̺� ������ ����
--    �÷��� ������Ÿ��,
--    �÷��� ������Ÿ��, 
--    CONSTRAINT CONSTRAINT�� CHECK(�÷�����)


-- �� CK ���� �ǽ�( �� �÷� ������ ����  )
-- ���̺� ����
CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)      PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)      CHECK (COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST8��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(1,'������',100);
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(1,'������',100);   --> �����߻�
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'������',101);   --> �����߻�
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'������',-1);    --> �����߻�
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'������',80);


-- Ȯ��
SELECT *
FROM TBL_TEST8;
--==>> 
/*
1	������	100
2	������	80
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


-- ���� ���� �Ϸ�
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007106	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	 (null)
HR	SYS_C007107	TBL_TEST8	P	COL1	(null)                   (null)	
*/

--�� CK �����ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TESE9_COL2_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'������',100);
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'������',100);   --> �����߻�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'������',101);   --> �����߻�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'������',-1);    --> �����߻�
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'������',80);


-- Ȯ��
SELECT *
FROM TBL_TEST9;
--==>> 
/*
1	������	100
2	������	80
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


-- ���� ���� �Ϸ�
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TESE9_COL2_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	 (null)	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1	(null)                   (null)
*/


-- �� CK ���� �ǽ� ( �� ���̺� ���� ���� �������� �߰� �� CK �������� �߰�  )
-- ���̺� ����
CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==>>Table TBL_TEST10��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST10';
--==>> ��ȸ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1) 
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>> Table TBL_TEST10��(��) ����Ǿ����ϴ�.

-- ���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/



-- �� TBL_TESTMEMBER ���̺��� SSN�÷�(�ֹι�ȣ �÷�)���� 
-- ������ �Է��̳� ���� ��, ������ ��ȿ�� �����͸� �Էµ� �� �ֵ��� 
-- üũ ���������� �߰��� �� �ֵ��� �Ѵ�.
-- (�� �ֹι�ȣ Ư�� �ڸ��� �Է� ������ �����ͷ� 1, 2, 3, 4 �� �����ϵ��� ó��)
-- ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ��� �Ѵ�.
CREATE TABLE TBL_TESTMEMBER
( SID  NUMBER
, NAME VARCHAR(30)
, SSN  CHAR(14)           -- �Է����� 'YYMMDD-NNNNNNN'
, TEL  VARCHAR2(40)
);
--==> Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

-- ������ Ȯ��
SELECT *
FROM TBL_TESTMEMBER;

-- �������� �߰�
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID) 
--    , CONSTRAINT TESTMEMBER_SSN_CK CHECK( SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4') )
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK( (SUBSTR(SSN, 8, 1) BETWEEN 1 AND 4) ) );
--==>> Table TBL_TESTMEMBER��(��) ����Ǿ����ϴ�.

-- ���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TESTMEMBER';
--==>>
/*
HR	TBL_TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TBL_TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	 (SUBSTR(SSN, 8, 1) BETWEEN 1 AND 4) 	
*/

-- ������ �Է�
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(1,'���ҿ�','941124-2234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(2,'�ֵ���','950222-1234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(3,'������','040601-3234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(4,'������','050215-4234567','010-4444-4444');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(5,'�ڿ���','980301-5234567','010-5555-5555'); --> �����߻� SSN �����ʰ�
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(6,'������','990729-6234567','010-6666-6666'); --> �����߻� SSN �����ʰ�

-- �������� �߰� �� ������ �Է� �� ������ Ȯ��
SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	���ҿ�	941124-2234567	010-1111-1111
2	�ֵ���	950222-1234567	010-2222-2222
3	������	040601-3234567	010-3333-3333
4	������	050215-4234567	010-4444-4444
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

--------------------------------------------------------------------------------
--���� FOREIGN KEY(FK:F:R) ����--

-- 1. ���� Ű(R) �Ǵ� �ܷ� Ű(FK:F)�� �� ���̺��� ������ �� ������ �����ϰ�
--    ���� �����Ű�µ� ���Ǵ� ���̴�. �� ���̺��� �⺻ �� ����
--    �ִ� ���� �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
--    �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ� Ű�� �ȴ�.

-- 2. �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--    �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�) �� �����Ǿ�� �Ѵ�.
--    �� ��, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.

-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                    REFERENCES �������̺��(�����÷���)
--                   [ON DELETE CASCADE | ON DELETE SEL NULL] �� �߰� �ɼ�
                
                
-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��
-- �÷��� ������Ÿ��
-- CONSTRAINT CONSTRAINT�� FOREIGN KEY (�÷���)
--            REFERENCES �������̺��(�����÷���)
--            [ON DELETE CASCADE | ON DELETE SEL NULL] �� �߰� �ɼ�


-- �� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ��� 
--    �������� �ϳ��� ���̺��� �����Ͽ� ó���ϴ� ���� �ƴ϶�
--    �θ� ���̺� ���� �۾��� ���� �����ؾ� �Ѵ�.
--    �׸��� �̶�, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ����������
--    ������ �÷��� �����ؾ� �Ѵ�.


-- �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>>Table TBL_JOBS��(��) �����Ǿ����ϴ�.

-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '����');

SELECT *
FROM TBL_JOBS;
--==>>
/*
1   ���
2   �븮
3   ����
4   ����
*/

COMMIT;
-- Ŀ�� �Ϸ�.



--��FK ���� �ǽ�(���÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_EMP1
( SID  NUMBER         PRIMARY KEY
, NAME VARCHAR2(30)
, JIKWI_ID NUMBER    REFERENCES TBL_JOBS(JIKWI_ID) --
);
--==>>Table TBL_EMP1��(��) �����Ǿ����ϴ�.

--NUMBER ���� ���������� ���Ѵٸ� NUMBER�� ǥ�������� �پ��ٴ� �Ű�
--CHAR ���� ���������� ���Ѵٸ� 1���� ���ڸ� �ǹ��Ѵ�.


--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	SYS_C007116	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (1, '���̰�', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (2, '�ֳ���', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (3, '������', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (4, '������', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (5, '����', 5);--==>> �����߻� 5�� ������ ����
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (5, '����', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES (6, '���¹�');

SELECT *
FROM TBL_EMP1;
--==>>
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	4
5	����	1
6	���¹�	(null)
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.



-- �� FK ���� �ǽ�(�� ���̺� ������ ����)

-- ���̺� ����
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
            REFERENCES TBL_JOBS(JIKWI_ID)
);

--==>Table TBL_EMP2��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	            P	SID		
HR	EMP2_JIKWI_ID_FK	    TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--�� FK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.

-- ���� ���� �߰�
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- ���� ���� ����
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- ���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

-- �ٽ� ���� ���� �߰�
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �ٽ� ���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 
/*
HR	EMP3_SID_PK	TBL_EMP3	            P	SID		
HR	EMP3_JIKWI_ID_FK	    TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


/*
 4. FOREIGNKEY ���� �� ���ǻ���
     �����ϰ��� �ϴ� �θ� ���̺��� ���� �����ؾ� �Ѵ�.
     �����ϰ��� �ϴ� �÷��� PRIMARY KEY �� UNIQUE ���������� �����Ǿ� �־�� �Ѵ�.
     ���̺� ���̿� PRIMARY KEY �� FOREIGN KEY �� ���ǵǾ� ������
     PRIMARY KEY ���������� ������ ������ ���� �� 
     FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.   
     (��, �ڽ� ���̺� �����ϴ� ���ڵ尡 ������ ���,
      �θ� ���̺��� �����޴� �ش� ���ڵ�� ������ �� ���ٴ� ���̴�.)
     ��, FK ���� �������� ON DELETE CASCADE �� ON DELETE SET NULL �ɼ��� 
     ����Ͽ� ������ ��쿡�� ������ �����ϴ�.
     ����, �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ� �Ѵ�. 
*/

-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
4	����
*/


-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	4
5	����	1
6	���¹�	(null)
*/


-- �θ� ���̺� ���� �õ�
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     ORA-02449: unique/primary keys in table referenced by foreign keys


-- �θ� ���̺��� ���� ���� ���� �õ�
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--=>> 4	����

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--=>> ���� �߻�
--    ORA-02292: integrity constraint (HR.SYS_C007116) violated - child record found


-- ������ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	1
5	����	1
6	���¹�	(null)
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �θ� ���̺�(TBL_JOBS) �� ���� �����͸� �����ϰ� �ִ�
-- �ڽ� ���̺�(TBL_EMP1) �� �����Ͱ� �������� �ʴ� ��Ȳ

-- �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
-- ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �θ� ���̺�(TBL_JOBS) �� ��� ������ ����
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1	���

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> ���� �߻�
--     ORA-02292: integrity constraint (HR.SYS_C007116) violated - child record found
--     ���� ���⼭ ������ �ȶ߰� ��� �����Ͱ� �����Ǹ�
--     ��� �����Ϳ� ����� ��� (ȸ��)������ �����Ǳ⿡ ���� �ߴ°� ������ ������ ���̴�


--�� �θ� ���̺��� �����͸� �����Ӱ�(?) �����ϱ� ���ؼ���
--   ON DELETE CASCADE �ɼ� ������ �ʿ��ϴ�

-- TBL_EMP1 ���̺�(�ڽ� ���̺�) ���� FK ���������� ������ ��
-- CASCADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	SYS_C007116	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/


-- ���� ���� ����
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007116;
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- ���� ���� ���� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>> HR	SYS_C007115	TBL_EMP1	P	SID		


-- ON DELETE CASCADE �ɼ��� ���Ե� �������� �������� �ٽ� ����
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- �������� ���� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

--�� CASCADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�
--   ��, �θ� ���̺��� �����Ͱ� ������ ���
--   �̸� �����ϴ� �ڽ� ���̺��� �����͵� ��� �Բ� �����ȴ� 

-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
*/


-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	1
5	����	1
6	���¹�	(null)
*/


-- �θ� ���̺�(TBL_JOBS) ���� ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	���̰�	1
2	�ֳ���	2
4	������	1
5	����	1
6	���¹�	(null)
*/

-- �θ� ���̺�(TBL_JOBS) ���� ��� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
2	�ֳ���	2
6	���¹�	(null)
*/

DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.
DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     ORA-02449: unique/primary keys in table referenced by foreign keys
--     TBL_EMP1 �� �����־� ���� �Ұ���
DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.
DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.

-- �׷��� CASCADE �� ���� ��????  --==>> �����̶� ��