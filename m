From: Bob Breuer <breuerr@mc.net>
Date: Sun, 16 Jan 2005 02:25:35 +0000
Subject: Re: Badness in map_area_pte
Message-Id: <41E9D09F.1070704@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41E96A42.7090501@mc.net>
In-Reply-To: <41E96A42.7090501@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bob Breuer wrote:
> At this point, I am guessing that some pte's allocated for the 
> framebuffer are being wrongly re-used when loading the module.
> 

The cg14 driver is not remapping the framebuffer, and is using the mappings 
that were setup by the prom and recreated in linux from 
srmmu_inherit_prom_mappings().

How can we tell vmalloc not to step on that area of memory?  Is it just from 
VMALLOC_START to END?  Let's see, for 2.6 those are 0xfe600000 and 
0xffc00000.  The prom mapped the cg14 to 0xfe700000 (8MB ram) and 0xffec0000 
(registers).  Hmm, a bit of overlap there...  And 2.4 had VMALLOC_START at 
0xfe300000.  So it would seem that if the total vmalloc'ed memory goes above 
1 meg for me, 2.6 will have problems, but 2.4 will still be fine.

Bob
