From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 22 May 2007 08:40:53 +0000
Subject: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <18002.44181.639121.720839@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Just a FYI:

2.6.21 works fine on my Ultra5, but with 2.6.22-rc the X
server (from Aurora 2) fails to mmap() the PCI frame buffer
(atyfb).

I noticed a lot of PCI-related changes both in `dmesg' and
/var/log/Xorg.0.log between 2.6.21 and 2.6.22-rc, so my
guess is that PCI resources get broken somewhere.

I'll try a bisect between 2.6.21 and 2.6.22-rc1 next, but
I'm also willing to test patches in case anyone thinks they
know what the fix is.

/Mikael
