From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 19:50:55 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.145055.999660323832855259.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: crn@netunix.com
Date: Tue, 21 Feb 2012 18:03:12 +0000 (GMT)

> 
> I had a similar problem a long time ago, I created a small boot
> partition at the beginning of the disk, ext2. The problem went away
> but I did not figure out why.

This is totally unrelated.

Meelis's problem is due to the complete rewrite of the ext{2,3,4}
support in SILO which I committed recently, and which propagated into
Debian way too quickly.
