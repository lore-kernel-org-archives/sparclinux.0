From: Christoph Lameter <cl@gentwo.org>
Date: Mon, 16 Jun 2014 15:14:16 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.DEB.2.11.1406161009010.20878@gentwo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 16 Jun 2014, Peter Hurley wrote:

> Is still only with the SLAB allocator and modular CONFIG_SUN_OPENPROMFS?

I did not see any use of SLUB in the thread (A pretty long and convoluted
one. Maybe I missed it). I'd be interested in seeing what messages show up
if you run with full debugging under SLUB because that does more checks
than SLAB and provides more debugging details.

But from the bits and pieces that I read it looks like the problem is more
related to atomic ops / locking on Sparc due to memory mapping issues? TLB?


