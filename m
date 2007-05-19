From: Meelis Roos <mroos@linux.ee>
Date: Sat, 19 May 2007 11:16:21 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <20070519111622.2C20214371@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

DM> You haven't told us why you simply cannot make the kernel
DM> smaller by building more things as modules, why kill yourself
DM> with all of these SILO and kernel hacks when you can solve
DM> your problem more easily?

Well, it's quite hard nowadays since the base 2.6 kernel has grown quite
a lot in features that are not modular. I managed to slim my sparc32
kernel down last year but it was quite a pain. Initrd/initramfs becomes
almost a must and I seem to remember that I had to also disable some new
2.6 features to make it fit.

Granted, there are more burning problems with the sparc32 port than
enhancing the boot protocol but it is a real problem IMHO.

-- 
Meelis Roos
