FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .aevtoappnull  �   � **** 	 o      ���� 0 argv  ��    k     � 
 
     l     ��  ��    ( "set INSTALL_PATH to item 1 of argv     �   D s e t   I N S T A L L _ P A T H   t o   i t e m   1   o f   a r g v      r         m        �   6 / L i b r a r y / A u d i o / P l u g - I n s / H A L  o      ���� 0 install_path INSTALL_PATH      l   ��������  ��  ��        l   ��������  ��  ��        l   ��  ��      Test path	     �      T e s t   p a t h 	       r     ! " ! =    # $ # l    %���� % I   �� &��
�� .sysoexecTEXT���     TEXT & b    	 ' ( ' b     ) * ) m     + + � , ,  t e s t   - d   * o    ���� 0 install_path INSTALL_PATH ( m     - - � . . (   & &   e c h o   1   | |   e c h o   0��  ��  ��   $ m     / / � 0 0  1 " o      ���� 0 
pathexists 
pathExists    1 2 1 r     3 4 3 =    5 6 5 l    7���� 7 I   �� 8��
�� .sysoexecTEXT���     TEXT 8 b     9 : 9 b     ; < ; m     = = � > >  t e s t   - w   < o    ���� 0 install_path INSTALL_PATH : m     ? ? � @ @ (   & &   e c h o   1   | |   e c h o   0��  ��  ��   6 m     A A � B B  1 4 o      ����  0 pathiswritable pathIsWritable 2  C D C l     ��������  ��  ��   D  E F E Z     7 G H���� G =    # I J I o     !���� 0 
pathexists 
pathExists J m   ! "��
�� boovfals H k   & 3 K K  L M L I   & 0�� N���� 0 	showerror 	showError N  O�� O b   ' , P Q P b   ' * R S R m   ' ( T T � U U  P a t h   ' S o   ( )���� 0 install_path INSTALL_PATH Q m   * + V V � W W " '   d o e s   n o t   e x i s t .��  ��   M  X�� X L   1 3����  ��  ��  ��   F  Y Z Y l  8 8��������  ��  ��   Z  [ \ [ Z   8 O ] ^���� ] =  8 ; _ ` _ o   8 9����  0 pathiswritable pathIsWritable ` m   9 :��
�� boovtrue ^ k   > K a a  b c b I   > H�� d���� 0 	showerror 	showError d  e�� e b   ? D f g f b   ? B h i h m   ? @ j j � k k  P a t h   ' i o   @ A���� 0 install_path INSTALL_PATH g m   B C l l � m m , '   i s   a l r e a d y   w r i t a b l e .��  ��   c  n�� n L   I K����  ��  ��  ��   \  o p o l  P P��������  ��  ��   p  q r q l  P P��������  ��  ��   r  s t s l  P P�� u v��   u   Show dialog    v � w w    S h o w   d i a l o g t  x y x r   P g z { z b   P c | } | b   P _ ~  ~ b   P ] � � � b   P Y � � � b   P U � � � l 	 P S ����� � m   P S � � � � � 0 I n s t a l l a t i o n   d i r e c t o r y   '��  ��   � o   S T���� 0 install_path INSTALL_PATH � m   U X � � � � � & '   i s   n o t   w r i t a b l e .   � l 	 Y \ ����� � m   Y \ � � � � � | D o   y o u   w a n t   t o   m a k e   i t   w r i t a b l e   f o r   e v e r y o n e ? 
 ` s u d o   c h m o d   o + w  ��  ��    o   ] ^���� 0 install_path INSTALL_PATH } m   _ b � � � � � T ` 
 
 C a u t i o n :   T h i s   m i g h t   b e   a   s e c u r i t y   r i s k ! { o      ���� 0 dialogmessage dialogMessage y  � � � l  h h��������  ��  ��   �  � � � r   h � � � � I  h ��� � �
�� .sysodlogaskr        TEXT � l 	 h k ����� � o   h k���� 0 dialogmessage dialogMessage��  ��   � �� � �
�� 
btns � l 
 n v ����� � v   n v � �  � � � m   n q � � � � �  C a n c e l �  ��� � m   q t � � � � �  M a k e   w r i t a b l e��  ��  ��   � �� � �
�� 
dflt � l 
 y z ����� � m   y z���� ��  ��   � �� � �
�� 
disp � l 
 } � ����� � m   } ���
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
   ����� � v     � �  ��� � m     � � � � �  O K��  ��  ��   � � � �
� 
dflt � l 
   ��~�} � m    �|�| �~  �}   � �{ � �
�{ 
disp � l 
  	 ��z�y � m    	�x
�x stic   �z  �y   � �w ��v
�w 
appr � m   
  � � � � �  W a r n i n g�v   � o      �u�u 0 dialogresult dialogResult �  � � � l     �t�s�r�t  �s  �r   �  � � � i     � � � I      �q ��p�q 0 	showerror 	showError �  ��o � o      �n�n 0 dialogmessage dialogMessage�o  �p   � r      � � � I    �m � �
�m .sysodlogaskr        TEXT � l 	    ��l�k � o     �j�j 0 dialogmessage dialogMessage�l  �k   � �i � �
�i 
btns � l 
   �h�g  v     �f m     �  O K�f  �h  �g   � �e
�e 
dflt l 
  �d�c m    �b�b �d  �c   �a	
�a 
disp l 
  	
�`�_
 m    	�^
�^ stic    �`  �_  	 �]�\
�] 
appr m   
  � 
 E r r o r�\   � o      �[�[ 0 dialogresult dialogResult � �Z l     �Y�X�W�Y  �X  �W  �Z       �V �U�T�S�R�Q�P�V   �O�N�M�L�K�J�I�H�G�F�E�D
�O .aevtoappnull  �   � ****�N 0 showwarning showWarning�M 0 	showerror 	showError�L 0 install_path INSTALL_PATH�K 0 
pathexists 
pathExists�J  0 pathiswritable pathIsWritable�I 0 dialogmessage dialogMessage�H 0 dialogresult dialogResult�G (0 shouldmakewritable shouldMakeWritable�F  �E  �D   �C �B�A�@
�C .aevtoappnull  �   � ****�B 0 argv  �A   �?�? 0 argv   % �> + -�= /�< = ? A�; T V�: j l � � � ��9�8 � ��7�6�5�4 ��3�2�1�0 ��/ ��.�> 0 install_path INSTALL_PATH
�= .sysoexecTEXT���     TEXT�< 0 
pathexists 
pathExists�;  0 pathiswritable pathIsWritable�: 0 	showerror 	showError�9 0 dialogmessage dialogMessage
�8 
btns
�7 
dflt
�6 
disp
�5 stic    
�4 
appr�3 
�2 .sysodlogaskr        TEXT�1 0 dialogresult dialogResult
�0 
bhit�/ (0 shouldmakewritable shouldMakeWritable
�. 
badm�@ ��E�O��%�%j � E�O��%�%j � E�O�f  *��%�%k+ OhY hO�e  *��%�%k+ OhY hOa �%a %a %�%a %E` O_ a a a la la a a a a  E` O_ a  ,a ! E` "O_ "e  a #�%a $el Y hOP �- ��,�+�*�- 0 showwarning showWarning�, �)�)   �(�( 0 dialogmessage dialogMessage�+   �'�&�' 0 dialogmessage dialogMessage�& 0 dialogresult dialogResult 	�% ��$�#�"�! �� �
�% 
btns
�$ 
dflt
�# 
disp
�" stic   
�! 
appr�  
� .sysodlogaskr        TEXT�* ���k�k����� E� � ����� 0 	showerror 	showError� ��   �� 0 dialogmessage dialogMessage�   ��� 0 dialogmessage dialogMessage� 0 dialogresult dialogResult 	�������
� 
btns
� 
dflt
� 
disp
� stic    
� 
appr� 
� .sysodlogaskr        TEXT� ���k�k����� E�
�U boovtrue
�T boovfals �� I n s t a l l a t i o n   d i r e c t o r y   ' / L i b r a r y / A u d i o / P l u g - I n s / H A L '   i s   n o t   w r i t a b l e .   D o   y o u   w a n t   t o   m a k e   i t   w r i t a b l e   f o r   e v e r y o n e ? 
 ` s u d o   c h m o d   o + w   / L i b r a r y / A u d i o / P l u g - I n s / H A L ` 
 
 C a u t i o n :   T h i s   m i g h t   b e   a   s e c u r i t y   r i s k ! ��
� 
bhit �  M a k e   w r i t a b l e�  
�S boovtrue�R  �Q  �P  ascr  ��ޭ