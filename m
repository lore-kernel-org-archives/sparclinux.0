From: Igmar Palsenberg <maillist@jdimedia.nl>
Date: Sat, 06 Mar 2004 14:31:06 +0000
Subject: 2.6.3 + init hangs
Message-Id: <Pine.LNX.4.53.0403061526220.4023@jdi.jdimedia.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

I'm not sure who/what to blaim in this case, but someone might recognise 
the situation :

Sun Netra 112x SMP running 2.4.xx happely. I loaded 2.6.3 on it, the 
following happens :

- Kernel loads
- /sbin/init starts, and runs stuff sysinit stuff
- /sbin/init changes to runlevel 2, and then hangs

At that point, my console dies and I have to use the on-off button. I can 
reproduce the problem by using init=/bin/sh, doing the sysinit stuff by 
hand, and the using an exec /sbin/init 2.

Af first, I thought setserial was to blaim, so I simply removed that. 
Didn't help, same hamg.

Anyone got a clue what is happening here ? And better, how to debug ?



	Regards,


		Igmar 
