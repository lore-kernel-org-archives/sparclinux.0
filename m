From: Ralph Mitchell <rmitchell@eds.com>
Date: Sat, 24 Jul 2004 11:11:38 +0000
Subject: Re: Weird serial problems in 2.6.7
Message-Id: <410243EA.70906@eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040721064705.GE23921@triplehelix.org>
In-Reply-To: <20040721064705.GE23921@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

For further information/confirmation, I have an E450 with serial=20
console, and there was no problem 2.6.7-rc1.  However, I just booted=20
2.6.7 and I'm getting the wierd character problem.  At first glance it=20
looked like it might be parity, but then I'd think it would be more=20
likely to drop (apparently) random characters, rather than every other=20
one...

Anyway, it started OK, then went weird, then recovered:

    Sun Enterprise 450 (4 X UltraSPARC-II 400MHz), No Keyboard
    OpenBoot 3.16, 4096 MB memory installed, Serial #12871523.
    POLB u EEBo rm31. 000/11:2
    [snip lots of garbage...]
    koradsatn.=20
o.....=B1.....)..2=E9j.=D1..=B1....J=A1=BD.=C9.                            =
       g

    Gentoo Linux; http://www.gentoo.org/
     Copyright 2001-2004 Gentoo Technologies, Inc.; Distributed under=20
the GPL

     * Mounting proc at /proc...  [ ok ]
     * Mounting sysfs at /sys...  [ ok ]

Seems like all the output that matches the 'dmesg' output was weird,=20
then it was ok when processing the startup scripts.  Once the boot is=20
complete I can login just fine  I have:

    CONFIG_SERIAL_SUNSAB=3Dy
    CONFIG_SERIAL_SUNSAB_CONSOLE=3Dy

in my .config.

Just wondering - could the kernel just be trying to push characters out=20
too fast for the chip to handle?

Ralph Mitchell


Marc Zyngier wrote:

>>>>>>"Meelis" =3D Meelis Roos <mroos@linux.ee> writes:
>>>>>>           =20
>>>>>>
>
>Meelis> I tried 2.4.27-rc3 on the same Ultra5 and same cable and same
>Meelis> PC, serial console works fine. So it's serial console in 2.6
>Meelis> on U5 it seems.
>
>For information, my Netra AX1105 runs fine with 2.6.7 and 2.6.8-rc2
>using serial console. Uses sunsu, though.
>
>Looks like it is sunsab-related...
>
>	M.
> =20
>
