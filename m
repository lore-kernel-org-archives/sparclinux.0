From: Scott Wood <scottwood@freescale.com>
Date: Thu, 21 Aug 2008 16:32:56 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>
In-Reply-To: <20080821.001012.265401427.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> Mostly straightforward stuff _except_ for the I2C address encoding.
> 
> What I2C IEEE1275 device binding was used to write that code in
> of_i2c.c?  Is it some PowerPC specific thing?  Was it "invented"
> by the embedded folks (I hope not)?

Yes, it was "invented".  There was no documented i2c OF binding that I
could find, and AFAIR nobody came forward with examples of existing
practice at the time.

> And, furthermore, the device address is shifted up 1 bit higher
> than the Linux I2C layer expects.  It includes the low direction
> bit, bit 0, so we have to shift it down by 1 bit before we give
> it to the Linux I2C layer.

Yuck.

> 2) When CONFIG_SPARC, shift the device address down by one bit before
>    giving it to the Linux I2C layer.

Maybe we should distinguish by the type of I2C bus node instead.

-Scott
