From: Nasser Shayesteh <Nasser.Shayesteh@Sun.COM>
Date: Sat, 19 Apr 2008 00:32:38 +0000
Subject: Re: PCIe Graphic card for SPARC T1000/2000 Platform
Message-Id: <48093DA6.90803@Sun.COM>
List-Id: <sparclinux.vger.kernel.org>
References: <47ED8CBC.8050900@Sun.COM>
In-Reply-To: <47ED8CBC.8050900@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David,

Thanks for the input. The platform that I am currently testing is 
T5120/5220. It does not have any PCI slots. It has three PCI-Express 
slots. The Radeon(XVR-100) supported by Sun is a PCI card. I have not 
been able to locate a PCI-Express version of the card. Sun supports a 
different version of Radeon family that is based on [FireGL V3100 (PCIE) 
- RV370 5B64]. It is called XVR-300. it works on T5120 platforms running 
solaris. There is a strong interest to get this card working on T5120 
and the future RDK platforms. it also seems that there is a support for 
this card in the linux under (radeon_base.c). I tried this card a couple 
of times using two different versions of Linux kernel (stock Ubuntu and 
custom built based on source_2.6.24). However, the system hangs during 
boot regardless of output-device= screen or virtual-console. I built a 
new kernel without the Radeon driver and was able to boot. No hard hang 
there. Any inputs appreciated.

'

SPARC Enterprise T5120, Keyboard Present
Copyright 2008 Sun Microsystems, Inc. All rights reserved.
OpenBoot 4.27.11, 3968 MB memory available, Serial #76993274.
Ethernet address 0:14:4f:96:d2:fa, Host ID: 8496d2fa.

{0} ok show-displays
a) /pci@0/pci@0/pci@9/SUNW,XVR-300@0
q) NO SELECTION
Enter Selection, q to quit:

{0} ok show-devs
/pci@0/pci@0
/pci@0/pci@0/pci@9
/pci@0/pci@0/pci@8
/pci@0/pci@0/pci@2
/pci@0/pci@0/pci@1
/pci@0/pci@0/pci@9/SUNW,XVR-300@0
/pci@0/pci@0/pci@8/pci@0
/pci@0/pci@0/pci@8/pci@0/pci@a
/pci@0/pci@0/pci@8/pci@0/pci@9
/pci@0/pci@0/pci@8/pci@0/pci@8
/pci@0/pci@0/pci@8/pci@0/pci@2
/pci@0/pci@0/pci@8/pci@0/pci@1


{0} ok boot
Boot device: /pci@0/pci@0/pci@2/scsi@0/disk@0,0:a File and args:
SILO Version 1.4.13
boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.22
Loading initial ramdisk (6064531 bytes at 0x9000000 phys, 0x40C00000 
virt)...
\
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
Debug=Built device tree
Debug=Returning from prom_build_devicetree
Booting Linux...
Debug=Geting out of paging_init routine ...

System hangs here. Never gets to [ 59.563844] rtc_init: no PC rtc found]


Thanks
--Nasser


David Miller wrote:
> From: Nasser Shayesteh <Nasser.Shayesteh@Sun.COM>
> Date: Fri, 28 Mar 2008 17:26:36 -0700
>
>   
>> I have a SPARC T2000 system installed with Ubuntu 7.10  Server Edition 
>> running "2.6.22-14-sparc64-smp"  kernel.
>>
>> I am interested to know whether anyone knows of  any low power PCIe 
>> graphics card and corresponding driver that works on T1000T2000 SPARC 
>> based platforms.
>>
>> I also tried  Nvidia (NVS440)  graphic card without the FCODE to see if 
>> I can start X using the nvidiafb.ko driver that comes with stock Ubuntu 
>> kernel distribution for servers. The device was recognized OK. However, 
>> there is a fatal mmap() failure.
>>     
>
> NVIDIA isn't going to work, Radeon (XVR-100) cards should
> work if you configure X to use the "fb" acceleration-less
> driver.
>
> The state of X is very poor under Linux at the moment,
> although it should improve substantially in future
> releases.
>   

