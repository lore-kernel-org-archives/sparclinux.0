From: David Miller <davem@davemloft.net>
Date: Tue, 29 Jun 2010 03:36:47 +0000
Subject: Re: bootcup crash in prom tree building with specific PCI card
Message-Id: <20100628.203647.28814592.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 7 Jun 2010 17:57:50 +0300 (EEST)

> Initializing Memory
> 
> ok cd /pci/pci
> ok ls
> f009908c Grappler_906F@2
> f00856e8 scsi@1
> ok cd Grappler_906F@2
> ok .properties

What devices sit underneath "Grappler_906F@2"?  Provide ".properties"
output for those please.

That's what we're creating nodes for when the kernel crashes.

Frankly, I'm surprised the machine even powers on to the firmware
prompt with these MAC cards in the PCI slots :-)

Thanks.
