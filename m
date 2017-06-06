From: jane.chu@oracle.com
Date: Tue, 06 Jun 2017 17:04:25 +0000
Subject: Re: [PATCH v2] arch/sparc: support NR_CPUS = 4096
Message-Id: <c0b19f67-db79-c171-6f5b-6ecd1ec42078@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496702911-717442-1-git-send-email-jane.chu@oracle.com>
 <20170605.205739.2124313705421284534.davem@davemloft.net>
 <6255d34e-499d-db38-ec86-8930828684de@oracle.com>
 <20170605.232724.386554178947981058.davem@davemloft.net>
In-Reply-To: <20170605.232724.386554178947981058.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tglx@linutronix.de, atish.patra@oracle.com, Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/05/2017 08:27 PM, David Miller wrote:

> From: jane.chu@oracle.com
> Date: Mon, 5 Jun 2017 20:03:28 -0700
>
>> On sun4v sparc, it looks like kzalloc(64, GFP_KERNEL) ends up
>> allocating from kmalloc_caches[6] - a 64-byte kmem-cache allocated
>> by kmem_cache_init() with SLAB_HWCACHE_ALIGN flag set, so it's in
>> l3-cache-line-size alignment, i.e. 64byte.  I printed out the
>> 'mondo' pa and verified that.
> Please check this, because that is an implementation detail.  We have
> three SLAB allocators.
>
> For example, if the user enables SLOB, I bet you don't get that
> alignment.
>
> The only thing we are universally guaranteed is ARCH_KMALLOC_MINALIGN.
>
> Please implement this properly, rather than relying upon things like
> the above.

Good point, agreed.  I will update the patch.

thanks!
-jane

>
> Thank you.

