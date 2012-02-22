From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Feb 2012 07:32:54 +0000
Subject: Re: silo trouble with ext3
Message-Id: <alpine.SOC.1.00.1202220928160.21339@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> >> Ok, let's try to fix this.  Can you run "dumpe2fs -h $DEV" where $DEV
> >> is the block device the filesystem resides on, and report the output?
> > 
> > I see you already have a patch for testing but here is the output from 
> > mounted filesystem:
> 
> That's a pretty large partition for /boot or do you put everything on
> one partition, including / and /boot together?

Yes, all files on one partition as a test - on some machines I have 
/home separate, apparently not there. Small /boot becomes full too 
easily (like when bisecting something) and when I need to do manual 
partion setup, I usually just use / without separate /boot. I have 
understood that this should work with ext2 and ext3 in silo. Not with 
ext4 yet - does silo start to fully grok ext4 when you latest e2fslibs 
changes integration is complete?

Should I try grub2 on some machines too? My museum sparcs are all like a 
big testbed, most do not run anything important and I can do test 
installes too when I happen to have some time.

-- 
Meelis Roos (mroos@linux.ee)
