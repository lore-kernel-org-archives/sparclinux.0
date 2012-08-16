From: David Miller <davem@davemloft.net>
Date: Thu, 16 Aug 2012 20:25:57 +0000
Subject: Re: PCI resource allocation problem on Sun Ultra 10
Message-Id: <20120816.132557.173944271888805402.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1208161813240.11061@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Aug 2012 18:15:24 +0300 (EEST)

> I tried to populate my Sun Ultra 10 with PCI cards. All but the last 
> slot work but the last slot is assigned a non-working BAR. It sees that 
> this area is reserved for Video ROM. Why is there Video ROM placeholder 
> at that address - I see no resource in ATI VGA for it?

It's not a "placeholder", it's absolutely necessary because this range
is implicitly decoded by any VGA capable device in the system.

Therefore no device should ever be allocated that part of the address
space.

If OBP is allocating this range to non-VGA devices, it's buggy, and is
risking multiple devices responding at the same time to an I/O space
access.

