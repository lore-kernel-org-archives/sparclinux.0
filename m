From: jbelshaw@tiscali.nl
Date: Fri, 09 Jan 2004 12:30:10 +0000
Subject: Re  Bootproblem with CD
Message-Id: <3FFB0CC300004D5E@ocpmta6.freegates.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1F6206BC53BCD3119059009027D1D3A20CC6AF42@OEKAEX01.becker.de>
In-Reply-To: <1F6206BC53BCD3119059009027D1D3A20CC6AF42@OEKAEX01.becker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hello Dieter

I don't know what is causing your error but I can say that you should be
able to get the linux to boot directly from the HD without going via a cd.

There are two ways : 
1. compile the driver for aha29160 you need into the kernel so that it doesn't
need an initrd and on boot the kernel will see the disk and find your root
filesystem.  It's not that hard to build a kernel for yourself. 

2. If you are using a kernel from somewhere else and have to use the 
aha29160 driver as a module then you will need to make an initrd which 
loads that driver before mounting the root file system.

I suggest you look at RedHat or other internet documentation for problems
building an initrd.

Then you should not have to bother with a cd at all !

Good Luck
John
>Dear Listmembers,
currently I do a lot of testing with the new 2.4.23 kernel. About a year
ago
I posted into this list that I get an error message when booting saying:
****
Inspecting /boot/System.map
Loaded 13363 symbols from /boot/System.map
Sy
>bols match kernel version 2.4.2X
Error reading kernel symbols - Cannot allocate memory
****
this error is still persistent and is due to the fact that I boot using an
initrd from a CD (what I have to do because the HDD is connected to a
aha29160 c
>ntroler who is not detected prior to loading the appropriate
module from somewhere) The error happens when the mapfile is accessed the
*second* time and data are taken from the HDD, not from the CDROM any more
(since there are only a few modules tha
> have to be loaded at the very
begin)

If anybody of you guru's would find the time to test this on your own - I
cannot figure out what is going wrong. If I boot *this* kernel using *this*
System.map and *this* initrd from an harddisk attached to 
>he symbios logic
controler, everything is fine. No error, no allocation issue.

I did a:

mkisofs -silo-boot /boot/second.b -s /boot/silo.conf -o /home/image.iso -R
/var/adm/bootCD

and burned the result using xcdroast.

Using this initrd fro
> the harddisk directly does not end up in such errors.

Therefore there must be something wrong with the initrd (??) or whatsoever.
I have no clue, maybe you do.
Many thanks for your efforts in advance,
take care


Dieter Jurzitza


-- 
___
>____________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
         ESI

Industriegebiet Ittersbach
Becker-G?ring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 
>1-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
 


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Wenn Sie nicht d
>r richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren
Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte
Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may co
>tain confidential and/or privileged information. If you are not the intended
recipient (or have received this e-mail in error) please notify the sender
immediately and delete this e-mail. Any unauthorised copying, disclosure
or distribution of the cont
>nts in this e-mail is strictly forbidden.
*******************************************

-
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vg
>r.kernel.org/majordomo-info.html


