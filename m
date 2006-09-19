From: Daniel Smolik <marvin@mydatex.cz>
Date: Tue, 19 Sep 2006 19:27:55 +0000
Subject: Re: openpromfs 2.6.18-rc6
Message-Id: <451044BB.3080001@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <44FF3044.2020509@mydatex.cz>
In-Reply-To: <44FF3044.2020509@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Smolik napsal(a):
> Daniel Smolik napsal(a):
> 
>> David Miller napsal(a):
>>
>>> From: Daniel Smolik <marvin@mydatex.cz>
>>> Date: Wed, 06 Sep 2006 22:32:04 +0200
>>>
>>>
>>>> I want change my input-device from keyboard to rsc and I get invalid 
>>>> argument.
>>>>
>>>> echo 'rsc' > /proc/openprom/options/input-device. eeprom ends with 
>>>> SIGBUS.
>>>> Under 2.6.17.2 openpromfs works well.
>>>
>>>
>>>
>>>
>>> Intentional added limiation to openpromfs, it is very difficult
>>> to add property writing support in the new OBP device tree code
>>> in the kernel.
>>>
>>> It works just fine when using /dev/openprom, so please convert
>>> whatever you're trying to accomplish to use that for property
>>> modification for now.
>>>
>>> I have no plans to add back property writing support to openpromfs
>>> for 2.6.18, I simply lack the time to do it.  However I'll probably
>>> be able to do it for 2.6.19.
>>>
>> Ok,
>> and exists some tool which I use to do this ?
>>
> eeprom which is in Debian Sid ends with SIGBUS :-(
> 
> mprotect(0xf7f2a000, 24576, PROT_READ)  = 0
> munmap(0xf7f38000, 69225)               = 0
> open("/dev/openprom", O_RDWR)           = 3
> ioctl(3, 0x20004f05, 0x243e0)           = 0
> uname({sys="Linux", node="sunik", ...}) = 0
> --- SIGBUS (Bus error) @ 0 (0) ---
> +++ killed by SIGBUS +++
> Process 1437 detached

Better explanation of problem:


NU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "sparc-linux-gnu"...Using host libthread_db library 
"/lib/libthread_db.so.1".

(gdb) run
Starting program: /home/marvin/sparc-utils-1.9.orig/prtconf-1.3/eeprom

Program received signal SIGBUS, Bus error.
0x00012160 in main (argc=0, argv=<value optimized out>) at eeprom.c:661
661             *(int *)op->oprom_array = 0;
(gdb) bt
#0  0x00012160 in main (argc=0, argv=<value optimized out>) at eeprom.c:661
(gdb)


Dan










