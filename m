From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 03 May 2004 20:23:43 +0000
Subject: Re: Found the cause of my 2.6.6-rc boot failures
Message-Id: <20040503202343.GA20843@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040430015234.GH27793@artsapartment.org>
In-Reply-To: <20040430015234.GH27793@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 03, 2004 at 01:15:14PM -0500, Art Haas wrote:

> After applying the patch, and building and installing the kernel, I am
> happy to report my first successful boot of the 2.6.6-rc kernels! My
> kernel code is Linus's BK from yesterday afternoon/evening, so the
> version I'm running is really 2.6.6-rc3 + BK.

Glad to hear it.

> Memory: 510644k/523580k available (1364k kernel code, 12312k reserved,
>         344k data, 120k init, 326972k highmem)
> Calibrating delay loop... 59.80 BogoMIPS
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> 
> I had been fiddling with a patch that set 'num_physpages' to the value
> of 'highend_pfn', but my patch had failed. I believe the value that my
> patch produced, and your patch produced, are identical - a printk()
> addition would confirm this. Still, the kernel I had built failed to
> boot, whereas the kernel with your patch is up and running. Yay!

Blindly setting it to highend_pfn is correct only for systems with
contiguous zero-based memory larger than 192MB.  For sparse or small
memory systems it would be wrong.

You can actually see what the value is by looking at the output, which
is now like x86 - 510644k/523580k is nr_free_pages() << (PAGE_SHIFT -
10) and num_physpages << (PAGE_SHIFT - 10).

> Please send this patch to Linus so it can get into the official 2.6.6
> release.

I'll send it along.

Thanks for testing.

-- 
Keith M Wesolowski
