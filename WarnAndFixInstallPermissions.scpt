FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .aevtoappnull  �   � **** 	 o      ���� 0 argv  ��    k     � 
 
     r         n         4    �� 
�� 
cobj  m    ����   o     ���� 0 argv    o      ���� 0 install_path INSTALL_PATH      l   ��  ��    7 1set INSTALL_PATH to "/Library/Audio/Plug-Ins/HAL"     �   b s e t   I N S T A L L _ P A T H   t o   " / L i b r a r y / A u d i o / P l u g - I n s / H A L "      l   ��������  ��  ��        l   ��������  ��  ��        l   ��  ��      Test path	     �      T e s t   p a t h 	     !   r     " # " =    $ % $ l    &���� & I   �� '��
�� .sysoexecTEXT���     TEXT ' b     ( ) ( b    
 * + * m     , , � - -  t e s t   - d   + o    	���� 0 install_path INSTALL_PATH ) m   
  . . � / / (   & &   e c h o   1   | |   e c h o   0��  ��  ��   % m     0 0 � 1 1  1 # o      ���� 0 
pathexists 
pathExists !  2 3 2 r    " 4 5 4 =     6 7 6 l    8���� 8 I   �� 9��
�� .sysoexecTEXT���     TEXT 9 b     : ; : b     < = < m     > > � ? ?  t e s t   - w   = o    ���� 0 install_path INSTALL_PATH ; m     @ @ � A A (   & &   e c h o   1   | |   e c h o   0��  ��  ��   7 m     B B � C C  1 5 o      ����  0 pathiswritable pathIsWritable 3  D E D l  # #��������  ��  ��   E  F G F Z   # : H I���� H =  # & J K J o   # $���� 0 
pathexists 
pathExists K m   $ %��
�� boovfals I k   ) 6 L L  M N M I   ) 3�� O���� 0 	showerror 	showError O  P�� P b   * / Q R Q b   * - S T S m   * + U U � V V  P a t h   ' T o   + ,���� 0 install_path INSTALL_PATH R m   - . W W � X X " '   d o e s   n o t   e x i s t .��  ��   N  Y�� Y L   4 6����  ��  ��  ��   G  Z [ Z l  ; ;��������  ��  ��   [  \ ] \ Z   ; R ^ _���� ^ =  ; > ` a ` o   ; <����  0 pathiswritable pathIsWritable a m   < =��
�� boovtrue _ k   A N b b  c d c I   A K�� e���� 0 	showerror 	showError e  f�� f b   B G g h g b   B E i j i m   B C k k � l l  P a t h   ' j o   C D���� 0 install_path INSTALL_PATH h m   E F m m � n n , '   i s   a l r e a d y   w r i t a b l e .��  ��   d  o�� o L   L N����  ��  ��  ��   ]  p q p l  S S��������  ��  ��   q  r s r l  S S��������  ��  ��   s  t u t l  S S�� v w��   v   Show dialog    w � x x    S h o w   d i a l o g u  y z y r   S j { | { b   S f } ~ } b   S b  �  b   S ` � � � b   S \ � � � b   S X � � � l 	 S V ����� � m   S V � � � � � 0 I n s t a l l a t i o n   d i r e c t o r y   '��  ��   � o   V W���� 0 install_path INSTALL_PATH � m   X [ � � � � � & '   i s   n o t   w r i t a b l e .   � l 	 \ _ ����� � m   \ _ � � � � � | D o   y o u   w a n t   t o   m a k e   i t   w r i t a b l e   f o r   e v e r y o n e ? 
 ` s u d o   c h m o d   o + w  ��  ��   � o   ` a���� 0 install_path INSTALL_PATH ~ m   b e � � � � � T ` 
 
 C a u t i o n :   T h i s   m i g h t   b e   a   s e c u r i t y   r i s k ! | o      ���� 0 dialogmessage dialogMessage z  � � � l  k k��������  ��  ��   �  � � � r   k � � � � I  k ��� � �
�� .sysodlogaskr        TEXT � l 	 k n ����� � o   k n���� 0 dialogmessage dialogMessage��  ��   � �� � �
�� 
btns � l 
 q y ����� � v   q y � �  � � � m   q t � � � � �  C a n c e l �  ��� � m   t w � � � � �  M a k e   w r i t a b l e��  ��  ��   � �� � �
�� 
dflt � l 
 | } ����� � m   | }���� ��  ��   � �� � �
�� 
disp � l 
 � � ����� � m   � ���
�� stic    ��  ��   � �� ���
�� 
appr � m   � � � � � � �  I n s t a l l   E r r o r��   � o      ���� 0 dialogresult dialogResult �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Get user answer    � � � �     G e t   u s e r   a n s w e r �  � � � r   � � � � � l  � � ����� � =  � � � � � n   � � � � � 1   � ���
�� 
bhit � o   � ����� 0 dialogresult dialogResult � m   � � � � � � �  M a k e   w r i t a b l e��  ��   � o      ���� (0 shouldmakewritable shouldMakeWritable �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Change permissions    � � � � &   C h a n g e   p e r m i s s i o n s �  � � � Z   � � � ����� � =  � � � � � o   � ����� (0 shouldmakewritable shouldMakeWritable � m   � ���
�� boovtrue � I  � ��� � �
�� .sysoexecTEXT���     TEXT � b   � � � � � m   � � � � � � �  c h m o d   o + w   � o   � ����� 0 install_path INSTALL_PATH � �� ���
�� 
badm � m   � ���
�� boovtrue��  ��  ��   �  ��� � l  � ���������  ��  ��  ��     � � � l     ��������  ��  ��   �  � � � i     � � � I      �� ����� 0 showwarning showWarning �  ��� � o      ���� 0 dialogmessage dialogMessage��  ��   � r      � � � I    �� � �
�� .sysodlogaskr        TEXT � l 	    ����� � o     ���� 0 dialogmessage dialogMessage��  ��   � �� � �
�� 
btns � l 
   ���~ � v     � �  ��} � m     � � � � �  O K�}  �  �~   � �| � �
�| 
dflt � l 
   ��{�z � m    �y�y �{  �z   � �x � �
�x 
disp � l 
  	 ��w�v � m    	�u
�u stic   �w  �v   � �t ��s
�t 
appr � m   
  � � � � �  W a r n i n g�s   � o      �r�r 0 dialogresult dialogResult �  � � � l     �q�p�o�q  �p  �o   �  � � � i     � � � I      �n ��m�n 0 	showerror 	showError �  ��l � o      �k�k 0 dialogmessage dialogMessage�l  �m   � r      � � � I    �j � �
�j .sysodlogaskr        TEXT � l 	    ��i�h � o     �g�g 0 dialogmessage dialogMessage�i  �h   � �f � 
�f 
btns � l 
  �e�d v     �c m     �  O K�c  �e  �d    �b
�b 
dflt l 
  �a�` m    �_�_ �a  �`   �^	

�^ 
disp	 l 
  	�]�\ m    	�[
�[ stic    �]  �\  
 �Z�Y
�Z 
appr m   
  � 
 E r r o r�Y   � o      �X�X 0 dialogresult dialogResult � �W l     �V�U�T�V  �U  �T  �W       �S�R�Q�P�O�N�M�S   �L�K�J�I�H�G�F�E�D�C�B�A
�L .aevtoappnull  �   � ****�K 0 showwarning showWarning�J 0 	showerror 	showError�I 0 install_path INSTALL_PATH�H 0 
pathexists 
pathExists�G  0 pathiswritable pathIsWritable�F 0 dialogmessage dialogMessage�E 0 dialogresult dialogResult�D (0 shouldmakewritable shouldMakeWritable�C  �B  �A   �@ �?�>�=
�@ .aevtoappnull  �   � ****�? 0 argv  �>   �<�< 0 argv   %�;�: , .�9 0�8 > @ B�7 U W�6 k m � � � ��5�4 � ��3�2�1�0 ��/�.�-�, ��+ ��*
�; 
cobj�: 0 install_path INSTALL_PATH
�9 .sysoexecTEXT���     TEXT�8 0 
pathexists 
pathExists�7  0 pathiswritable pathIsWritable�6 0 	showerror 	showError�5 0 dialogmessage dialogMessage
�4 
btns
�3 
dflt
�2 
disp
�1 stic    
�0 
appr�/ 
�. .sysodlogaskr        TEXT�- 0 dialogresult dialogResult
�, 
bhit�+ (0 shouldmakewritable shouldMakeWritable
�* 
badm�= ���k/E�O��%�%j � E�O��%�%j � E�O�f  *��%�%k+ OhY hO�e  *��%�%k+ OhY hOa �%a %a %�%a %E` O_ a a a la la a a a a  E` O_ a  ,a ! E` "O_ "e  a #�%a $el Y hOP �) ��(�'�&�) 0 showwarning showWarning�( �%�%   �$�$ 0 dialogmessage dialogMessage�'   �#�"�# 0 dialogmessage dialogMessage�" 0 dialogresult dialogResult 	�! �� ��� ���
�! 
btns
�  
dflt
� 
disp
� stic   
� 
appr� 
� .sysodlogaskr        TEXT�& ���k�k����� E� � ����� 0 	showerror 	showError� ��   �� 0 dialogmessage dialogMessage�   ��� 0 dialogmessage dialogMessage� 0 dialogresult dialogResult 	�������
� 
btns
� 
dflt
� 
disp
� stic    
� 
appr� 
� .sysodlogaskr        TEXT� ���k�k����� E� � 6 / L i b r a r y / A u d i o / P l u g - I n s / H A L
�R boovtrue
�Q boovtrue �  � I n s t a l l a t i o n   d i r e c t o r y   ' / L i b r a r y / A u d i o / P l u g - I n s / H A L '   i s   n o t   w r i t a b l e .   D o   y o u   w a n t   t o   m a k e   i t   w r i t a b l e   f o r   e v e r y o n e ? 
 ` s u d o   c h m o d   o + w   / L i b r a r y / A u d i o / P l u g - I n s / H A L ` 
 
 C a u t i o n :   T h i s   m i g h t   b e   a   s e c u r i t y   r i s k ! �!�

� 
bhit! �""  M a k e   w r i t a b l e�
  
�P boovtrue�O  �N  �M   ascr  ��ޭ