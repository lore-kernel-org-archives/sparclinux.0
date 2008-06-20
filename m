From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 20 Jun 2008 23:12:30 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670806201612g3487325cj175f077fbe71de2a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670806201419i2f0c0982j69eb423f9ecd239d@mail.gmail.com>
	 <20080620.142137.242155859.davem@davemloft.net>
	 <a4423d670806201542o5415cad7p6b9a38b67252cee1@mail.gmail.com>
	 <20080620.155139.224032701.davem@davemloft.net>
In-Reply-To: <20080620.155139.224032701.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2008/6/21 David Miller <davem@davemloft.net>:
> Something is screwey here... Hmmm...
>
> When I added the changeset in question, it fixed a problem in that
> any backtrace of a kernel thread would loop forever at the end.
> Any stack backtrace would hang or reach a safety limit (such as
> the one imposed by lockdep).
>
> Please double check that you are precisely reverting this patch
> below _before_ doing these tests:
>
> commit a051bc5bb1ac6dc138d529077fa20cbbc6622d95

Yes, I am sure. It runs without this commit and hangs with it.
I can connect serial console, but if it is a infinite loop it will not
provide more info.

$ git log arch/sparc64/kernel/process.c
commit 99d3b2d0d3df1fa171a7ee1d2d3a92f540873b15
Author: alexb <alexb@sparky>
Date:   Thu Jun 19 18:49:46 2008 +0400

    Revert "sparc64: Fix kernel thread stack termination."

    This reverts commit a051bc5bb1ac6dc138d529077fa20cbbc6622d95.

commit a051bc5bb1ac6dc138d529077fa20cbbc6622d95
Author: David S. Miller <davem@davemloft.net>
Date:   Wed May 21 18:14:28 2008 -0700

    sparc64: Fix kernel thread stack termination.
