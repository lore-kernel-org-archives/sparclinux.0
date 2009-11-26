From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 04:06:47 +0000
Subject: Re: [PATCH 08/11] of: Merge of_node_get() and of_node_put()
Message-Id: <1259208407.16367.233.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	 <20091124081918.6216.77775.stgit@angua>
In-Reply-To: <20091124081918.6216.77775.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:

>  
> +#if !defined(CONFIG_SPARC)   /* SPARC doesn't do ref counting (yet) */
> +/**

Make this a Kconfig symbol, something like CONFIG_OF_DYNAMIC. You need
refcounting when you can add/remove nodes dynamically. Some embedded
archs might want the option to not enable that and save space.

Cheers,
Ben.


