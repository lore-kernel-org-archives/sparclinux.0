From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Sep 2008 03:48:39 +0000
Subject: Re: generic IRQs for sparc32
Message-Id: <48BE0917.3060805@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080902.010944.25269623.davem@davemloft.net>
In-Reply-To: <20080902.010944.25269623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> Here is a debugging patch against sparc-next-2.6 that might help debug
> this:
>
>   
I recompiled a new kernel from scratch starting out with a default config.
I had to compile for size so it fit in memory.  I'm booting off a SunSwift
sbus card if that helps.

ESP: Mapped regs at fd016000
ESP: In esp_get_revision(), regs at fd016000
ESP: In esp_get_revision(), about to read ESP_CFG2, regs now at fd016000
Unable to handle kernel paging request at virtual address fd016000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): Oops [#1]
PSR: 404010c2 PC: f014768c NPC: f0147690 Y: 00000000    Not tainted
PC: <sbus_esp_read8+0x8/0x14>
%G: fb821ae0 fd016000  f023a96c 07200720  00000002 07200720  fb820000 
f0cce4c0
%O: fb82e33c 0000002c  0000002c fff0e000  fff0e000 f0271bec  fb821ae0 
f01450a4
RPC: <scsi_esp_register+0x1d0/0x40c>
%L: 00000080 00000024  f0146cc0 f021cf20  fb82e33c fb821b24  80000000 
fb821b18
%I: fb82e33c fb843c08  000000ff f027142c  00000000 00200200  fb821b50 
f01d5d38
Caller[f01d5d38]: esp_sbus_probe+0x3b0/0x478
Caller[f0156e64]: of_platform_device_probe+0x4c/0xb8
Caller[f012e360]: driver_probe_device+0xd4/0x190
Caller[f012e454]: __driver_attach+0x38/0x68
Caller[f012dc14]: bus_for_each_dev+0x3c/0x7c
Caller[f012d498]: bus_add_driver+0xa4/0x230
Caller[f012e674]: driver_register+0xc8/0x170
Caller[f0010044]: do_one_initcall+0x44/0x188
Caller[f024f9e4]: _etext+0x77dec/0x78408
Caller[f0013960]: kernel_thread+0x34/0x50
Caller[f01d4194]: rest_init+0x10/0x5c
Caller[f0250034]: _sinittext+0x34/0x48
Caller[f024f790]: _etext+0x77b98/0x78408
Caller[00000000]: 0x0
Instruction DUMP: 01000000  932a6002  c2020000 <d0084009> 81c3e008  
01000000  c2022004  c2004000  82086003

