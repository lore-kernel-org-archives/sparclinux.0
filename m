From: David Miller <davem@davemloft.net>
Date: Mon, 20 Apr 2015 16:25:19 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150420.122519.1661605449214047938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150419183625.GA18901@oracle.com>
 <1429498885.28239.4.camel@ellerman.id.au>
 <55348BE1.4010305@roeck-us.net>
In-Reply-To: <55348BE1.4010305@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org, sowmini.varadhan@oracle.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 Apr 2015 22:17:21 -0700

> The debug option is intended for all _other_ architectures, to
> ensure that changes made for those don't break alpha/s390
> builds. alpha/s390 have ARCH_NEEDS_WEAK_PER_CPU and don't need the
> debug option.

Ironically this would not create a build failure for the architectures
where this matters, because only powerpc has the like named percpu
symbol.

So it's not really meeting the stated objective in this case.
