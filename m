From: David Miller <davem@davemloft.net>
Date: Thu, 20 Feb 2014 00:44:01 +0000
Subject: Re: [PATCH 1/2] sparc64 - strict devmem
Message-Id: <20140219.194401.113463560255191751.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1392750679-6966-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1392750679-6966-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 18 Feb 2014 14:11:18 -0500

> +#ifdef CONFIG_STRICT_DEVMEM
> +/* devmem_is_allowed for sparc.
> + */
> +int devmem_is_allowed(unsigned long pagenr)
> +{
> +	int  rc = page_is_ram(pagenr);
> +
> +	return rc;
> +}
> +#endif

We already go through all of the effort to build
sparc64_valid_addr_bitmap, please use it via kern_addr_valid().

Using resources is over-engineering.  We never provided that stuff
in /proc/iomem on sparc so no need to add it unnecessarily.

Furthermore, the /dev/kmem device probably needs similar restrictions,
it just blindly copies things as long as the address is lower than
high memory.

All of this stuff can potentially trigger bus errors, and really the
right thing to do is:

1) Add the necessary address validations as being discussed here

2) Put the accessed behind something like the PCI config space poking
   framework, it is able to recover from BUS errors cleanly.  Take
   a look at the code mentioning 'pci_poke_in_progress'.

