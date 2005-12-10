From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 10 Dec 2005 23:00:34 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051210.150034.67577008.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
	<20051210.143523.106612727.davem@davemloft.net>
	<Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
In-Reply-To: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Sat, 10 Dec 2005 23:52:01 +0100 (CET)

> IO[X:6761]: 
> remap_pfn_range(s[71800000]e[71c10000],f[71800000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
> IO[X:6761]: 
> remap_pfn_range(s[71800000]e[71c10000],f[71802000],pfn[1fc0060],sz[2000],prot[80000000000006b0])

That's the problem, we're being called twice over the same
area.

Now we need to figure out why.  Please add this patch and give
us the new log output.  I'm going to a hockey game so I won't
be able to look at this until later this evening.

Thanks.

--- drivers/video/sbuslib.c.~1~	2005-11-13 17:58:46.000000000 -0800
+++ drivers/video/sbuslib.c	2005-12-10 15:00:25.000000000 -0800
@@ -52,6 +52,10 @@
 
 	off = vma->vm_pgoff << PAGE_SHIFT;
 
+#if 1
+	printk("sbusfb_mmap: start[%lx] size[%lx] off[%lx]\n",
+	       vma->vm_start, size, off);
+#endif
 	/* To stop the swapper from even considering these pages */
 	vma->vm_flags |= (VM_IO | VM_RESERVED);
 	
@@ -69,12 +73,19 @@
 				map_offset = (physbase + map[i].poff) & POFF_MASK;
 				break;
 			}
+#if 1
+		printk("sbusfb_mmap: page[%x] map_size[%lx]\n",
+		       page, map_size);
+#endif
 		if (!map_size){
 			page += PAGE_SIZE;
 			continue;
 		}
 		if (page + map_size > size)
 			map_size = size - page;
+#if 1
+		printk("sbusfb_mmap: map_size is now %lx\n", map_size);
+#endif
 		r = io_remap_pfn_range(vma,
 					vma->vm_start + page,
 					MK_IOSPACE_PFN(iospace,
@@ -85,6 +96,9 @@
 			return -EAGAIN;
 		page += map_size;
 	}
+#if 1
+	printk("sbusfb_mmap: Done\n");
+#endif
 
 	return 0;
 }
