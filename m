From: Meelis Roos <mroos@linux.ee>
Date: Wed, 12 May 2004 11:09:16 +0000
Subject: 2.6.6: compile error with spinlock debugging
Message-Id: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If spinlock debugging is turned on in 2.6.6, I get the following error.
With spinlock debugging off it compiles fine.

  CC      arch/sparc64/kernel/sys_sparc32.o
In file included from include/linux/ip.h:84,
                 from include/linux/tcp.h:192,
                 from include/linux/ipv6.h:177,
                 from arch/sparc64/kernel/sys_sparc32.c:44:
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:826: warning: implicit declaration of function `_raw_write_trylock'
make[1]: *** [arch/sparc64/kernel/sys_sparc32.o] Error 1

-- 
Meelis Roos (trying to make a dual UE2 run a 2.6 kernel)

