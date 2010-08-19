From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 19 Aug 2010 13:42:55 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <Pine.LNX.4.64.1008190933180.19440@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>  #define BACKOFF_SETUP(reg)
> -#define BACKOFF_SPIN(reg, tmp, label) \
> -	ba,pt	%xcc, label; \
> -	 nop;

I'm just curious, is there some good reason to place nop in the delay slot 
instead of the anul bit? --- i.e. some inefficiency or bugs?

BTW, I found a missing delay slot.

Mikulas

----

Fill a missing delay slot.

If the code were already aligned to 64 bytes, wr instruction would be executed
twice --- once in delay slot and once in the jump target.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc/include/asm/system_64.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.35-preempt/arch/sparc/include/asm/system_64.h
=================================--- linux-2.6.35-preempt.orig/arch/sparc/include/asm/system_64.h	2010-08-19 15:35:45.000000000 +0200
+++ linux-2.6.35-preempt/arch/sparc/include/asm/system_64.h	2010-08-19 15:38:21.000000000 +0200
@@ -106,6 +106,7 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 
  */
 #define write_pic(__p)  					\
 	__asm__ __volatile__("ba,pt	%%xcc, 99f\n\t"		\
+			     " nop\n\t"				\
 			     ".align	64\n"			\
 			  "99:wr	%0, 0x0, %%pic\n\t"	\
 			     "rd	%%pic, %%g0" : : "r" (__p))
