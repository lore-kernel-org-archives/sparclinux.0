From: David Miller <davem@davemloft.net>
Date: Fri, 06 Feb 2009 22:20:20 +0000
Subject: Re: SBus HME startup failure
Message-Id: <20090206.142020.233948811.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Brower <ebrower@gmail.com>
Date: Fri, 6 Feb 2009 11:32:44 -0800

> I'm running a somewhat-current davem sparc-2.6 GIT.  I'm not sure if
> your kernel is similar, but if PCI and SBUS are both enabled in the
> kernel, the SBus device probe routines will be run on all matching HME
> devices, which means both PCI and SBus.
> 
> I have not studied the new driver model and OF implementation in
> sufficient detail, but the underlying bus type for an of_device (PCI,
> SBus, etc) appears not to be kept, rather "of" is used in these cases.
>  So, without knowing the underlying bus type, simply using "name" or
> "compatible" for device matching seems insufficient (at least in the
> case of HME, or any other device that has both PCI and SBus
> implementations available).
> 
> So, admitting this may not be the proper fix, the following at least
> allows the SBus probe to exit early.  I'm not sure if this will solve
> your issue, but it solves mine.

Indeed, that seems to be the cause.  I'll try to find a clean way
to fix this up.

Thanks guys.
