From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 01:24:34 +0000
Subject: Re: [PATCH V2] sparc64: mem boot option correction
Message-Id: <20140916.212434.652632875527954139.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874194-12154-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874194-12154-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 09:29:54 -0400

> From: bob picco <bpicco@meloft.net>
> 
> The "mem" boot option can result in many unexpected consequences. This patch
> attempts to prevent boot hangs which have been experienced on T4-4 and T5-8.
> Basically the boot loader allocates vmlinuz and initrd higher in available
> OBP physical memory. For example, on a 2Tb T5-8 it isn't possible to boot
> with mem G.
> 
> The patch utilizes memblock to avoid reserved regions and trim memory which
> is only free. Other improvements are possible for a multi-node machine.
 ...
> The patch was tested on T4-1, T5-8 and Jalap?no.
> 
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Bob Picco <bob.picco@oracle.com>
> ---
> V2: correct programming style syntax.

I applied this with one small stylistic change:

> +	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid)

	for_each_free_mem_range(i, NUMA_NO_NODE, &pa_start, &pa_end, NULL)

> +	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid) {

	for_each_free_mem_range(i, NUMA_NO_NODE, &pa_start, &pa_end, NULL) {

And I killed the now-unused local variables.

Thanks Bob.
