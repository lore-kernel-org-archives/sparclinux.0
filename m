From: Arkadi Shishlov <arkadi@mebius.lv>
Date: Tue, 24 Apr 2007 09:58:03 +0000
Subject: Re: parport_sunbpp patch, works on ultra2
Message-Id: <462DD4AB.8050905@mebius.lv>
List-Id: <sparclinux.vger.kernel.org>
References: <op.tqnalwnm3zd5kp@k37>
In-Reply-To: <op.tqnalwnm3zd5kp@k37>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> But your patch doesn't seem right.  The generic parport code should be
> polling the status lines properly before calling down into the
> ->read() and ->write() handlers of the driver.
> 
> The FEPS manual states that the BSY signal in the TCR register is
> "active low" but that might just be normal for parallel ports.  The
> test is therefore inverted in status_sunbpp_to_pc for the P_TCR_BUSY
> bit.
> 
> That might be what the problem is, could you play around with that
> instead?  For example, try making the test in status_sunbpp_to_pc()
> be:
> 
> 	if (value_tcr & P_TCR_BUSY)
> 		bits |= PARPORT_STATUS_BUSY;

With this
--- parport_sunbpp.c~   2007-04-11 19:26:14.000000000 +0300
+++ parport_sunbpp.c    2007-04-24 12:32:31.000000000 +0300
@@ -123,7 +123,7 @@
                 bits |= PARPORT_STATUS_PAPEROUT;
         if (value_tcr & P_TCR_ACK)
                 bits |= PARPORT_STATUS_ACK;
-       if (!(value_tcr & P_TCR_BUSY))
+       if (value_tcr & P_TCR_BUSY)
                 bits |= PARPORT_STATUS_BUSY;

         dprintk((KERN_DEBUG "tcr 0x%x ir 0x%x\n", regs->p_tcr, regs->p_ir));

the printer does not print anything, and echo -en "test\r\ntest2\r\n\f" >/dev/lp0
never returns.

[ 7012.534343] frob1: tcr 0x1 or 0x3
[ 7012.534380] frob2: tcr 0x1 or 0x3
[ 7012.534419] tcr 0x1 or 0x3
[ 7012.534455] read control 0xc
[ 7012.534487] tcr 0x1 or 0x3
[ 7012.534497] read control 0xc
[ 7012.534566] frob1: tcr 0x1 or 0x3
[ 7012.534592] frob2: tcr 0x1 or 0x3
[ 7012.534605] tcr 0x1 or 0x3
[ 7012.534615] read control 0xc
[ 7012.534631] tcr 0x1 ir 0x4
[ 7012.534641] read status 0x18
[ 7012.534657] frob1: tcr 0x1 or 0x3
[ 7012.534668] frob2: tcr 0x1 or 0x3
[ 7012.534681] tcr 0x1 or 0x3
[ 7012.534691] read control 0xc
[ 7012.534702] forward
[ 7012.534715] tcr 0x1 ir 0x4
[ 7012.534725] read status 0x18
[ 7012.534737] tcr 0x1 ir 0x4
[ 7012.534747] read status 0x18
[ 7012.534758] tcr 0x1 ir 0x4

and so on, until canceled with 3 ^C

[ 7024.506696] tcr 0x1 or 0x3
[ 7024.506721] read control 0xc

> diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
> index 9793533..400bb90 100644
> --- a/drivers/parport/parport_sunbpp.c
> +++ b/drivers/parport/parport_sunbpp.c

Applied, no OOPS with debug now.
