From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jan 2011 17:32:33 +0000
Subject: Re: Sun Fire V440 fan control
Message-Id: <20110103.093233.71114715.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294070842.1549.53.camel@deblnxsrv222>
In-Reply-To: <1294070842.1549.53.camel@deblnxsrv222>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Mon, 03 Jan 2011 17:07:22 +0100

> What kernel module do i need to compile for controlling the fan's in a
> Sun Fire V440? And has anyone experience and got it to lower the speed?

No drivers are currently in the tree at this time.

I have an implementation I wrote 2 years ago which ought to cover
those devices, but they need a bit of dusting off and reworking
the integrate the I2C controller driver properly into the tree.

The I2C controller on these machines supports multiple busses,
and I changed the I2C layer in a way the I2C maintainer (legitimately)
didn't like.  So I have to go back and look into those issues before
I can get support for these devices into the tree.
