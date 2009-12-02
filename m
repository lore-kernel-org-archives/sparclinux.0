From: David Miller <davem@davemloft.net>
Date: Wed, 02 Dec 2009 22:37:52 +0000
Subject: Re: BBC I2C doesn't work on V880
Message-Id: <20091202.143752.178862135.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200912021105.03604.pat@computer-refuge.org>
In-Reply-To: <200912021105.03604.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 2 Dec 2009 11:05:03 -0500

> Going through the remaining problems I'm having with my V880, it looks 
> like the SPARC bbc i2c driver won't load.  This is with Linus's git 
> tree from a few days ago.  When I do a "modprobe bbc", I get this:
> 
> [ 3735.308284] i2c-0: Regs at 000007fc7e00002e, 2 devices, own a0, clock 10.
> [ 3735.388677] bbc_i2c: probe of f00bd100 failed with error -22
> [ 3735.456691] i2c-0: Regs at 000007fc7e50002e, 8 devices, own a0, clock 10.
> [ 3735.537696] bbc_i2c: probe of f00cd000 failed with error -22
> 
> And, when I try to rmmod bbc, I get a kernel NULL pointer bug:

Yes I know it has a lot of problems.  I'll try to look into it
when I get a chance.

> I still have the prtconf output available up at:
> 
> http://ned.cc.purdue.edu/prtconf-v880

BTW, I added this to our prtconf repo at:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git

so that we can refer to it in the future.

Thanks for your report.  I'll see what I can do.

