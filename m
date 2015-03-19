From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 19 Mar 2015 02:46:15 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1426733175.4770.109.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
In-Reply-To: <20150318.222517.1444725543017433108.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sowmini.varadhan@oracle.com, Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, 2015-03-18 at 22:25 -0400, David Miller wrote:
> PowerPC folks, we're trying to kill the locking contention in our
> IOMMU allocators and noticed that you guys have a nice solution to
> this in your IOMMU code.
> 
> Sowmini put together a patch series that tries to extract out the
> generic parts of your code and place it in lib/iommu-common.c so
> that both Sparc and PowerPC can make use of it.
> 
> The real test is if powerpc can be converted to use it.
> 
> So if you guys could please take a look at the current version of
> this series at:
> 
> http://patchwork.ozlabs.org/patch/449712/
> http://patchwork.ozlabs.org/patch/449713/
> http://patchwork.ozlabs.org/patch/449715/
> 
> and give us some feedback that would be great.
> 
> After we sort out making this work properly for both architectures we
> can figure out who merges which parts via what tree(s).

Sounds like a good idea ! CC'ing Anton who wrote the pool stuff. I'll
try to find somebody to work on that here & will let you know asap.

Cheers,
Ben.



