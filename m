From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 03 May 2004 18:15:14 +0000
Subject: Re: Found the cause of my 2.6.6-rc boot failures
Message-Id: <20040503181514.GE29241@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040430015234.GH27793@artsapartment.org>
In-Reply-To: <20040430015234.GH27793@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

After applying the patch, and building and installing the kernel, I am
happy to report my first successful boot of the 2.6.6-rc kernels! My
kernel code is Linus's BK from yesterday afternoon/evening, so the
version I'm running is really 2.6.6-rc3 + BK.

Here's a bit of dmesg output with the memory info ...

319MB HIGHMEM available.
On node 0 totalpages: 130399
  DMA zone: 48656 pages, LIFO batch:11
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 81743 pages, LIFO batch:16
Power off control detected.
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
Memory: 510644k/523580k available (1364k kernel code, 12312k reserved,
        344k data, 120k init, 326972k highmem)
Calibrating delay loop... 59.80 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

I had been fiddling with a patch that set 'num_physpages' to the value
of 'highend_pfn', but my patch had failed. I believe the value that my
patch produced, and your patch produced, are identical - a printk()
addition would confirm this. Still, the kernel I had built failed to
boot, whereas the kernel with your patch is up and running. Yay!

Please send this patch to Linus so it can get into the official 2.6.6
release.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
