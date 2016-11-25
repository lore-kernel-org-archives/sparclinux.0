From: Louis Liu <pttdog@gmail.com>
Date: Fri, 25 Nov 2016 20:30:27 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <CAHVHM28qQCsWnSrt_hF+O2xaKrey5ZQAJ7cDSo9aY-avfL8FyA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I failed to make silo works on E4800 with these results:

1. Relocation of first-isofs/crt0.S doesn't work.
    Copy overwrites it's own running instructions.

2. I modified the relocation codes and applied 0x30800007 instruction.
    Silo output 'S' with tftp boot. Maybe we can fix tilo with similar
modification.

3. Boot cdrom with modified silo, I got a stack underflow exception.

4. Relocate boot loader manually......

{10} ok load /ssm@0,0/pci@18,700000/pci@2/scsi@2/disk@6,0

{10} ok 4020 4000 3000 move
{10} ok init-program
{10} ok go
SILO Version 1.4.14
\


                  Welcome to Debian GNU/Linux sid!

This is a Debian installation CDROM, built on 20161122-00:26.
Keep it once you have installed your system, as you can boot from it
to repair the system on your hard disk if that ever becomes necessary.

WARNING: You should completely back up all of your hard disks before
  proceeding. The installation procedure can completely and irreversibly
  erase them! If you haven't made backups yet, remove the rescue CD from
  the drive and press L1-A to get back to the OpenBoot prompt.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent permitted
by applicable law.

[ ENTER - Boot install ]   [ Type "expert" - Boot into expert mode ]
                           [ Type "rescue" - Boot into rescue mode ]
boot:
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 4.8.7
Could not map memory

Fatal error: You do not have enough continuous available memory for
such initial ramdisk.
NOTICE: f_client_exit: Program terminated!
debugger entered.



2016-11-25 16:14 GMT+08:00 Louis Liu <pttdog@gmail.com>:
> I checked some documents and other boot loaders to investigate the problem.
> I'm a rookie to system software, if any of my inspection is wrong,
> please let me know.
>
> The header looks fine.
> I guess Serengeti doesn't understand the 32bits a.out header, and
> execute program from header.
> The a.out magic is a harmless instruction.
> The next instruction, a_text field, is an illtrap.
>
> Elftoaout generates headless file with "-b" option.
> The option is used for sun4 architecture, it may be useful on Serengeti.
> But other platforms don't like headless files.
>
> Some boot loader set 0x30800007 to a_text. I see this number In
> aout_load.c of QEMU and boot of NetBSD.
> This magic numbers is a "Branch Always" instruction, which jumps to
> the real entry point.
> Because the text is not placed at different address, the boot loader
> has to arrange it.
> In Silo, first-iso/crt0.S may be fine, it moves itself up on start.
>
> I'll prove it in my sparse time.
>
> Any suggestion?
>
> 2016-11-25 6:04 GMT+08:00 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> On 24/11/16 21:26, vincent@cojot.name wrote:
>>
>>> A while back I stumbled onto an old post talking about the 'Illegal
>>> instruction' issue with SILO on serengeti machines:
>>>
>>> http://helenos-blog.pavel-rimsky.cz/?p=3
>>>
>>> Any thoughts?
>>>
>>> Note that I have not personally verified that it works or not (I sold my
>>> US-IIICu sb2k some time ago already...)
>>>
>>> My 2c,
>>>
>>> Vincent
>>
>> FWIW we have a similar hack in OpenBIOS for a.out binaries which rears
>> its head when trying to boot NextSTEP in QEMU:
>> https://github.com/openbios/openbios/blob/master/libopenbios/aout_load.c.
>> For a.out binaries we relocate the binary back down over its header
>> after load so we can execute directly at 0x4000 (load-base).
>>
>> This was modelled after observing similar code in the official Sun
>> OpenBOOT implementation of init-program which can be found here:
>> https://github.com/openbios/openboot/blob/master/obp/arch/sun4u/go.fth.
>>
>> Probably the first thing to check is that the a.out magic is being
>> generated correctly in SILO to match the above code in order to trigger
>> the relocation, which in itself is likely a hold-over from the very
>> early days of OpenBOOT.
>>
>>
>> ATB,
>>
>> Mark.
>>
