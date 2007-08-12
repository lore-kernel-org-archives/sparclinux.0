From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 12 Aug 2007 10:29:53 +0000
Subject: 'Illegal instruction' on taking a trap on UltrasparcIII
Message-Id: <20070812102952.GA5008@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Ruby 1.8 in Debian has been misbehaving on sparc for some time 
(http://bugs.debian.org/393817):

jurij@goofy:~$ ruby1.8
Illegal instruction
jurij@goofy:~$ uname -a
Linux goofy 2.6.22-1-sparc64-smp #1 SMP Sun Aug 12 01:17:37 NZST 2007 sparc64 GNU/Linux

This has been traced to the following code fragment in Ruby's 
defines.h:

#if defined(sparc) || defined(__sparc__)
static inline void
flush_register_windows(void)
{
    asm
#ifdef __GNUC__
        volatile
#endif
# if defined(__sparc_v9__) || defined(__sparcv9) || 
defined(__arch64__)
        ("flushw")
# elif defined(linux) || defined(__linux__)
        ("ta  0x83")
# else /* Solaris, OpenBSD, NetBSD, etc. */
        ("ta  0x03")
# endif /* trap always to flush register windows if we are on a Sparc 
system */
        ;
}
#  define FLUSH_REGISTER_WINDOWS flush_register_windows()
[...]

In Debian we are still generating instructions for v8 by default (this 
is going to change soon, as we have decided to drop sparc32 support 
for the next release), so it tries to execute 'ta 0x83'. This leads to 
illegal instruction, but, interestingly enough, only on UltrasparcIII 
or better (originally the bug has been discovered on Niagara, 
confirmed on Blade 1000 and Blade 2500). Machines with UltrasparcII do 
not have any problems with this instruction. As it is unlikely that 
it's this instruction itself which is causing a SIGILL, my guess is 
that the illegal instruction is hit somewhere in the trap handler in 
the kernel, however I was not able to debug it further yet. Any ideas 
would be appreciated.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
