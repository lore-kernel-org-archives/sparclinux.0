From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 22 Feb 2012 21:47:29 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120222214729.GA4346@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 21, 2012 at 08:27:33PM -0500, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 21 Feb 2012 18:33:10 -0500 (EST)
> 
> > From: David Miller <davem@davemloft.net>
> > Date: Tue, 21 Feb 2012 18:10:07 -0500 (EST)
> > 
> >> For example, I just found a bug with symlink handling in path
> >> traversal fixed by the following patch.  So if there are symlinks
> >> involved in Meelis's setup that would be the cause rather than not
> >> specifically using ext2 for the boot partition.
> >> 
> >> --------------------
> >> ext2: Fix symlink being overwritten.
> > 
> > Ignore me, there is no bug.  All callers specifically use a special
> > on-stack inode buffer to avoid this problem.
> 
> Ok, while waiting for the debug dump from Meelis I think I found the
> problem.
> 
> With my test harness I reproduced a case similar to what Meelis saw
> but it has nothing to do with ext3'ness or anything like that.
> 
> The block group descriptors were having their location miscalculated.
> It only worked for the first block of group descriptors.
> 
> So if an inode is outside of the first several block groups, things
> don't work.  I guess for most /boot partitions, which are relatively
> small, most if not all of the files fit into the working range.
> 
> Jurij, can you possibly build a test package for Meelis to see if this
> fixes the reported bug?

Sure, a new package with this patch included is available at
http://www.wooyd.org/silo/

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
