From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Sun, 14 Nov 2004 21:32:58 +0000
Subject: Strange mapping in Qemu
Message-Id: <BAY12-F7stPGtPrPrvC00075903@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I got the GDB breakpoints working in Qemu, so now it's possible to 
single-step inside Linux.

I'm trying to understand what is the problem with Linux running in Qemu. The 
page tables created in srmmu_inherit_prom_mappings are wrong, maybe because 
the nocache mapping at 0xfc000000 is totally bogus.

This is what Proll creates, 1:1 mapping for memory and rom, mapping from end 
of memory to after rom (bss for Proll).

Root ptr: 0x007de000, ctx: 0
VA: 0x00000000, PA: 0x00000000 PDE: 0x0007dea1
VA: 0x00000000, PA: 0x00000000 PDE: 0x0007deb1
  VA: 0x00000000, PA: 0x00000000 PTE: 0x000000be
... cut ...
  VA: 0x0003f000, PA: 0x0003f000 PTE: 0x00003fbe
VA: 0x00040000, PA: 0x00040000 PDE: 0x0007dec1
  VA: 0x00040000, PA: 0x00040000 PTE: 0x000040be
...
  VA: 0x007ff000, PA: 0x007ff000 PTE: 0x0007ffbe
VA: 0xff000000, PA: 0xffffffff PDE: 0x0007de81
VA: 0xffd00000, PA: 0xffd00000 PDE: 0x0007de91
  VA: 0xffd00000, PA: 0xffd00000 PTE: 0x0ffd00be
...
  VA: 0xffd08000, PA: 0xffd08000 PTE: 0x0ffd08be
  VA: 0xffd09000, PA: 0x007cd000 PTE: 0x0007cdbe
...
  VA: 0xffd3b000, PA: 0x007ff000 PTE: 0x0007ffbe

This is what Linux created before poke_swift(), mapping from memory to 
0xf0000000 (ok) and then the bogus entries. PA=0xffffffff means that the 
mapping is invalid.

MMU dump:
Root ptr: 0x00380800, ctx: 0
VA: 0xf0000000, PA: 0x00000000 PDE: 0x000000be
VA: 0xf0000000, PA: 0x00000000 PDE: 0x000000be
  VA: 0xf0000000, PA: 0x00000000 PTE: 0x000000be
...
  VA: 0xf003f000, PA: 0x0003f000 PTE: 0x000000be
VA: 0xf0040000, PA: 0x00040000 PDE: 0x000000be
  VA: 0xf0040000, PA: 0x00040000 PTE: 0x000000be
...
  VA: 0xf0fff000, PA: 0x00fff000 PTE: 0x000000be
VA: 0xfc000000, PA: 0xffffffff PDE: 0x00000001
VA: 0xfcc00000, PA: 0xffffffff PDE: 0x00000001
...
VA: 0xfcfc0000, PA: 0xffffffff PDE: 0x00000001
VA: 0xff000000, PA: 0xffffffff PDE: 0x00000001
VA: 0xffc00000, PA: 0xffffffff PDE: 0x00000001
...
VA: 0xfffc0000, PA: 0xffffffff PDE: 0x00000001

Maybe someone sees immediately what is wrong?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
hthttp://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

