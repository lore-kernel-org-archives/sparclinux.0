From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Tue, 01 Feb 2011 10:03:05 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110201100305.GF9874@axis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110115.211722.39173519.davem@davemloft.net> <20110116.220755.179947617.davem@davemloft.net> <20110117090557.GF9874@axis.com> <20110131.211116.115946085.davem@davemloft.net>
In-Reply-To: <20110131.211116.115946085.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: "richm@oldelvet.org.uk" <richm@oldelvet.org.uk>, "609371@bugs.debian.org" <609371@bugs.debian.org>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "jeffm@suse.com" <jeffm@suse.com>

On Tue, Feb 01, 2011 at 06:11:16AM +0100, David Miller wrote:
> Jesper, could you please review this?

Looks good!

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> --------------------
> klist: Fix object alignment on 64-bit.
> 
> Commit c0e69a5bbc6fc74184aa043aadb9a53bc58f953b ("klist.c: bit 0 in
> pointer can't be used as flag") intended to make sure that all klist
> objects were at least pointer size aligned, but used the constant "4"
> which only works on 32-bit.
> 
> Use "sizeof(void *)" which is correct in all cases.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/include/linux/klist.h b/include/linux/klist.h
> index e91a4e5..a370ce5 100644
> --- a/include/linux/klist.h
> +++ b/include/linux/klist.h
> @@ -22,7 +22,7 @@ struct klist {
>  	struct list_head	k_list;
>  	void			(*get)(struct klist_node *);
>  	void			(*put)(struct klist_node *);
> -} __attribute__ ((aligned (4)));
> +} __attribute__ ((aligned (sizeof(void *))));
>  
>  #define KLIST_INIT(_name, _get, _put)					\
>  	{ .k_lock	= __SPIN_LOCK_UNLOCKED(_name.k_lock),		\
/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
