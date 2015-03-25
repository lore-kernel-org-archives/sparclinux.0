From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Mar 2015 21:05:42 +0000
Subject: Re: [PATCH v7 0/3] Generic IOMMU pooled allocator
Message-Id: <1427317542.6468.85.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <20150325.141235.238730018688792495.davem@davemloft.net>
In-Reply-To: <20150325.141235.238730018688792495.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, 2015-03-25 at 14:12 -0400, David Miller wrote:
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Wed, 25 Mar 2015 13:34:45 -0400
> 
> > Changes from patchv6: moved pool_hash initialization to
> > lib/iommu-common.c and cleaned up code duplication from 
> > sun4v/sun4u/ldc. 
> 
> Looks good to me.
> 
> PowerPC folks, what do you think?

I'll give it another look today.

Cheers,
Ben.


