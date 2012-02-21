From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 22:40:55 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.174055.384982598871071500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Feb 2012 15:43:07 +0200 (EET)

> Image not found.... try again
> boot:

Ok, let's try to fix this.  Can you run "dumpe2fs -h $DEV" where $DEV
is the block device the filesystem resides on, and report the output?

Using that I'll try to create a partition that resembles your's in
hopes I can reproduce the bug.

Thanks.
