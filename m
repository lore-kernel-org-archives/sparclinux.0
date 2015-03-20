From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 01:56:33 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150319.215633.510893281777628246.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 16:06:37 -0400

> The M7 processor has a different hypervisor group id and different PCR fast
> trap values. PIC read/write functions and PCR bit fields are the same as
> the T4 so those are reused.
> 
> Signed-off-by: David Ahern <david.ahern@oracle.com>
> Acked-by: Bob Picco <bob.picco@oracle.com>

Applied, but two questions:

1) Why didn't you have to deal with the overflow event
   latching issues I address in sparc_vt_write_pmc()?

2) How simple is it to hook up a similar set of support
   for sparc-m6?  It seems like the only PMU type string
   we won't match after this.

Thanks.
