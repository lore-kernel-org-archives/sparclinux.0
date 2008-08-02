From: Pavel Rimsky <rimskyp@seznam.cz>
Date: Sat, 02 Aug 2008 09:05:03 +0000
Subject: Bootable CD for UltraSparc III using SILO - illegal instruction
Message-Id: <4894233F.7080600@seznam.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I am a newbie in the kernel; I am interested in writing kernel code for 
the UltraSparc processors. In particular, I am interested in the 
UltraSparc III chips. However, I encounter a grave problem which I 
cannot overcome.

I tried to make a bootable CD like this:

1) I wrote a dummy "kernel" - a piece of code to be run in the kernel 
mode which does dot do anything useful.

2) I compiled it using sparc64 gcc cross-compiler like this:

sparc64-linux-gnu-gcc -nostdinc -nostdlib -fno-builtin -O3 
-mcpu=ultrasparc -m64 -D__ASM__ -c -o boot.o boot.S

3) I made a kernel image like this:

sparc64-linux-gnu-ld -no-check-sections -N -T link.ld -o image.boot boot.o

This is the code of the linker script link.ld:

SECTIONS {
        .boot 0x4000: {
                *(BOOTSTRAP);
                *(.text);
                *(.rodata);
                *(.rodata.*);
                *(.data);               /* initialized data */
                *(.sdata);
                *(.sdata2);
                *(.sbss);
                *(.bss);                /* uninitialized static variables */
                *(COMMON);
         }

        /DISCARD/ : {
                *(.comment);
                *(.note*);
        }

}

BOOTSTRAP is the name of the section to which I have placed the "dummy 
kernel" code.

4) I made the following directory structure:

boot (contains SILO files)
    fd.b
    first.b
    generic.b
    ieee32.b
    isofs.b
    second.b
    silo.conf
    silotftp.b
    ultra.b
myos
    image.boot (my "dummy kernel" image)

The silo.conf file contains:

timeout = 3
image = /myos/image.boot
    label = myos

5) I made a bootable CD using mkisofs:

mkisofs -G cd/boot/isofs.b -B ... -r -o image.iso cd

Then I tried to boot the CD on Sun Fire 6800 machine, but I got:

SmartFirmware, Copyright (C) 1996-2001. All rights reserved.
Boot path: /ssm@0,0/pci@19,700000/scsi@2/disk@6,0:f Boot args:
ERROR: Illegal instruction
debugger entered.
ok

Exactly the same error appeared when I tried to boot Aurora Linux CD, so 
it is probably a more general issue.

It is worth mentioning that the machine I was trying to run it on was 
not a real one, I used the Simics simulator. But IMHO the problem is not 
in the machine, as I successfully booted Solaris, OpenSolaris and NetBSD 
on it. On the UltraSparc II machine my "kernel" runs without any problems.

I am suspicious that the illegal instruction has been performed by SILO, 
as SILO did not even print its banner. By the way, does anyone of you 
know what happened to the SILO website (www.sparc-boot.org)? It has been 
out of order for several months, so I cannot find more information to 
solve my problem.

Could you be so kind and explain to me why the error occurs and, if 
possible, provide me with some piece of "dummy code" I could compile and 
then run on the UltraSparc III machine (in kernel mode)? Thanks in advance.

Pavel R.

