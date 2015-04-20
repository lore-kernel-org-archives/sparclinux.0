From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 20 Apr 2015 03:01:25 +0000
Subject: Re: Fwd: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib
Message-Id: <1429498885.28239.4.camel@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20150419183625.GA18901@oracle.com>
In-Reply-To: <20150419183625.GA18901@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux@roeck-us.net

On Sun, 2015-04-19 at 14:36 -0400, Sowmini Varadhan wrote:
> > On (04/19/15 14:09), David Miller wrote:
> >
> > > On (04/18/15 21:23), Guenter Roeck wrote:
> > >> lib/built-in.o:(.discard+0x1): multiple definition of
> > >> `__pcpu_unique_iommu_pool_hash'
> > >> arch/powerpc/kernel/built-in.o:(.discard+0x18): first defined here
> > >> .. I get a similar failure in the
> > >> powerpc:allmodconfig build
>     :
> > 
> > Maybe ping the powerpc folks becuase if they can do a quick
> > conversion, this change isn't necessary.
> 
> linuxppc-dev,
> 
> The disussion above [http://www.spinics.net/lists/sparclinux/msg13835.html]
> is in reference to the issue that Guenter Roeck
> identified. The problem is that we have a 
>   static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);

It's static ..

>   if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is configured, which is the case here.
>   The marked line above shows that __pcpu_unique_iommu_pool_hash is declared as
>   global variable"

OK, so why doesn't CONFIG_DEBUG_FORCE_WEAK_PER_CPU depend on s390 and/or alpha?

Someone needs to be doing s390/alpha builds with that enabled anyway, because
otherwise a clash between generic code and s390/alpha won't be caught.

Or if that's too hard we can rename the powerpc version, but it seems silly to
rename a powerpc variable to deal with a debug option that is only useful for
s390/alpha.

cheers


