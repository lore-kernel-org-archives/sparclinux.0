From: Daniel Smolik <marvin@mydatex.cz>
Date: Fri, 04 Aug 2006 17:58:37 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <44D38ACD.7050007@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marc Zyngier napsal(a):
>>>>>>"Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:
> 
> 
> Daniel> TPC: <sunsab_convert_to_sab+0x184/0x220>
> 
> This looks weird to me.
> 
> Could you please print the 'baud' and 'quot' variables at the
> beginning of sunsab_convert_to_sab? I suspect 'quot' being set to 0...
Yes you are right there is new output:


Console: switching to mono PROM 80x34
/pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
/pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
Console: ttyS2 (SAB82532)
SUNSAB baud:115200 quot:0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^this is added by me  as you want. 

               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(1): TL0: Kernel divide by zero. [#1]
TSTATE: 0000000080f01606 TPC: 0000000000557f50 TNPC: 0000000000557f54 Y: 0000000 
          0    Not tainted 

TPC: <sunsab_convert_to_sab+0x198/0x220>
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000000015 g3: 0000000000000 
          000 

g4: fffff8001fe819e0 g5: 0000000000000000 g6: fffff8001fd80000 g7: 0000000000000 
          008 

o0: fffff8001fe6e5b0 o1: 0000000000001cb2 o2: 0000000000000000 o3: 0000000000663 
          800 

o4: 0000000000000001 o5: 0000000000663810 sp: fffff8001fd82dc1 ret_pc: 000000000 
          0557dd0 

RPC: <sunsab_convert_to_sab+0x18/0x220>
l0: fffff8001fe6e660 l1: 000000000001c200 l2: 0000000000000000 l3: fffff8001fea6 
          960
l4: fffff8001fea6880 l5: 0000000000000000 l6: fffff8001f9cf6d0 l7: 0000000000000 
          000
i0: fffff8001fe6e5b0 i1: 0000000000001cb2 i2: 0000000000000000 i3: 000000000001c 
          200
i4: 0000000000000000 i5: fffff8001f9cde60 i6: fffff8001fd82e81 i7: 0000000000559 
          224
I7: <sunsab_console_setup+0x10c/0x1c0>
Caller[0000000000559224]: sunsab_console_setup+0x10c/0x1c0
Caller[000000000044dc00]: register_console+0x208/0x280
Caller[0000000000552fa8]: uart_add_one_port+0x290/0x2e0
Caller[000000000055938c]: sab_probe+0xb4/0xe0
Caller[0000000000429ba8]: of_device_probe+0x50/0x80
Caller[000000000055bbe0]: driver_probe_device+0x48/0xe0
Caller[000000000055bce0]: __driver_attach+0x68/0x80
Caller[000000000055b5fc]: bus_for_each_dev+0x44/0x80
Caller[000000000055b0a8]: bus_add_driver+0x70/0x140
Caller[0000000000416f24]: init+0x8c/0x2e0
Caller[0000000000417a50]: kernel_thread+0x38/0x60
Caller[0000000000417190]: rest_init+0x18/0x40
Instruction DUMP: 90100018  93366000  81802000 <9470400a> 7fffe9c3  9532a000  c2 
          0e20d0  90102004  920620b0
Kernel panic - not syncing: Attempted to kill init!
  <0>Press Stop-A (L1-A) to return to the boot prom






> 
> If possible, please try with gcc 4.0.x as well, it may help.
I try it but I must find how switch  to another compiler I have Debian Sid.

	Dan



> 
> 	M.

