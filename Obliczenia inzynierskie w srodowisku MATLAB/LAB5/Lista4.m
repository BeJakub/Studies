   A       =       [   0       1   0   0   ]   ;      
   B       =       [   1   0   0       1   0   0   ]   ;      
   C       =       [   1   0   0       0   ]   ;      
   D       =       [   0       0   ]   ;      
   N   =   5   1   0   ;      
   k   r   o   k   =       0   .   9   ;      
      
   w   e   k   t   o   r   _   s   t   a   n   u   =   z   e   r   o   s   (   8   ,   1   )   ;          
   d   r   o   g   a   A   =   z   e   r   o   s   (   N   ,   2   )   ;      
   d   r   o   g   a   B   =   z   e   r   o   s   (   N   ,   2   )   ;      
   d   r   o   g   a   C   =   z   e   r   o   s   (   N   ,   2   )   ;      
   d   r   o   g   a   D   =   z   e   r   o   s   (   N   ,   2   )   ;      
      
   f   o   r       i   =   1   :   N      
                   A   (   1   )   =   A   (   1   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   1   )   ;      
                   A   (   2   )   =   A   (   2   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   2   )   ;      
      
                   d   r   o   g   a   A   (   i   ,   1   )   =   (   A   (   1   )   )   ;      
                   d   r   o   g   a   A   (   i   ,   2   )   =   (   A   (   2   )   )   ;      
      
                   V   =   [   B   (   1   )   -   A   (   1   )       ,       B   (   2   )   -   A   (   2   )   ]   ;      
                   n   o   r   m   a   =   n   o   r   m   (   V   )   ;      
      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   1   )   =   V   (   1   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   2   )   =   V   (   2   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                      
                   B   (   1   )   =   B   (   1   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   3   )   ;      
                   B   (   2   )   =   B   (   2   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   4   )   ;      
      
                   d   r   o   g   a   B   (   i   ,   1   )   =   B   (   1   )   ;      
                   d   r   o   g   a   B   (   i   ,   2   )   =   B   (   2   )   ;      
      
                   V   =   [   C   (   1   )   -   B   (   1   )       ,       C   (   2   )   -   B   (   2   )   ]   ;      
                   n   o   r   m   a   =   n   o   r   m   (   V   )   ;      
      
      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   3   )   =   V   (   1   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   4   )   =   V   (   2   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                      
                  
                   C   (   1   )   =   C   (   1   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   5   )   ;      
                   C   (   2   )   =   C   (   2   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   6   )   ;      
      
                   d   r   o   g   a   C   (   i   ,   1   )   =   C   (   1   )   ;      
                   d   r   o   g   a   C   (   i   ,   2   )   =   C   (   2   )   ;      
      
                   V   =   [   D   (   1   )   -   C   (   1   )       ,       D   (   2   )   -   C   (   2   )   ]   ;      
                   n   o   r   m   a   =   n   o   r   m   (   V   )   ;      
      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   5   )   =   V   (   1   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   6   )   =   V   (   2   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                      
                   D   (   1   )   =   D   (   1   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   7   )   ;      
                   D   (   2   )   =   D   (   2   )   +   w   e   k   t   o   r   _   s   t   a   n   u   (   8   )   ;      
      
                   d   r   o   g   a   D   (   i   ,   1   )   =   D   (   1   )   ;      
                   d   r   o   g   a   D   (   i   ,   2   )   =   D   (   2   )   ;      
      
                   V   =   [   A   (   1   )   -   D   (   1   )       ,       A   (   2   )   -   D   (   2   )   ]   ;      
                   n   o   r   m   a   =   n   o   r   m   (   V   )   ;      
      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   7   )   =   V   (   1   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                   w   e   k   t   o   r   _   s   t   a   n   u   (   8   )   =   V   (   2   )   /   n   o   r   m   a       *       k   r   o   k   ;      
                      
                      
   e   n   d          
   p   l   o   t   (   d   r   o   g   a   A   ,   d   r   o   g   a   B   ,   d   r   o   g   a   C   ,   d   r   o   g   a   D   )                                                                                                                                                                                                                                                                                        