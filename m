From: Daniel Drake <dsd@gentoo.org>
Date: Sat, 18 Nov 2006 21:57:24 +0000
Subject: sunhme lockup and udelay workaround
Message-Id: <455F81C4.2060409@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

Rewind a few years, I don't suppose you remember the sunhme lockup 
issue, of which one ugly workaround was inserting a small delay in the 
TX codepath?

http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.19-pre/1705_sparc-U1-hme-lockup.patch

Was this ever resolved? This is the last patch in Gentoo's base set of 
kernel patches and I'm eager to remove it...

There is scattered discussion of this bug lying around, e.g.
http://lists.debian.org/debian-sparc/2003/02/msg00011.html

but it's not clear if a mainline resolution was ever reached. Do you 
know anything about the situation here?

Thanks!
Daniel
