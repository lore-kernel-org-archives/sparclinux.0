From: Brian Bartholomew <bb@stat.ufl.edu>
Date: Tue, 23 Nov 2004 15:33:45 +0000
Subject: Sun 420: Could not find any available memory for initial ramdisk
Message-Id: <200411231533.iANFXjf5021841@stat.ufl.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I suspect this is the wrong venue to raise this question, but perhaps
you will have some suggestions.

I have a Sun 420 that I am running gentoo Linux on, with kernel
2.4.25.  However, after it is first powered on it must be booted with
Solaris before it can be booted by Linux.  If I try booting it from
Linux first it reports "Could not find any available memory for
initial ramdisk".  I would like Linux to boot the machine directly.

I found an earlier report of this problem, which I've copied into
http://www.stat.ufl.edu/~bb/booting-sun-420.txt, and that's where I
found the workaround of booting Solaris first.  This workaround works
for me, too.  The person named in that report has not returned my mail
asking about better workarounds or a repair.

I've had warranty service come out, and they convinced me with
numerous diags and Solaris boots there is no problem with the
hardware.
							Brian
