From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 20:27:30 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <20051010.132730.65707848.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 23:10:16 +0300 (EEST)

> > Actually, we are calling into the firmware explicitly.
> > Can you get a deeper call trace?  So we can see who is calling
> > prom_cif_interface() and likewise that function's caller as well?
> 
> How can I get the deeper trace?

Nevermind... looking at your original "-p" dump it double
faulted when it tried to print the backtrace :-)

I've fired up my ultra5 and I'll try to fix this.
