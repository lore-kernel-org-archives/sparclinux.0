From: David Miller <davem@davemloft.net>
Date: Wed, 22 Feb 2012 07:45:29 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120222.024529.169760352925017131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Feb 2012 09:32:54 +0200 (EET)

> Yes, all files on one partition as a test - on some machines I have 
> /home separate, apparently not there. Small /boot becomes full too 
> easily (like when bisecting something) and when I need to do manual 
> partion setup, I usually just use / without separate /boot. I have 
> understood that this should work with ext2 and ext3 in silo. Not with 
> ext4 yet - does silo start to fully grok ext4 when you latest e2fslibs 
> changes integration is complete?

At the very least a basic ext4 partition with extents ought to
work but is untested by me.  The good news is that I have a special
userland framework I can link the ext2.c file into and use to test
SILO ext2 support without having to reboot or anything like that.

So all I need to do is make some interesting ext{2,3,4} filesystems
and run the userland tester against them.

This reminds me that I need to add some basic code to check the
feature flags in the ext{2,3,4} superblock and make sure we don't try
to mount an FS that uses something we don't support.  In particular I
think sparse superblocks will trip up my group descriptor
calculations.

> Should I try grub2 on some machines too? My museum sparcs are all like a 
> big testbed, most do not run anything important and I can do test 
> installes too when I happen to have some time.

I'd stay away from grub2 for the time being, I haven't tried it myself in
a very long time.  I was thinking of getting back to it today but someone
installed only 24 hours in a day.
