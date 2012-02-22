From: David Miller <davem@davemloft.net>
Date: Wed, 22 Feb 2012 07:26:18 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120222.022618.1120777287905163584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Feb 2012 09:22:51 +0200 (EET)

>> Ok, let's try to fix this.  Can you run "dumpe2fs -h $DEV" where $DEV
>> is the block device the filesystem resides on, and report the output?
> 
> I see you already have a patch for testing but here is the output from 
> mounted filesystem:

That's a pretty large partition for /boot or do you put everything on
one partition, including / and /boot together?
