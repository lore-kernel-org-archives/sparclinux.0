From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Tue, 16 Nov 2004 21:53:52 +0000
Subject: Re: Strange mapping in Qemu
Message-Id: <BAY12-F59wPiyAphwFu0008ad6b@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
In-Reply-To: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>Maybe srmmu_hwprobe() is doing something wrong under qemu?

It turned out to be a bug in the swap instruction, %o1 wasn't loaded to 
internal register T1 so a bogus entry was put to page table.

(gdb) p/x $o1
$73 = 0x38041
(gdb) stepi
1068                    pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
IN: srmmu_early_allocate_ptable_skeleton
0xf02f481c:  swap  [ %o0 ], %o1
(gdb) x $o0
0xf03803f0:     0x08f02f28

Now that I fixed it:
(gdb) x $o0
0xf03803f0:     0x00038041

... the page tables are OK and Linux reaches con_init()!

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

