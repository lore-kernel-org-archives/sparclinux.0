From: David Miller <davem@davemloft.net>
Date: Thu, 01 Apr 2010 09:02:26 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100401.020226.94730746.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100401090608.GD5207@nowhere>
	<20100401.010903.05627158.davem@davemloft.net>
	<20100401093831.GE5207@nowhere>
In-Reply-To: <20100401093831.GE5207@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 1 Apr 2010 11:38:33 +0200

> It seems to happen with ld as well btw (not sure this is related
> though):
> 
> [ 3366.005962] ld[19041]: segfault at 10 ip 000000007010248c (rpc 00000000701023f8) sp 00000000ffda87c8 error 30001 
> in libbfd-2.18.0.20080103.so[700d8000+a0000]

It's data corruption coming either from the kernel or something
malfunctioning in libc is my guess, more likely the kernel.

