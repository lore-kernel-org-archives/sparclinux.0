From: Felipe Alfredo Hernandez Gonzalez
Date: Fri, 21 Sep 2007 18:57:22 +0000
Subject: Information for installing
Message-Id: <1190401042.24056.13.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

I don't know if this is the place where i can found a little more
information and help in getting a Sun box working with linux.
Where is my request, I'm trying to install linux in a Ultra45 box i been
trying to install Ubuntu Linux for sparc with no success at all, here is
what i've done:
-Cold boot (giving a stop-a interrupt at the begining) installing Ubuntu
6.04 dapper drake (kernel 2.6.15):
              * It runs fine but right after it start loading the kernel
                it sends the next message:
                Neither SBUS nor PCI found.
                Program terminated
      * Cold boot (giving a stop-a interrupt at the begining) installing
        Ubuntu 7.04 Feisty fawn (kernel 2.6.20):
        It starts the installation process and it just hangs in the part
        of booting linux.
      * Normal boot, init 0, prompt ok, installing Ubuntu 7.04 Feisty
        Fawn: 
        Allocated 8 megs of memory
        Loaded kernel version 2.6.20
        Loading initial ramdisk
        ERROR: Last trap: Illegal Instruction

Here are the stats of the box:
System Configuration: Sun Microsystems sun4u Sun Ultra 45 Workstation
System clock frequency: 200 MHZ
Memory size: 1GB 

===== CPUs =======
E$ CPU CPU
CPU Freq Size Implementation Mask Status Location
--- -------- ---------- --------------------- ----- ------ --------
0 1600 MHz 1MB SUNW,UltraSPARC-IIIi 3.4 on-line MB/0

===== IO Devices=====Bus Freq Slot + Name +
Type MHz Status Path Model
------ ---- ---------- ---------------------------- --------------------
pci 200 MB pci10b9,5455 (sound) 
okay /pci@1e,600000/pci@0/pci@1/pci@0/sound

pci 200 MB pci10b9,5229 (ide) 
okay /pci@1e,600000/pci@0/pci@1/pci@0/ide

pci 200 MB pci14e4,1678 (network) 
okay /pci@1e,600000/pci@0/pci@2/pci@0/network@4

pci 200 MB pci14e4,1678 (network) 
okay /pci@1e,600000/pci@0/pci@2/pci@0/network

pci 200 MB scsi-pci1000,50 (scsi-2) LSI,1064 
okay /pci@1e,600000/pci@0/pci@9/pci@0/scsi@1

pciex 200 MB/PCIE2 SUNW,XVR-300 (display) SUNW,375-3458 
okay /pci@1f,700000/SUNW,XVR-300@0


===== Memory Configuration ====Segment Table:
-----------------------------------------------------------------------
Base Address Size Interleave Factor Contains
-----------------------------------------------------------------------
0x200000000 1GB 1 BankIDs 0

Bank Table:
-----------------------------------------------------------
Physical Location
ID ControllerID GroupID Size Interleave Way
-----------------------------------------------------------
0 0 1 1GB 0

Memory Module Groups:
--------------------------------------------------
ControllerID GroupID Labels Status
--------------------------------------------------
0 1 MB/DIMM2 
0 1 MB/DIMM0 

===== usb Devices ====
Name Port#
------------ -----
mouse 1
hub 2

===== hub#2 Devices ====
Name Port#
------------ -----
keyboard 4

===== usb Devices ====
Name Port#
------------ -----
hub 7

===== Environmental Status ====Fan Status:
-------------------------------------------
Location Sensor Status
-------------------------------------------
F0 cpu0-fan okay
F2 pci-fan okay
F3 system-fan3 okay
F4 system-fan4 okay

Temperature sensors:
-----------------------------------------
Location Sensor Status
-----------------------------------------
MB/0 cpu0-sensor okay 
MB mb-sensor okay 
MB adt7462-sensor okay 
MB lm95221-sensor okay 
MB fire-sensor okay 
MB lsi1064-sensor okay 
FIOB front_panel-sensor okay 
MB psu-sensor okay 

===== HW Revisions ====ASIC Revisions:
-------------------------------------------------------------------
Path Device Status Revision
-------------------------------------------------------------------
/pci@1e,600000 pciex108e,80f0 okay 3 
/pci@1f,700000 pciex108e,80f0 okay 3 

System PROM revisions:
----------------------
OBP 4.22.19 2006/09/06 23:42 Sun Ultra 45 Workstation
POST 4.22.19 2006/09/07 00:06


I dont know where to search for more info, i have googled, searched
througt forums without luck.

So point me on the right direction where or how to accomplish this task.

Thanks in advance for everything.

And sorry for my english it's been a while since I had done this.

-- 
Felipe A. Hernández González
Ingeniero G Sistemas
BBVA Bancomer
Servidores Centrales
Tel. 5621-3434
Ext. 94128
