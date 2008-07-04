From: Andi Kleen <andi@firstfloor.org>
Date: Fri, 04 Jul 2008 12:22:00 +0000
Subject: Re: next-0704: sparc64: build failure at arch/sparc64/kernel/sysfs.c
Message-Id: <486E15E8.5040303@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807040520v7604782crd209d64aad9343ff@mail.gmail.com>
In-Reply-To: <a4423d670807040520v7604782crd209d64aad9343ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org

Alexander Beregalov wrote:
> Hi
> 
> cc1: warnings being treated as errors
> arch/sparc64/kernel/sysfs.c:160: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:160: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:205: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:206: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:207: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:208: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:209: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:210: error: initialization from
> incompatible pointer type
> arch/sparc64/kernel/sysfs.c:211: error: initialization from
> incompatible pointer type
> 
> I think it is connected to

Thanks. Looks good. sparc64 was one of the architectures i wasn't able
to compile test. Greg, can you just fold the patch in please?

-Andi


