From: "Feldman, Scott" <scott.feldman@intel.com>
Date: Thu, 08 Jan 2004 22:20:29 +0000
Subject: RE: PSYCHO0 PBMA: PCI streaming byte hole error asserted.
Message-Id: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDDBE@orsmsx402.jf.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073585763.1669.1.camel@localhost>
In-Reply-To: <1073585763.1669.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Scott, does the DMA engine of the e1000 do read/write of PCI 
> cache lines with not all the byte enables on?  In particular, 
> with descriptor reads/writes?

82542/82543/82544 only update the status byte of the Tx desc on
write-back.  Only the status byte would be byte-enabled.  Every other
8254x controller write backs the entire Tx desc (16-bytes) with full
byte-enables.
 
> That's not allowed on many RISC platform PCI controllers due 
> to how they implement caching of DMA traffic, sparc64 is one 
> such instance.

I'm pretty sure we could make 82543/82544 do the full desc writeback,
but 82542 doesn't have that capability.  So it sounds like 82542 is
basically incompatible with RISC (unless we come up with some
no-Tx-desc-write-back scheme).

> If there is some way to tweak the config of the e1000 such 
> that it will not generate these transactions, we should do so 
> on sparc64 at least.

Not for 82542.  For 82543/82544, look for the keyword "policy" in
e1000_hw.c, and change the conditional to (mac > 82542).  I can't try
any of this out today.  Our lab is shut down because of weather.

-scott
