From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 04:07:48 +0000
Subject: Re: [PATCH 09/11] of: merge of_attach_node() & of_detach_node()
Message-Id: <1259208468.16367.234.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	 <20091124081931.6216.27102.stgit@angua>
In-Reply-To: <20091124081931.6216.27102.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze

Some of those guys might wnat to be in of_dynamic (see previous email)

Remember: We want to keep the footprint low for embedded archs that
don't want to do dynamic stuff. Really low.

Cheers,
Ben.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/include/asm/prom.h |    4 --
>  arch/microblaze/kernel/prom.c      |   59 -----------------------------------
>  arch/powerpc/include/asm/prom.h    |    4 --
>  arch/powerpc/kernel/prom.c         |   59 -----------------------------------
>  drivers/of/base.c                  |   60 ++++++++++++++++++++++++++++++++++++
>  include/linux/of.h                 |    4 ++
>  6 files changed, 64 insertions(+), 126 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index 07d1063..6c6b386 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -39,10 +39,6 @@ extern struct device_node *of_chosen;
>  
>  extern rwlock_t devtree_lock;	/* temporary while merging */
>  
> -/* For updating the device tree at runtime */
> -extern void of_attach_node(struct device_node *);
> -extern void of_detach_node(struct device_node *);
> -
>  /* Other Prototypes */
>  extern int early_uartlite_console(void);
>  
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index c0d53b7..8c00457 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -313,65 +313,6 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  }
>  EXPORT_SYMBOL(of_find_node_by_phandle);
>  
> -/*
> - * Plug a device node into the tree and global list.
> - */
> -void of_attach_node(struct device_node *np)
> -{
> -	unsigned long flags;
> -
> -	write_lock_irqsave(&devtree_lock, flags);
> -	np->sibling = np->parent->child;
> -	np->allnext = allnodes;
> -	np->parent->child = np;
> -	allnodes = np;
> -	write_unlock_irqrestore(&devtree_lock, flags);
> -}
> -
> -/*
> - * "Unplug" a node from the device tree.  The caller must hold
> - * a reference to the node.  The memory associated with the node
> - * is not freed until its refcount goes to zero.
> - */
> -void of_detach_node(struct device_node *np)
> -{
> -	struct device_node *parent;
> -	unsigned long flags;
> -
> -	write_lock_irqsave(&devtree_lock, flags);
> -
> -	parent = np->parent;
> -	if (!parent)
> -		goto out_unlock;
> -
> -	if (allnodes = np)
> -		allnodes = np->allnext;
> -	else {
> -		struct device_node *prev;
> -		for (prev = allnodes;
> -		     prev->allnext != np;
> -		     prev = prev->allnext)
> -			;
> -		prev->allnext = np->allnext;
> -	}
> -
> -	if (parent->child = np)
> -		parent->child = np->sibling;
> -	else {
> -		struct device_node *prevsib;
> -		for (prevsib = np->parent->child;
> -		     prevsib->sibling != np;
> -		     prevsib = prevsib->sibling)
> -			;
> -		prevsib->sibling = np->sibling;
> -	}
> -
> -	of_node_set_flag(np, OF_DETACHED);
> -
> -out_unlock:
> -	write_unlock_irqrestore(&devtree_lock, flags);
> -}
> -
>  #if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>  static struct debugfs_blob_wrapper flat_dt_blob;
>  
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 2ab9cbd..f384db8 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -34,10 +34,6 @@ extern struct device_node *of_chosen;
>  
>  #define HAVE_ARCH_DEVTREE_FIXUPS
>  
> -/* For updating the device tree at runtime */
> -extern void of_attach_node(struct device_node *);
> -extern void of_detach_node(struct device_node *);
> -
>  #ifdef CONFIG_PPC32
>  /*
>   * PCI <-> OF matching functions
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 6873db9..7d0beeb 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -740,65 +740,6 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
>  	return NULL;
>  }
>  
> -/*
> - * Plug a device node into the tree and global list.
> - */
> -void of_attach_node(struct device_node *np)
> -{
> -	unsigned long flags;
> -
> -	write_lock_irqsave(&devtree_lock, flags);
> -	np->sibling = np->parent->child;
> -	np->allnext = allnodes;
> -	np->parent->child = np;
> -	allnodes = np;
> -	write_unlock_irqrestore(&devtree_lock, flags);
> -}
> -
> -/*
> - * "Unplug" a node from the device tree.  The caller must hold
> - * a reference to the node.  The memory associated with the node
> - * is not freed until its refcount goes to zero.
> - */
> -void of_detach_node(struct device_node *np)
> -{
> -	struct device_node *parent;
> -	unsigned long flags;
> -
> -	write_lock_irqsave(&devtree_lock, flags);
> -
> -	parent = np->parent;
> -	if (!parent)
> -		goto out_unlock;
> -
> -	if (allnodes = np)
> -		allnodes = np->allnext;
> -	else {
> -		struct device_node *prev;
> -		for (prev = allnodes;
> -		     prev->allnext != np;
> -		     prev = prev->allnext)
> -			;
> -		prev->allnext = np->allnext;
> -	}
> -
> -	if (parent->child = np)
> -		parent->child = np->sibling;
> -	else {
> -		struct device_node *prevsib;
> -		for (prevsib = np->parent->child;
> -		     prevsib->sibling != np;
> -		     prevsib = prevsib->sibling)
> -			;
> -		prevsib->sibling = np->sibling;
> -	}
> -
> -	of_node_set_flag(np, OF_DETACHED);
> -
> -out_unlock:
> -	write_unlock_irqrestore(&devtree_lock, flags);
> -}
> -
>  #ifdef CONFIG_PPC_PSERIES
>  /*
>   * Fix up the uninitialized fields in a new device node:
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 4b10c89..9212b87 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -60,6 +60,66 @@ int of_n_size_cells(struct device_node *np)
>  }
>  EXPORT_SYMBOL(of_n_size_cells);
>  
> +/**
> + * of_attach_node - Plug a device node into the tree and global list.
> + */
> +void of_attach_node(struct device_node *np)
> +{
> +	unsigned long flags;
> +
> +	write_lock_irqsave(&devtree_lock, flags);
> +	np->sibling = np->parent->child;
> +	np->allnext = allnodes;
> +	np->parent->child = np;
> +	allnodes = np;
> +	write_unlock_irqrestore(&devtree_lock, flags);
> +}
> +
> +/**
> + * of_detach_node - "Unplug" a node from the device tree.
> + *
> + * The caller must hold a reference to the node.  The memory associated with
> + * the node is not freed until its refcount goes to zero.
> + */
> +void of_detach_node(struct device_node *np)
> +{
> +	struct device_node *parent;
> +	unsigned long flags;
> +
> +	write_lock_irqsave(&devtree_lock, flags);
> +
> +	parent = np->parent;
> +	if (!parent)
> +		goto out_unlock;
> +
> +	if (allnodes = np)
> +		allnodes = np->allnext;
> +	else {
> +		struct device_node *prev;
> +		for (prev = allnodes;
> +		     prev->allnext != np;
> +		     prev = prev->allnext)
> +			;
> +		prev->allnext = np->allnext;
> +	}
> +
> +	if (parent->child = np)
> +		parent->child = np->sibling;
> +	else {
> +		struct device_node *prevsib;
> +		for (prevsib = np->parent->child;
> +		     prevsib->sibling != np;
> +		     prevsib = prevsib->sibling)
> +			;
> +		prevsib->sibling = np->sibling;
> +	}
> +
> +	of_node_set_flag(np, OF_DETACHED);
> +
> +out_unlock:
> +	write_unlock_irqrestore(&devtree_lock, flags);
> +}
> +
>  #if !defined(CONFIG_SPARC)   /* SPARC doesn't do ref counting (yet) */
>  /**
>   *	of_node_get - Increment refcount of a node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index d4c014a..0a51742 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -130,6 +130,10 @@ static inline unsigned long of_read_ulong(const u32 *cell, int size)
>  
>  #define OF_BAD_ADDR	((u64)-1)
>  
> +/* For updating the device tree at runtime */
> +extern void of_attach_node(struct device_node *);
> +extern void of_detach_node(struct device_node *);
> +
>  extern struct device_node *of_find_node_by_name(struct device_node *from,
>  	const char *name);
>  #define for_each_node_by_name(dn, name) \


