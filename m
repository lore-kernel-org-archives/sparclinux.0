From: David Miller <davem@davemloft.net>
Date: Sun, 31 Jul 2011 09:07:35 +0000
Subject: Re: Sparc, dma mapping and endianness
Message-Id: <20110731.020735.1629786346435387295.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4E351418.50101@broadcom.com>
In-Reply-To: <4E351418.50101@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Roland Vossen" <rvossen@broadcom.com>
Date: Sun, 31 Jul 2011 10:36:40 +0200

> I read that the Sparc-V9 64 bit architecture also supports endianness
> swapping of pages. I wonder if it is easy to make use of this
> functionality in Linux.

Not really.

You'll need to use le32_to_cpu() and friends on the data when
interpreting it.  Or even better, le32_to_cpup() which works
on pointers and emits little-endian loads on sparc v9.
