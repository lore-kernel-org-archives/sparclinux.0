From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 29 Apr 2004 20:29:59 +0000
Subject: Re: 2.6.6-rc boot problems seem to come from nr_free_pages() call
Message-Id: <20040429202959.GF27793@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040429180331.GC27793@artsapartment.org>
In-Reply-To: <20040429180331.GC27793@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 29, 2004 at 01:03:31PM -0500, Art Haas wrote:
> 
> [ ... snip ... ]
> With these patches in place, the following values are observed during
> bootup. vfs_caches_init() is called with 46073 mempages (my machine has
> 512M memory, 50M swap). Setting the 'reserve' variable calls
> nr_free_pages(), and sets this value to 2147361266 - 2G!. The mempages
> value is then adjusted to 2177652103. This value is then used when
> calling dcache_init() and inodes_init(). In dcache_init(), the
> 'dhash_entries" variable gets set to 1073826051, then after the
> multiplication it is 336808 due to overflow. In inodes_init(), the
> 'ihash_entries' variable is set to 536913025, then after the
> multiplication it goes up to 2147652100. As I do not see the print out
> of the 'order' variable, it looks like things get stuck in the for loop
> that increments order.
> 
> I'll be investigating the nr_free_pages() stuff to see if I can figure
> out where things look like they go wrong. Perhaps some variable is not
> initialized, or maybe sparc32 needs some magic done for the
> zone->free_pages stuff to be correct.
> 

Replying to myself ...

I added some printk() stuff around nr_free_pages(); and this function
returns 127661. The expression used to calculate 'reserve' is going
negative (and then gigantic) because a large unsigned number is
subtracted from a smaller unsigned number.

Art
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
