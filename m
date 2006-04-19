From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 19 Apr 2006 04:02:20 +0000
Subject: Re: 2.6.17-rc1+git, Sym2: unknown symbol pcibios_resource_to_bus
Message-Id: <20060418.210220.54944830.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060417.131705.40072804.davem@davemloft.net>
	<20060417.132638.84565849.davem@davemloft.net>
	<20060419035908.GH24104@parisc-linux.org>
In-Reply-To: <20060419035908.GH24104@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, rmk@arm.linux.org.uk

From: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 18 Apr 2006 21:59:08 -0600

> I suppose you don't test pci-pcmcia adapters very often on sparc64.
> 
> Is there a problem with adding the symbol export?  I noticed that v850
> also doesn't export that symbol.

I added it already.
