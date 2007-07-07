From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 07 Jul 2007 19:21:47 +0000
Subject: How to fix "BUG spinlock recursion on CPU #0"
Message-Id: <468FE7CB.6010502@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have built a 2.6.22-rc7 on sparc32/smp to debug kernel. The only 
error I see is "BUG spinlock recursion" with call trace. How debug this 
mistake ? How can I find information about spinlock debugging ?

	I have tried to boot with the same kernel and maxcpu=1 option but this 
box ever boots with two CPU's online. How can I force this kernel to 
boot with only one CPU ? Does MAXCPU variable only work on i386 ?

	Regards,

	JKB
