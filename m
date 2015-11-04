From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2015 20:01:08 +0000
Subject: Re: [PATCH] sparc64: Don't restrict fp regs for no-fault loads
Message-Id: <20151104.150108.2237831547194215038.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 30 Oct 2015 22:36:23 -0600

> The function handle_ldf_stq() deals with no-fault ASI
> loads and stores, but restricts fp registers to quad
> word regs (ie, %f0, %f4 etc). This is valid for the
> STQ case, but unnecessarily restricts loads, which
> may be single precision, double, or quad. This results
> in SIGFPE being raised for this instruction when the
> source address is invalid:
> 	ldda [%g1] ASI_PNF, %f2
> but not for this one:
> 	ldda [%g1] ASI_PNF, %f4
> The validation check for quad register is moved to
> within the STQ block so that loads are not affected
> by the check.
> 
> An additional problem is that the calculation for freg
> is incorrect when a single precision load is being
> handled. This causes %f1 to be seen as %f32 etc,
> and the incorrect register ends up being overwritten.
> This code sequence demonstrates the problem:
> 	ldd [%g1], %f32		! g1 = valid address
> 	lda [%i3] ASI_PNF, %f1  ! i3 = invalid address
> 	std %f32, [%g1]
> This is corrected by basing the freg calculation on
> the load size.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Good catch, applied, thanks.
