From: David Miller <davem@davemloft.net>
Date: Thu, 28 Mar 2019 16:43:16 +0000
Subject: Re: [PATCH] SPARC: Better fls64(), fls() and __fls() on SPARCv9
Message-Id: <20190328.094316.1374143907623921418.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201903281052.x2SAqaoH015770@sdf.org>
In-Reply-To: <201903281052.x2SAqaoH015770@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


You can't use popc in the default implementations, most sparc64
chips do not implement popc in hardware and it must be emulated.

You can only use it in the code that is patched in on T4 and later
cpus.

See arch/sparc/lib/NG4fls*.S
