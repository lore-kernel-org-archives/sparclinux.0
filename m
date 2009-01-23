From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 23 Jan 2009 17:31:48 +0000
Subject: Re: opps building sparc64 packages
Message-Id: <200901231131.58907.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1928366.XdZe4kIJxV"
List-Id: <sparclinux.vger.kernel.org>
References: <200901021435.23972.dgilmore@redhat.com>
In-Reply-To: <200901021435.23972.dgilmore@redhat.com>
To: sparclinux@vger.kernel.org

--nextPart1928366.XdZe4kIJxV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 20 January 2009 12:52:28 am David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Mon, 19 Jan 2009 22:35:17 -0800 (PST)
>
> > The code in sun4v_data_access_exception() needs some logic to properly
> > handle the case of the kernel doing a userspace access.  Currently it
> > does an OOPS unconditionally when triggered from kernel space, which
> > is wrong.
> >
> > I'll fix this up and post a patch.
Dave,

The patch does fix the issue.

Dennis

> Dennis, here is a 2.6.27 based patch that should fix this bug.
>
> sparc64: Fix DAX handling via userspace access from kernel.
>
> If we do a userspace access from kernel mode, and get a
> data access exception, we need to check the exception
> table just like a normal fault does.
>
> The spitfire DAX handler was doing this, but such logic
> was missing from the sun4v DAX code.
>
> Reported-by: Dennis Gilmore <dgilmore@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
> index c824df1..eb19724 100644
> --- a/arch/sparc64/kernel/traps.c
> +++ b/arch/sparc64/kernel/traps.c
> @@ -1,6 +1,6 @@
>  /* arch/sparc64/kernel/traps.c
>   *
> - * Copyright (C) 1995,1997,2008 David S. Miller (davem@davemloft.net)
> + * Copyright (C) 1995,1997,2008,2009 David S. Miller (davem@davemloft.net)
>   * Copyright (C) 1997,1999,2000 Jakub Jelinek (jakub@redhat.com)
>   */
>
> @@ -262,6 +262,21 @@ void sun4v_data_access_exception(struct pt_regs *regs,
> unsigned long addr, unsig return;
>
>  	if (regs->tstate & TSTATE_PRIV) {
> +		/* Test if this comes from uaccess places. */
> +		const struct exception_table_entry *entry;
> +
> +		entry = search_exception_tables(regs->tpc);
> +		if (entry) {
> +			/* Ouch, somebody is trying VM hole tricks on us... */
> +#ifdef DEBUG_EXCEPTIONS
> +			printk("Exception: PC<%016lx> faddr<UNKNOWN>\n", regs->tpc);
> +			printk("EX_TABLE: insn<%016lx> fixup<%016lx>\n",
> +			       regs->tpc, entry->fixup);
> +#endif
> +			regs->tpc = entry->fixup;
> +			regs->tnpc = regs->tpc + 4;
> +			return;
> +		}
>  		printk("sun4v_data_access_exception: ADDR[%016lx] "
>  		       "CTX[%04x] TYPE[%04x], going.\n",
>  		       addr, ctx, type);
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--nextPart1928366.XdZe4kIJxV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkl5/w4ACgkQkSxm47BaWff+fgCgwUzYy2JdlwFxTy3wNm4Bq31N
dQ4AnjvNR/Evw/6nQCjNnqBHRSdwnnUD
=DDi+
-----END PGP SIGNATURE-----

--nextPart1928366.XdZe4kIJxV--
