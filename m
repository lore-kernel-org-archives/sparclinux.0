From: Ralph Mitchell <rmitchell@eds.com>
Date: Fri, 27 Aug 2004 10:30:42 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <412F0D52.8080004@eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Excellent!  That works for me too.

For the record, I found that 2.6.7-rc1 didn't drop every other 
character, while 2.6.7-rc2 and above do.

However, fixing this has exposed something else that I hadn't noticed 
due to it being garbled.  I'm getting this when booting 2.6.7:

    [ snip ]
    Brought up 4 CPUs
    Total of 4 processors activated (3186.68 BogoMIPS).
    SMP: Calibrating ecache flush... Using heuristic of 2295594 cycles, 
5 ticks.
    NET: Registered protocol family 16
    PCI: Probing for controllers.
    PCI: Found PSYCHO, control regs at 000001fe00000000
    PSYCHO: Shared PCI config space at 000001fe01000000
    PCI: Found PSYCHO, control regs at 000001c800000000
    PSYCHO: Shared PCI config space at 000001c801000000
    PCI: Found PSYCHO, control regs at 000001cc00000000
    PSYCHO: Shared PCI config space at 000001cc01000000
    bad: scheduling while atomic!
    Call Trace:
     [0000000000464b14] call_usermodehelper+0xb4/0xe0
     [000000000053e4c0] kset_hotplug+0x1e0/0x280
     [000000000053e71c] kobject_add+0x7c/0x100
     [000000000058ca10] class_device_add+0x50/0x140
     [0000000000562c68] pci_scan_bus_parented+0xe8/0x180
     [0000000000769a08] pbm_scan_bus+0x48/0xe0
     [0000000000769ad4] psycho_scan_bus+0x34/0x60
     [00000000007668e0] pci_scan_each_controller_bus+0x40/0xa0
     [00000000007669fc] pcibios_init+0x1c/0x80
     [00000000007608bc] do_initcalls+0x3c/0xe0
     [0000000000414304] init+0x84/0x240
     [0000000000419530] kernel_thread+0x30/0x60
     [0000000000414190] rest_init+0x10/0x80

The call trace occurs a bunch of times, with an occasional:

    PCI0(PBMB): Bus running at 33MHz

message in between, for various PCIx.  After the last call trace it 
drops through this:

    PCI0(PBMA): Bus running at 66MHz
    ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [su] [su] [ecpp] 
[fdthree] [eeprom] [flashprom] [SUNW,envctrl]

and continues to boot as if everything was peachy keen.

It's entirely possible that I have a stupid combination of kernel config 
options - I've been carrying my .config over from one kernel to the 
next, doing a "make oldconfig" and mostly saying no to any new options.

The above call traces are absent in 2.6.6, occur first in 2.6.7-rc1 and 
also thereafter.  To complete the picture, I'm seeing the same in 
vanilla 2.6.8.

Thanks,

Ralph Mitchell


Joshua Kwan wrote:

>David S. Miller wrote:
>  
>
>>Hmmm, does this fix things?
>>    
>>
>
>Absolutely perfect. You are a god among men.
>
>N.B. the last memcpy patch you sent worked fine as well,
>      as well as the syslog fix. Now we can bootstrap
>      Debian using a 2.6 kernel on sparc64!
>
>Thank you!
>
>  
>
