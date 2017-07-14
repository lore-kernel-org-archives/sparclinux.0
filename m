From: Meelis Roos <mroos@linux.ee>
Date: Fri, 14 Jul 2017 12:10:22 +0000
Subject: Re: Trying out debian sparc64
Message-Id: <alpine.LRH.2.20.1707141503530.3086@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Comparing filesystem features - the news fs has 64bit and metadata_csum 
> > features that my working ext4 filesystems do not have. Will make more 
> > test to see if these are related.

Recreated the filesystem manually with -O ^64bit,^metadata_csum, 
installed on it and silo works. So it seems one of these new options needs 
bootloader support too - at least in silo, have not tried grub yet.

Unrelated - git seems to be not installable at the moment because of 
version conflict with git-man?

sparc-utils seems to be missing from sparc64 - no eeprom and prtconf 
programs? Sending prtconf output was my first task after getting system 
installed, since there is no t5140 in the prtconfs repo.

-- 
Meelis Roos (mroos@linux.ee)
