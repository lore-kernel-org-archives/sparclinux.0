From: Alexey Nezhdanov <snake@penza-gsm.ru>
Date: Fri, 09 Apr 2004 04:10:36 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <200404090810.36124.snake@penza-gsm.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On Thu, 8 Apr 2004 07:56:54 -0400 (EDT)
>
> Vincent Cojot <coyote@step.polymtl.ca> wrote:
> > On Thu, 8 Apr 2004, Alexey Nezhdanov wrote:
> > > Unfortunately it seems that I've already tryed it with the same result.
> > > Can you please send me md5 of your file?
> > > Mine is
> > > b85b3eb7ba3176745b60fa1f47b03bc3  aurora.img
> >
> > raistlin@thorbardin:[~][1008]$ md5sum  /tftpboot/tftp64.img
> > b85b3eb7ba3176745b60fa1f47b03bc3  /tftpboot/tftp64.img
> >
> > It's the same image.. (Sorry, I had missed that part in your message...)
>
> I think it's the graphics card, you probably are using one we
> don't have any drivers for yet.  What's in the machine?
My configuration:
root@STAT # /usr/platform/sun4u/sbin/prtdiag -v
System Configuration: Sun Microsystems  sun4u SUNW,Sun-Blade-1000 
(UltraSPARC-I 
System clock frequency: 150 MHZ
Memory size: 1GB        

================== CPUs ==================
               E$          CPU     CPU       Temperature
CPU  Freq      Size        Impl.   Mask     Die    Ambient
---  --------  ----------  ------  ----  --------  --------
 0    900 MHz  8MB         US-III+   2.3     69 C     25 C

================= IO Devices ================     Bus   Freq
Brd  Type  MHz   Slot        Name                          Model
---  ----  ----  ----------  ----------------------------  
--------------------
 0   pci    33            1  SUNW,m64B (display)           SUNW,370-4362      
 0   pci    33            2  SUNW,Expert3D-Lite (display)  SUNW,375-0116      
 0   pci    66            4  SUNW,qlc-pci1077,2200.5 (scs+                    
 0   pci    33            5  ebus/parallel-ns87317-ecpp (+                    
 0   pci    33            5  ebus/serial-sab82532 (serial+                    
 0   pci    33            5  network-pci108e,1101.1 (netw+ SUNW,pci-eri       
 0   pci    33            5  firewire-pci108e,1102.1001 (+                    
 0   pci    33            6  scsi-pci1000,f.37 (scsi-2)                       
 0   pci    33            6  scsi-pci1000,f.37 (scsi-2)                       

============== Memory Configuration ==============
Segment Table:
-----------------------------------------------------------------------
Base Address       Size       Interleave Factor  Contains
-----------------------------------------------------------------------
0x0                1GB               2           BankIDs 0,2

Bank Table:
-----------------------------------------------------------
           Physical Location
ID       ControllerID  GroupID   Size       Interleave Way
-----------------------------------------------------------
0        0             0         512MB           0
2        0             0         512MB           1

Memory Module Groups:
--------------------------------------------------
ControllerID   GroupID  Labels
--------------------------------------------------
0              0        J0100,J0202,J0304,J0406

================ usb Devices ===============
Name          Port#
------------  -----
keyboard        3
mouse           4

============== Environmental Status ==============
Fan Speeds:
----------------------------
Fan Device            Speed
----------------------------
system                  19%
cpu                     22%
power-supply           100%

================ HW Revisions ================
ASIC Revisions:
---------------
pci: Rev 5
pci: Rev 5
ebus: Rev 1

System PROM revisions:
----------------------
OBP 4.13.0 2004/01/19 18:27
POST 4.13.0 2004/03/15 19:13



-- 
Respectfully
Alexey Nezhdanov



