From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 21:58:42 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <20080821.145842.140799897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>
	<9e4733910808211453t63f0a6f5h2139e027319263f1@mail.gmail.com>
In-Reply-To: <9e4733910808211453t63f0a6f5h2139e027319263f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jonsmirl@gmail.com
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

From: "Jon Smirl" <jonsmirl@gmail.com>
Date: Thu, 21 Aug 2008 17:53:02 -0400

> >  2) When CONFIG_SPARC, shift the device address down by one bit before
> >    giving it to the Linux I2C layer.
> 
> How do you deal with a 10-bit address i2c device? Is it multiplied by two too?

Yes.
