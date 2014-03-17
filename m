From: David Miller <davem@davemloft.net>
Date: Mon, 17 Mar 2014 19:55:22 +0000
Subject: Re: [PATCH] sparc64: don't treat 64-bit syscall return codes as 32-bit
Message-Id: <20140317.155522.620758577348677994.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <53232349.6000309@oracle.com>
In-Reply-To: <53232349.6000309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 14 Mar 2014 10:42:01 -0500

> When checking a system call return code for an error,
> linux_sparc_syscall was sign-extending the lower 32-bit value and
> comparing it to -ERESTART_RESTARTBLOCK. lseek can return valid return
> codes whose lower 32-bits alone would indicate a failure (such as 4G-1).
> Use the whole 64-bit value to check for errors. Only the 32-bit path
> should sign extend the lower 32-bit value.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Bob Picco <bob.picco@oracle.com>
> Acked-by: Allen Pais <allen.pais@oracle.com>

Looks good, applied and queued up for -stable, thanks!
