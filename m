From: Ed L Cashin <ecashin@uga.edu>
Date: Thu, 15 Jan 2004 22:42:20 +0000
Subject: finding origin of dTLB miss
Message-Id: <87isjcg7g3.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  I'm trying to learn more about a dTLB fault that's occurring on
my system.  Inside do_sparc64_fault, these things are true:

  address:              0xefffe000   (bottom of the user stack region)
  fault code:           0x2          (dTLB miss)
  insn:                 0xc2060000
  tstate:               0x11009606
  tstate & TSTATE_PRIV: 1

Since tstate & TSTATE_PRIV is true, it seems like insn should be in
the kernel, but it doesn't look like a kernel address, since the
userland memory maps look like this:

00010000-00012000 r-xp 00000000 03:04 585266   /home/ecashin/ra/macc-switch/a.out
00020000-00022000 rwxp 00000000 03:04 585266   /home/ecashin/ra/macc-switch/a.out
70000000-7001c000 r-xp 00000000 03:04 341709   /lib/ld-2.3.3.so
7002a000-7002c000 rwxp 0001a000 03:04 341709   /lib/ld-2.3.3.so
7002c000-70174000 r-xp 00000000 03:04 341855   /lib/libc-2.3.3.so
70174000-7017c000 ---p 00148000 03:04 341855   /lib/libc-2.3.3.so
7017c000-7018a000 rwxp 00140000 03:04 341855   /lib/libc-2.3.3.so
7018a000-7018c000 rwxp 00000000 00:00 0 
efffe000-f0000000 rwxp 00000000 00:00 0     

Ksymoops doesn't say anything helpful when I input the line, "TSTATE:
0000000011009606 TPC: c2060000".  

I get the feeling I'm going about this in an entirely wrong way.  What
is the proper way to find out where this dTLB miss is occurring?

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

