From: Stanley Benoit <sbenoit@verizon.net>
Date: Fri, 12 Nov 2004 21:32:21 +0000
Subject: page.h question
Message-Id: <5628F39A-34F2-11D9-A583-000D93B069F6@verizon.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I'm bug squashing(well giving it a go) my Ross Hypersparc and ran into 
this...

<--------------------     snip ------------------------>

/* I have my suspicions... -DaveM */
19 #define PAGE_SIZE    (1UL << PAGE_SHIFT)
20 #else
21 #define PAGE_SIZE    (1 << PAGE_SHIFT)
22 #endif
23 #define PAGE_MASK    (~(PAGE_SIZE-1))
24

<----------- end snip ----------------->

Does anyone know what Dave M. was suspicious about....?



--
Stan Benoit<sbenoit@verizon.net>
http://www.mondorescue.org	
http://troff.nakedsoul.org

