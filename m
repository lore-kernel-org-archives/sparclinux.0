From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 18 Mar 2010 15:47:47 +0000
Subject: Re: [V2 PATCH 08/10] arch/powerpc: Remove obsolete
Message-Id: <20100318154747.GA7767@oksana.dev.rtsoft.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152250.21082.35352.stgit@angua>
In-Reply-To: <20100318152250.21082.35352.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Hi Grant,

On Thu, Mar 18, 2010 at 09:22:50AM -0600, Grant Likely wrote:
> Both dev_archdata.of_node and of_device.node are duplications of the
> device.of_node value.  This patch removes them.

Yeah, they're plain duplications since you introduced dev.of_node.
I wonder what was the problem with using dev.archdata.of_node?
Why dev.of_node is better?

Also, by using dev.of_node directly you have to introduce ugly
#ifdefs in the non-OF code (as in i2c patch), which you don't
need with transparent archdata and accessors, which you've just
removed:

> -static inline void dev_archdata_set_node(struct dev_archdata *ad,
> -					 struct device_node *np)
> -{
> -	ad->of_node = np;
> -}
> -
> -static inline struct device_node *
> -dev_archdata_get_node(const struct dev_archdata *ad)
> -{
> -	return ad->of_node;
> -}

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
