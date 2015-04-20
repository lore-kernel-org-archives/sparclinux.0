From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 20 Apr 2015 07:38:40 +0000
Subject: Re: Fwd: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib
Message-Id: <1429515520.12716.3.camel@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20150419183625.GA18901@oracle.com>
 <1429498885.28239.4.camel@ellerman.id.au> <55348BE1.4010305@roeck-us.net>
In-Reply-To: <55348BE1.4010305@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: aik@au1.ibm.com, Sowmini Varadhan <sowmini.varadhan@oracle.com>, anton@au1.ibm.com, linux-kernel@vger.kernel.org, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sun, 2015-04-19 at 22:17 -0700, Guenter Roeck wrote:
> Hi Michael,

Hi Guenter,

> On 04/19/2015 08:01 PM, Michael Ellerman wrote:
> 
> > Someone needs to be doing s390/alpha builds with that enabled anyway, because
> > otherwise a clash between generic code and s390/alpha won't be caught.
> >
> > Or if that's too hard we can rename the powerpc version, but it seems silly to
> > rename a powerpc variable to deal with a debug option that is only useful for
> > s390/alpha.
> 
> The debug option is intended for all _other_ architectures, to ensure that
> changes made for those don't break alpha/s390 builds. alpha/s390 have
> ARCH_NEEDS_WEAK_PER_CPU and don't need the debug option.

But that can't actually work. If you introduce a percpu variable in generic
code that has the same name as a variable in the s390/alpha code, the only way
you can detect that is by building for s390/alpha.

Sure it might catch two variables in generic code that have the same name, but
that will get caught as soon as someone does a s390/alpha build anyway - which
is at least every night for linux-next.

More likely it catches cases like this, which is variables in code that will
never build for s390/alpha. So it just seems like a PITA to me.

> Sowmini's patch would change the variable name in the lib/ code. But that was
> not the question here. The question was if the powerpc code could be changed
> to use the generic iommu code instead of using the powerpc specific code.

Not for this merge window sorry, we need to test it properly.

cheers



