From: David Miller <davem@davemloft.net>
Date: Wed, 19 Mar 2008 21:30:37 +0000
Subject: Re: [PATCH 5/8] sparc64 ptrace: forced_successful_syscall_return()
Message-Id: <20080319.143037.180042261.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212001.2DB8526F995@magilla.localdomain>
In-Reply-To: <20080319212001.2DB8526F995-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Roland McGrath <roland@redhat.com>
Date: Wed, 19 Mar 2008 14:20:01 -0700 (PDT)

> Define the forced_successful_syscall_return() macro to
> pair with our force_successful_syscall_return() definition.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
