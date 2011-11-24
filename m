From: Meelis Roos <mroos@linux.ee>
Date: Thu, 24 Nov 2011 15:05:49 +0000
Subject: Re: [PATCH] i2c-ali1535: enable SPARC support
Message-Id: <alpine.DEB.2.00.1111241659050.11819@ondatra.cyber.ee>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810230-1445909040-1322147149=:11819"
List-Id: <sparclinux.vger.kernel.org>
References: <4ECE2410.7040608@geomatys.fr>
In-Reply-To: <4ECE2410.7040608@geomatys.fr>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810230-1445909040-1322147149=:11819
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

> The i2c-ali1535 driver don't work on SPARC, this is because it assumes th=
at ioport address are 16bits wide (address stored with an unsigned short).
> But on SPARC arch, ioports are mapped in memory and so are stored with an=
 unsigned long.
>
> This patch corrects this by using pci_resource_start for getting IOMEM ba=
se address, then reading the SMBBA of the i2c busse and using together for =
I/O access.

I tested it on my Sun Blade 100 on top of 3.2-rc3.

It seems to work:

# ls /sys/bus/i2c/devices/i2c-0/
0-0018/        0-0051/        0-0053/        device/        new_device     =
uevent
0-0050/        0-0052/        delete_device  name           subsystem/

# sensors
adm1023-i2c-0-18
Adapter: SMBus ALI1535 adapter at 0600
temp1:        +35.0=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)
temp2:        +75.8=B0C  (low  =3D -55.0=B0C, high =3D +127.0=B0C)

and decode-dimms from i2c-tools package displays the SPD eeproms of 0-005*=
=20
also fine.

One thing that I noticed was these errors in the dmesg - I think they were=
=20
there even before the patch:

[   64.677130] loop: module loaded
[   64.763143] i2c i2c-0: Error: command never completed
[   64.898968] i2c i2c-0: Error: command never completed
[   64.995848] i2c i2c-0: Error: command never completed
[   65.066294] i2c i2c-0: Error: command never completed
[   65.136705] i2c i2c-0: Error: command never completed
[   65.206817] i2c i2c-0: Error: command never completed
[   65.276818] i2c i2c-0: Error: command never completed
[   65.346817] i2c i2c-0: Error: command never completed
[   65.461240] i2c i2c-0: Error: command never completed
[   65.562828] i2c i2c-0: Error: command never completed
[   65.633312] i2c i2c-0: Error: command never completed
[   65.703706] i2c i2c-0: Error: command never completed

These only ahppened at bootup, no actual use later seems to trigger it.

# cat /sys/bus/i2c/devices/i2c-0/name
SMBus ALI1535 adapter at 0600

# cat /sys/bus/i2c/devices/i2c-1/name
bt878 #0 [sw]

So this is the ALI i2c adapter that emits the errors on startup - some=20
module load perhaps. loop reference is there because this is the contents=
=20
of my /etc/modules:

loop
adm1021
eeprom

and lsmod shows these mopdules wer loaded together:

# lsmod|head
Module                  Size  Used by
ipv6                  298281  18
eeprom                  2743  0
adm1021                 5987  0
hwmon                   1501  1 adm1021
loop                   15747  0

So it seems adm1021 module loading causes these messages?

--=20
Meelis Roos (mroos@linux.ee)
---1463810230-1445909040-1322147149=:11819--
