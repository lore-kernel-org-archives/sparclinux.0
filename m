From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2015 22:33:40 +0000
Subject: Re: system call tracing on sparc
Message-Id: <20150409.183340.566320224014505224.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5526FAC8.8000309@oracle.com>
In-Reply-To: <5526FAC8.8000309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 09 Apr 2015 16:18:48 -0600

> Have you ever used system call tracing on sparc? It does not work for
> 2.6.39 or 4.0; wondering if it has ever worked. I see signs in
> arch/sparc/kernel/syscalls.S for example that suggests it should have
> at one point.

I've used strace in the past, and at the time it worked.

But admittedly this was many years ago.
