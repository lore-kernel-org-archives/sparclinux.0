From: Paul Mackerras <paulus@samba.org>
Date: Mon, 24 Mar 2008 07:55:41 +0000
Subject: Re: [PATCH 4/8] powerpc ptrace: forced_successful_syscall_return()
Message-Id: <18407.24189.707297.767237@cargo.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319211936.28E8B26F9A7@magilla.localdomain>
In-Reply-To: <20080319211936.28E8B26F9A7-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Roland McGrath writes:

> Define the forced_successful_syscall_return() macro to
> pair with our force_successful_syscall_return() definition.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Looks OK to me, but what's it useful for?

Paul.
