From: RChan <rspchan@starhub.net.sg>
Date: Thu, 14 Oct 2004 01:59:17 +0000
Subject: Re: E250 console on kernel 2.6.8.1
Message-Id: <416DDD75.1070605@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
References: <416D3441.5090702@dor.state.ma.us>
In-Reply-To: <416D3441.5090702@dor.state.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I used to have this working even with home-made kernels before my E250 died.
Can I suggest you try the Aurora kernels from www.auroralinux.org - they 
are around
2.6.8 by now. If that works then you might wish to compare .config to see
if something is missing in yours.

Ron Murray wrote:

>    I'm working on installing Linux on an Enterprise 250. This is my 
> first linux-on-sparc install, but I've been using linux on i386 and 
> alpha for years.
>
>    I'm having a lot of trouble getting the console working under 
> kernel 2.6.8.1. I'm using Debian, and it all works fine under the 
> 2.4.8 kernel that comes with Debian stable. When I compile a 2.6.8.1 
> kernel, however, and try to run it, it starts off well until it 
> switches to its own console, at which point the screen goes blank, the 
> monitor claims "Invalid Sync", and that's all. The machine boots ok (I 
> can get to it with SSH once it comes up), but the console doesn't 
> work. I get exactly the same results using a Debian-compiled 2.6.8 
> kernel from Debian testing.
>
> The machine is an Enterprise 250, 256M memory, with a Raptor GFX 
> graphics board installed. Below is the graphics and console sections 
> from my config file, and the first couple of pages from my messages 
> log. From the latter, are the lines concerning PCI Master Aborts 
> significant?
>
> I'm not sure at this point whether the board is generating video or 
> not when the console goes blank. It's possible that it's generating a 
> sync range that the monitor can't handle, but I think that's unlikely 
> since the monitor is an Hitachi CM2110MU, supposed to be capable of 
> 31-85 HKz horizontal and 50-160 Hz vertical. I've tried lots of 
> video=pm2fb.... lines in SILO with no visible effect.
>
> Any help getting the console working would be appreciated.
>
> Thanks,
>
>  .....Ron
>
> From .config:
> #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_CIRRUS is not set
> CONFIG_FB_PM2=y
> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_BW2 is not set
> # CONFIG_FB_CG3 is not set
> CONFIG_FB_CG6=y
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> CONFIG_FB_RADEON=y
> # CONFIG_FB_RADEON_I2C is not set
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GX=y
> # CONFIG_FB_ATY_XL_INIT is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> CONFIG_FB_SBUS=y
> CONFIG_FB_FFB=y
> # CONFIG_FB_TCX is not set
> # CONFIG_FB_CG14 is not set
> # CONFIG_FB_P9100 is not set
> # CONFIG_FB_LEO is not set
> # CONFIG_FB_PCI is not set
> # CONFIG_FB_VIRTUAL is not set
>
> #
> # Console display driver support
> #
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_PROM_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_SUN8x16=y
> # CONFIG_FONT_SUN12x22 is not set
>
>
>
> /var/log/messages: [caution: mailer word-wraps!!]
> Oct 13 09:05:29 curly2 syslogd 1.4.1#15: restart.
> Oct 13 09:05:29 curly2 kernel: klogd 1.4.1#15, log source = /proc/kmsg 
> started.
> Oct 13 09:05:29 curly2 kernel: Inspecting boot/System.map-2.6.8-curly2-2
> Oct 13 09:05:30 curly2 kernel: Loaded 29197 symbols from 
> boot/System.map-2.6.8-curly2-2.
> Oct 13 09:05:30 curly2 kernel: Symbols match kernel version 2.6.8.
> Oct 13 09:05:30 curly2 kernel: No module symbols loaded - kernel 
> modules not enabled.
> Oct 13 09:05:30 curly2 kernel: PROMLIB: Sun IEEE Boot Prom 3.16.1 
> 1999/04/19 07:55
> Oct 13 09:05:30 curly2 kernel: Linux version 2.6.8-curly2-2 
> (root@curly2) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Tue Oct 
> 12 15:30:30 EDT 2004
> Oct 13 09:05:30 curly2 kernel: ARCH: SUN4U
> Oct 13 09:05:30 curly2 kernel: Ethernet address: 08:00:20:e7:08:c0
> Oct 13 09:05:30 curly2 kernel: Built 1 zonelists
> Oct 13 09:05:30 curly2 kernel: Kernel command line: root=/dev/sda1 ro
> Oct 13 09:05:30 curly2 kernel: PID hash table entries: 1024 (order 10: 
> 16384 bytes)
> Oct 13 09:05:30 curly2 kernel: Console: colour dummy device 80x25
> Oct 13 09:05:30 curly2 kernel: Dentry cache hash table entries: 32768 
> (order: 5, 262144 bytes)
> Oct 13 09:05:30 curly2 kernel: Inode-cache hash table entries: 16384 
> (order: 4, 131072 bytes)
> Oct 13 09:05:30 curly2 kernel: Memory: 254016k available (2504k kernel 
> code, 1104k data, 160k init) [fffff80000000000,000000000feb8000]
> Oct 13 09:05:30 curly2 kernel: Calibrating delay loop... 796.67 BogoMIPS
> Oct 13 09:05:30 curly2 kernel: Mount-cache hash table entries: 512 
> (order: 0, 8192 bytes)
> Oct 13 09:05:30 curly2 kernel: Calibrating delay loop... 796.67 BogoMIPS
> Oct 13 09:05:30 curly2 kernel: CPU 1: synchronized TICK with master 
> CPU (last diff -24 cycles,maxerr 712 cycles)
> Oct 13 09:05:30 curly2 kernel: Brought up 2 CPUs
> Oct 13 09:05:30 curly2 kernel: Total of 2 processors activated 
> (1593.34 BogoMIPS).
> Oct 13 09:05:30 curly2 kernel: SMP: Calibrating ecache flush... Using 
> heuristic of 1489236 cycles, 3 ticks.
> Oct 13 09:05:30 curly2 kernel: NET: Registered protocol family 16
> Oct 13 09:05:30 curly2 kernel: PCI: Probing for controllers.
> Oct 13 09:05:30 curly2 kernel: PCI: Found PSYCHO, control regs at 
> 000001fe00000000
> Oct 13 09:05:30 curly2 kernel: PSYCHO: Shared PCI config space at 
> 000001fe01000000
> Oct 13 09:05:30 curly2 kernel: PCI-IRQ: Routing bus[ 0] slot[ 5] 
> map[0] to INO[1c]
> Oct 13 09:05:30 curly2 kernel: PCI0(PBMB): Bus running at 33MHz
> Oct 13 09:05:30 curly2 kernel: PCI-IRQ: Routing bus[81] slot[ 0] 
> map[1] to INO[01]
> Oct 13 09:05:30 curly2 kernel: PCI-IRQ: Routing bus[81] slot[ 1] 
> map[1] to INO[02]
> Oct 13 09:05:30 curly2 kernel: PCI-IRQ: Routing bus[81] slot[ 2] 
> map[1] to INO[03]
> Oct 13 09:05:30 curly2 kernel: PCI-IRQ: Routing bus[81] slot[ 3] 
> map[1] to INO[00]
> Oct 13 09:05:30 curly2 kernel: PCI0(PBMA): Bus running at 33MHz
> Oct 13 09:05:30 curly2 kernel: PSYCHO0(PBMB): PCI Error, primary error 
> type[Master Abort]
> Oct 13 09:05:30 curly2 kernel: PSYCHO0(PBMB): bytemask[000f] 
> UPA_MID[01] was_block(0)
> Oct 13 09:05:30 curly2 kernel: PSYCHO0(PBMB): PCI AFAR [000001fe01000a10]
> Oct 13 09:05:30 curly2 kernel: PSYCHO0(PBMB): PCI Secondary errors 
> [(Master Abort)]
> Oct 13 09:05:30 curly2 kernel: PCI0(PBMB): Device [0001:00:00.0] 
> received Master Abort [0000000000002280]
> Oct 13 09:05:30 curly2 kernel: ebus0: [auxio] [power] [SUNW,pll] [sc] 
> [se] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] 
> [SUNW,envctrltwo]
> Oct 13 09:05:30 curly2 kernel: power: Control reg at 000001fff1724000 
> ... not using powerd.
> Oct 13 09:05:30 curly2 kernel: SCSI subsystem initialized
> Oct 13 09:05:30 curly2 kernel: fb0: TVP4020 frame buffer device, 
> memory = 4096K.
> Oct 13 09:05:30 curly2 kernel: Total HugeTLB memory allocated, 0
> Oct 13 09:05:30 curly2 kernel: SGI XFS with ACLs, security attributes, 
> large block/inode numbers, no debug enabled
> Oct 13 09:05:30 curly2 kernel: Initializing Cryptographic API
> Oct 13 09:05:30 curly2 kernel: Console: switching to mono PROM 80x34
> Oct 13 09:05:30 curly2 kernel: Console: switching to colour frame 
> buffer device 80x30
> Oct 13 09:05:30 curly2 kernel: Linux video capture interface: v1.00
>
>
> **********************************************************************
> This email and any files transmitted with it are confidential and 
> intended solely for the use of the individual or entity to whom they   
> are addressed. If you have received this email in error please notify 
> the system manager at postmaster at dor.state.ma.us.
> **********************************************************************
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

