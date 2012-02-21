From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 23:33:10 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.183310.1245115002013195062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 18:10:07 -0500 (EST)

> For example, I just found a bug with symlink handling in path
> traversal fixed by the following patch.  So if there are symlinks
> involved in Meelis's setup that would be the cause rather than not
> specifically using ext2 for the boot partition.
> 
> --------------------
> ext2: Fix symlink being overwritten.

Ignore me, there is no bug.  All callers specifically use a special
on-stack inode buffer to avoid this problem.
