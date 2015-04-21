From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 21 Apr 2015 01:54:10 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <1429581250.9619.6.camel@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <55348BE1.4010305@roeck-us.net>
 <20150420.122519.1661605449214047938.davem@davemloft.net>
 <20150420164431.GA30837@roeck-us.net>
 <20150420.125050.2036067807685492178.davem@davemloft.net>
In-Reply-To: <20150420.125050.2036067807685492178.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, aik@au1.ibm.com, sowmini.varadhan@oracle.com, anton@au1.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net

On Mon, 2015-04-20 at 12:50 -0400, David Miller wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Mon, 20 Apr 2015 09:44:31 -0700
> 
> > On Mon, Apr 20, 2015 at 12:25:19PM -0400, David Miller wrote:
> >> From: Guenter Roeck <linux@roeck-us.net>
> >> Date: Sun, 19 Apr 2015 22:17:21 -0700
> >> 
> >> > The debug option is intended for all _other_ architectures, to
> >> > ensure that changes made for those don't break alpha/s390
> >> > builds. alpha/s390 have ARCH_NEEDS_WEAK_PER_CPU and don't need the
> >> > debug option.
> >> 
> >> Ironically this would not create a build failure for the architectures
> >> where this matters, because only powerpc has the like named percpu
> >> symbol.
> >> 
> >> So it's not really meeting the stated objective in this case.
> > 
> > Yes, that is correct; it can only find problems in non-architecture
> > code, and on the downside produces false positives and thus build errors
> > like this one.
> > 
> > Which makes the fix a bit philosophical. Rename iommu_pool_hash in
> > iommu-common, or drop DEBUG_FORCE_WEAK_PER_CPU. I would rename
> > iommu_pool_hash, but that is just me. Ultimately, I don't really
> > care one way or another, as long as the problem gets fixed.
> 
> If nightly builds of s390 and alpha, the two platforms where this
> matters, are being done as reported in this thread, then I really
> don't see the value in DEBUG_FORCE_WEAK_PER_CPU.

We do an s390 allmodconfig for every linux-next release:

  http://kisskb.ellerman.id.au/kisskb/target/573/

And also for Linus' tree:

  http://kisskb.ellerman.id.au/kisskb/target/568/

We don't have alpha allmodconfig enabled, though we could, but we do build the
defconfig:

  http://kisskb.ellerman.id.au/kisskb/target/2499/
  http://kisskb.ellerman.id.au/kisskb/target/2494/

So I think that should be sufficient to catch any percpus that are introduced
in generic code with the same name as s390/alpha variables.


> But I guess that's a more involved longer-term discussion and I guess
> I'll apply Sowmini's patches for now.

Yeah I guess it is. Thanks for merging the fix.

cheers


