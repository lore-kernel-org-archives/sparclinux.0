From: David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 07:03:51 +0000
Subject: Re: AW: Two bugletts on Sparc 64 @ kernel 2.4
Message-Id: <20060825.000351.11599236.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0601569295@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 25 Aug 2006 07:44:45 +0200

> So, there is a small deficiency in this regard within the sparc64
> kernel, as the sparc64 kernel is capable of reading less many
> symbols of type kernel_sym than 32 Bit kernels on i686 for
> example. The very same function exists in linux/arch/x86_64/ia32; so
> my guess would be that similar problems would show on x86 given a
> 32Bit userland and a 64Bit kernel. I haven't recognized this on
> x86_64 until now, I would be very happy if someone could kindly give
> me an advice on how this is taken care of on such machines. klogd is
> always 1.4.1, this cannot be the place where the problem is taken
> care for.

Try changing the kmalloc/kfree to vmalloc/vfree.
