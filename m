From: David Miller <davem@davemloft.net>
Date: Tue, 18 Apr 2017 20:11:43 +0000
Subject: Re: [PATCH] sparc64: Use LOCKDEP_SMALL, not PROVE_LOCKING_SMALL
Message-Id: <20170418.161143.317690185161114627.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1491839452-480748-1-git-send-email-daniel.m.jordan@oracle.com>
In-Reply-To: <1491839452-480748-1-git-send-email-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: daniel.m.jordan@oracle.com
Date: Mon, 10 Apr 2017 11:50:52 -0400

> CONFIG_PROVE_LOCKING_SMALL shrinks the memory usage of lockdep so the
> kernel text, data, and bss fit in the required 32MB limit, but this
> option is not set for every config that enables lockdep.
> 
> A 4.10 kernel fails to boot with the console output
> 
>     Kernel: Using 8 locked TLB entries for main kernel image.
>     hypervisor_tlb_lock[2000000:0:8000000071c007c3:1]: errors with f
>     Program terminated
> 
> with these config options
> 
>     CONFIG_LOCKDEP=y
>     CONFIG_LOCK_STAT=y
>     CONFIG_PROVE_LOCKING=n
> 
> To fix, rename CONFIG_PROVE_LOCKING_SMALL to CONFIG_LOCKDEP_SMALL, and
> enable this option with CONFIG_LOCKDEP=y so we get the reduced memory
> usage every time lockdep is turned on.
> 
> Tested that CONFIG_LOCKDEP_SMALL is set to 'y' if and only if
> CONFIG_LOCKDEP is set to 'y'.  When other lockdep-related config options
> that select CONFIG_LOCKDEP are enabled (e.g. CONFIG_LOCK_STAT or
> CONFIG_PROVE_LOCKING), verified that CONFIG_LOCKDEP_SMALL is also
> enabled.
> 
> Fixes: e6b5f1be7afe ("config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Babu Moger <babu.moger@oracle.com>

Applied.
