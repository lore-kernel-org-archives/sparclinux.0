From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 03 Jul 2007 09:40:09 +0000
Subject: Portmap 6 (and some other daemons) and 2.6.22-rc7 kernel
Message-Id: <468A1979.1060103@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have tried to install a 2.5-9 libc6 on U2, U60 and U80. All 
workstations ran with 2.6.20.11 linux kernel (from kernel.org and 
without any patch).

	With 2.6.20.11 and libc6-2.3, all workstations ran without any trouble. 
When I have changed libc, I have seen some troubles:
several daemons that use threads randomly enter in sleep mode and don't 
wake up anymore (bind, portmap, clamd, milter-greylist, mimdefang...). I 
have tried to build a 2.6.21.5 and I see the same bug. This morning, I 
have built a 2.6.22-rc7 but this kernel breaks my nis server and doesn't 
fix initial bug.

	This bug with threads support affects all my U60 and U80, but I never 
see the same thing on my U2. All workstations have more than 2 
processors and run SMP-kernel. All i386 and amd64 that run same versions 
of daemons/kernel are ot affected.

	Regards,

	JKB
