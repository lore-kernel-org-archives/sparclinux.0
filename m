From: David Miller <davem@davemloft.net>
Date: Mon, 23 Jan 2012 23:03:47 +0000
Subject: Re: silo fails to build with recent ext2fs libraries
Message-Id: <20120123.180347.789926204998529605.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120115140938.GA7564@wooyd.org>
In-Reply-To: <20120115140938.GA7564@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 18 Jan 2012 19:53:33 +0000

> On Tue, Jan 17, 2012 at 11:49:01PM -0500, David Miller wrote:
>> 
>> We've been fighting this problem for years, it only gets worse and
>> all of these various hacks are error prone.
>> 
>> The only real solution is to write something made for a bootloader and
>> that's what I'm already doing.  The code isn't that hard at all.
> 
> All right, I'll be watching git tree for commits then :-).
> 
> Thanks for taking care of this.

Ok, I commited my work, but be careful.

I tested it on a SunBlade-2500 running squeeze, with disks on the onboard
MPT Fusion controller.

Make backups and have a way to netboot or CD boot your test machine if
things go wrong.

Let me know how it goes.
