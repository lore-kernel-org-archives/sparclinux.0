From: "David S. Miller" <davem@redhat.com>
Date: Mon, 24 May 2004 17:09:35 +0000
Subject: Re: [PATCH] Make 32 CPUs the default for SMP
Message-Id: <20040524100935.4563269b.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405241432420.8614-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405241432420.8614-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 24 May 2004 14:34:46 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> arch/sparc64/kernel/smp.c:424:2: #error Fixup cheetah_xcall_deliver Dave...
> 
> As 32 CPU-s is currently the max supported value, I suggest this patch:

Works for me, patch applied.

Thanks.
