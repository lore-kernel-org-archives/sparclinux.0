From: "Ulrich Teichert" <Ulrich.Teichert@gmx.de>
Date: Thu, 02 Aug 2007 22:03:27 +0000
Subject: Ultra 2 with nvram problems
Message-Id: <20070802220327.20940@gmx.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

my ultra-2 with two 300 MHZ CPUs has recently developed this (serial log):
...
ttya initialized
SC Control: EWP:0 IAP:0 FATAL:0 WAKEUP:0 BXIR:0 BPOR:0 SXIR:0 SPOR:1 POR:0 =

Incorrect configuration checksum;=20
Setting NVRAM parameters to default values.
Setting diag-switch? NVRAM parameter to true
....
Sun Ultra 2 UPA/SBus (2 X UltraSPARC-II 296MHz), No Keyboard
OpenBoot 3.25, 384 MB memory installed, Serial #16777215.
Ethernet address ff:ff:ff:ff:ff:ff, Host ID: ffffffff.
...
{0} ok boot disk
Boot device: /sbus/SUNW,fas@e,8800000/sd@0,0  File and args:=20
SILO Version 1.4.13
boot:=20
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.18
Loading initial ramdisk (4682540 bytes at 0x60800000 phys, 0x40C00000 virt)=
...

IDPROM: Warning, unknown format type!
Remapping the kernel... done.
Booting Linux...
PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.0 1999/12/03 11:35'
PROMLIB: Root node compatible:=20
Linux version 2.6.18-4-sparc64-smp (Debian 2.6.18.dfsg.1-12) (waldi@debian.=
org)
 (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Mon Mar=
 26=20
13:14:08 UTC 2007
ARCH: SUN4U
Ethernet address: ff:ff:ff:ff:ff:ff
...


Etc. Every time I boot up, date is at:

ceteol:~# date
Thu Nov 30 01:06:09 CET 1967

Has anybody seen symptoms like this before? I assume the nvram battery is
empty and replacing it should cure all this, but before I search all ebay
for these precious jewels, I'd like to know if a replacement will get me
anywhere.

Thanks for all responses,
Uli

--=20
Ulrich Teichert
Stormweg 24
24539 Neum=FCnster, Germany


GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
