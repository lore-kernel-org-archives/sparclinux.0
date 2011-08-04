From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 09:48:56 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110804.024856.521471648575828767.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110728104017.GA27861@entuzijast.net>
In-Reply-To: <20110728104017.GA27861@entuzijast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 4 Aug 2011 11:43:15 +0200

> It should be fairly trivial:
> 
> diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
> index 8600eb2..1d32b54 100644
> --- a/arch/sparc/lib/atomic32.c
> +++ b/arch/sparc/lib/atomic32.c
> @@ -65,7 +65,7 @@ int __atomic_add_unless(atomic_t *v, int a, int u)
>         if (ret != u)
>                 v->counter += a;
>         spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
> -       return ret != u;
> +       return ret;
>  }
>  EXPORT_SYMBOL(__atomic_add_unless);

Applied, thanks Josip.
