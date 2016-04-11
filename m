From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 11 Apr 2016 16:41:09 +0000
Subject: Re: Kernel panic under qemu-system-sparc64 when adding kb_ps2/kdmouse DT nodes
Message-Id: <570BD3A5.8090409@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <570BA28F.3020407@ilande.co.uk>
In-Reply-To: <570BA28F.3020407@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/04/16 17:08, David Miller wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Date: Mon, 11 Apr 2016 14:11:43 +0100
> 
>> 0 > cd kb_ps2  ok
>> 0 > .properties
>> name                      "kb_ps2"
>> device_type               "serial"
>> reg                       00000000
>> keyboard                  ffffffff
>> address                   60
>>  ok
>> 0 > cd ..  ok
>> 0 > cd kdmouse  ok
>> 0 > .properties
>> name                      "kdmouse"
>> device_type               "mouse"
>> reg                       00000001
>> mouse                     ffffffff
>> address                   60
>>  ok
> 
> The kbd and mouse nodes must have interrupts properties too.

Hi David,

I've just tried this and it makes no difference in my tests here. I'm
not convinced that it's related to interrupts since from the real device
tree in the link from the previous email you can see that both
interrupts are held in the parent 8042 property, i.e.


System Configuration:  Sun Microsystems  sun4u
Memory size: 128 Megabytes
System Peripherals (PROM Nodes):

Node 0xf002a504
    reset-reason:  'POR'
    idprom:
01800080.b600d782.ffffffff.0901779d.ffffffff.ffffffff.00000000.00000000
    compatible: 'sun4u'
    breakpoint-trap:  0000007f
    #size-cells:  00000002
    energystar-v2:
    model:  'THEMIS,xxx-xxxx'
    name:  'SUNW,UltraSPARC-IIi-cEngine'
    clock-frequency:  055d455f
    banner-name:  'SPARCengine(tm)Ultra(tm) THEMIS-USPIIi-1v
(UltraSPARC-IIi 270MHz)'
    device_type:  'upa'
...
...
...
                Node 0xf0071e58
                    interrupts:  00000001.00000002
                    #size-cells:  00000000
                    #address-cells:  00000001
                    reg:
00000014.00300060.00000008.00000014.00300060.00000008
                    device_type:  '8042'
                    name:  '8042'
                    model:  'INTC,80c42'

                    Node 0xf0072ab4
                        reg:  00000000
                        language:  'en'
                        compatible: 'pnpPNP,303'
                        port-b-ignore-cd:
                        port-a-ignore-cd:
                        keyboard:
                        device_type:  'serial'
                        name:  'kb_ps2'

                    Node 0xf00757b0
                        reg:  00000001
                        compatible: 'pnpPNP,f03'
                        port-b-ignore-cd:
                        port-a-ignore-cd:
                        mouse:
                        device_type:  'serial'
                        name:  'kdmouse'


I've also tried various other OS flavours and all of OpenBSD, NetBSD and
FreeBSD detect both 8042 devices fine, it's just Linux that panics.

Another point of interest is that if I just add either one of the two
devices on their own then the panic goes away, so it's only when both
are present together that I see the issue.


ATB,

Mark.

