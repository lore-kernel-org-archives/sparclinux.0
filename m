From: Kumba <kumba@gentoo.org>
Date: Sat, 03 Jul 2004 18:07:20 +0000
Subject: pte_exprotect
Message-Id: <40E6F5D8.5020902@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Attempting to build a recent 2.6.6/2.6.7 sparc64 kernel w. the PaX 
patch, and I get a compile error due to an undefined reference to 
pte_exprotect.  Doing some digging, this function seems to have gotten 
pulled out of sparc code a way long time ago, around kernel 1.3.4.  It 
also vanished from mips code about a year or so later (Around 2.0.x or 
just shortly before).

I can't find any reasoning in the one patch that removed the function 
that explained its removal, and considering most other archs still seem 
to have it, I'm curious as to why it was pulled.  Ideas?


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
