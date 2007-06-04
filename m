From: David Miller <davem@davemloft.net>
Date: Mon, 04 Jun 2007 00:24:35 +0000
Subject: Re: ESP wants SPI
Message-Id: <20070603.172435.59672863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0706032254530.19546@math>
In-Reply-To: <Pine.SOC.4.64.0706032254530.19546@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 3 Jun 2007 22:56:48 +0300 (EEST)

> I got linakeg errors when ESP SCSI was compiled in but Parallel SCSI 
> transport attributes (CONFIG_SCSI_SPI_ATTRS) were modular as before.
> 
> Should CONFIG_SCSI_SUNESP select CONFIG_SCSI_SPI_ATTRS or depend on it?

Yes, thus JAZZ_ESP needs it too, thanks for the report I'll
fix this.
