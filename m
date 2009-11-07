From: David Miller <davem@davemloft.net>
Date: Sat, 07 Nov 2009 06:15:11 +0000
Subject: Re: kernel BUG at arch/sparc/mm/fault_64.c:270!
Message-Id: <20091106.221511.136296161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 7 Nov 2009 00:36:23 -0500 (EST)

> - If the controller corrupted common kernel data, the bug would show on 
> all processes or on all "vmstat" processes and it wouldn't go away after 
> clearing disk cache.

Not necessarily true.

I suspect the corrupted directory page ext3 was accessing
caused it to walk to arbitrary parts of kernel ram and
corrupt it.

So only a program which accessed specific files would
get us into that corruption situation.

It could be anything.  Surely we could add more protection
and careful assertions into the ext2/ext3/ext4 directory
entry traversing code (check for unaligned offsets etc.)
