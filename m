From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 23:10:02 +0000
Subject: Re: sunhme: incorrect global register offsets?
Message-Id: <20170726.161002.1560583877148504424.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <464f6f80-227c-5b9e-cbcd-e6b07784f73e@ilande.co.uk>
In-Reply-To: <464f6f80-227c-5b9e-cbcd-e6b07784f73e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 26 Jul 2017 23:52:14 +0100

> I've been playing around with trying to emulate a sunhme card in
> QEMU and AFAICT there is a discrepancy between the GREG_STAT and
> GREG_IMASK register offsets as listed in sunhme.h and the STP2002QFP
> datasheet.
> 
> According to the datasheet the global status register (GREG_STAT) is
> located at offset 0x100 and the global interrupt mask register
> (GREG_IMASK) is located at offset 0x104 - however according to sunhme.h
> GREG_STAT is set to 0x108 and GREG_IMASK is set to 0x10c.
> 
> I've checked against the NetBSD sources and they also agree with the
> datasheet that the global status register is located at offset 0x100 and
> the global interrupt mask register is located at offset 0x104.
> 
> So some obvious questions:
> 
> 1) Is this an error in the STP2002QFP datasheet or in sunhme.h?
> 
> 2) Has anyone ever experienced any lockups with the sunhme driver?
> 
> 3) If the GREG_STAT and GREG_IMASK constants were altered to match the
> datasheet, does anyone have any real hardware left to actually test with?

It's pretty amazing the driver ever worked at all if those register
offsets are wrong.  It means we're not even programming the interrupt
mask.

Indeed looking at my STP2002QFP manual, the offsets are wrong.  I wonder
where I got those values from :-)

No matter where I check the Linux values are wrong.

Please just submit a patch to fix this, and I'll apply it.

Thanks!
