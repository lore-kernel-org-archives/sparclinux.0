From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Thu, 19 Aug 2004 12:47:17 +0000
Subject: Re: Sun4d progress
Message-Id: <20040819124717.GB12126@solo.franken.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 18, 2004 at 10:57:47PM +0100, C.Newport wrote:
> Something odd is going on - Thomas claimed that 2.4.23-pre5 booted but
> was unstable, which I cannot achieve. Maybe our environments are 
> different, but I have built this 4 times with 2.4.22 and 2.4.27 on both
> old and new compilers and the result is consistent. Maybe Thomas had
> applied some other patch before these ?.

hmm, thinking about it, there is one hunk I usually throw out of that
patch:


diff -ru -X excludes orig/linux-2.4.22/arch/sparc/Makefile linux-2.4.22/arch/sparc/Makefile
--- orig/linux-2.4.22/arch/sparc/Makefile	Sat Jul 28 21:12:37 2001
+++ linux-2.4.22/arch/sparc/Makefile	Fri Sep 26 12:10:43 2003
@@ -27,7 +27,7 @@
 ifneq ($(IS_EGCS),y)
 CFLAGS := $(CFLAGS) -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 else
-CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -fno-optimize-sibling-calls
 endif
 
 #LINKFLAGS = -N -Ttext 0xf0004000


Without that gcc 3.0.4 generates instructions, which btfixup couldn't
resolve. I suspect there are some compiler troubles left, because the
images I've build with gcc 3.3.3 aren't even working on my SS20 last
time I tried ...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
