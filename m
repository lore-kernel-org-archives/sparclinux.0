From: Bob Breuer <breuerr@mc.net>
Date: Sat, 15 Jan 2005 19:08:50 +0000
Subject: Badness in map_area_pte
Message-Id: <41E96A42.7090501@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Badness in map_area_pte at mm/vmalloc.c:126
[f0062a8c : map_area_pud+0x50/0xac ] [f0062c20 : map_vm_area+0x94/0xd0 ] 
[f00631bc : __vmalloc+0xe0/0x134 ] [f0048124 : load_module+0x38/0x9dc ] 
[f0048b3c : sys_init_module+0x74/0x2dc ] [f0010cdc : 
syscall_is_too_hard+0x34/0x40 ] [00020df8 : 0x20df8 ]


I am getting multiple stack dumps like this one when I do a "modprobe nfs" 
with kernel 2.6.11-rc1 on my SS20.  This only happens when I use the 
framebuffer console (cg14), and when it happens the top part of the display 
gets corrupted.

Here is line 126 of vmalloc.c:
   WARN_ON(!pte_none(*pte));

At this point, I am guessing that some pte's allocated for the framebuffer 
are being wrongly re-used when loading the module.

Bob
