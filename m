From: Balint Cristian <rezso@rdsor.ro>
Date: Sun, 09 May 2004 12:08:29 +0000
Subject: sun4c (SS IPX) serial console problem/strangenes.
Message-Id: <200405091508.29649.rezso@rdsor.ro>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi !

	I found weird thing trying (2.6.6-rc3 Keith all sparc32 patches till bk10),
plus silo-1.4.4 that there are two cases of strangeness:

1) 	Monitor+KeyBoard --> boot OK, but cgsix being enabled
half of boot dmesg screen is going on PROM console and only very late swiching to
framebuffer. I notice that 2.4.x dont do like this.

2)  Because esp OOpses while scanning devices (this is another part of the story) i decided
to catch the OOps via serial but this time more strangeness:
 
Boot device: /sbus/esp@0,800000/sd@3,0   File and args:
SILO Version 1.4.4
boot:
linux                    test
boot: test console=ttyS0,9600 video=sbus:off
Loaded kernel version 2.6.5
Loading initial ramdisk (825501 bytes at 0x300000)...
Booting Linux...
alloc_io_res(cgsix ram): cannot occupy
Program terminated
Type b (boot), c (continue), or n (new command mode)

Of course prom is like:
output-device         ttya                           screen
input-device          ttya                           keyboard

	I tryed with/without video=sbus:off with/without console=ttyS0,9600 with monitor attached, without monitor attached
to trick sense of 13W3 but _always_ "alloc_io_res(cgsix ram): cannot occupy"
	
	I think i do a digital photo of esp crash.


What to gratulate is that silo-1.4.4 on sun4c works ok, i loaded well 1.9 M of uncompressed image.

At all i use an IPX machine for test, with 64Mb RAM.
gcc-3.3.3 and latest well working binutils (Aurora one)


Thanks,

cristian
