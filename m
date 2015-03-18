From: David Miller <davem@davemloft.net>
Date: Wed, 18 Mar 2015 19:43:59 +0000
Subject: Re: maps mismatch in /proc/kcore for sparc
Message-Id: <20150318.154359.1325469409095627387.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5509AE36.8040902@oracle.com>
In-Reply-To: <5509AE36.8040902@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Wed, 18 Mar 2015 10:56:22 -0600

> I am trying to understand why the perf tool on sparc fails to convert
> kernel symbols when /proc/kcore is used. I have instrumented perf to
> the point I can see that it drops symbols from kallsyms because it
> cannot find a corresponding map when the kernel maps are created based
> on parsing /proc/kcore.

I'm looking into this, I think we need to set ARCH_PROC_KCORE_TEXT in
arch/sparc/Kconfig

I have an even worse problem on my T4 system, /proc/kcore is zero
length.  Looking into that now as well.
