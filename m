From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 06 Jan 2012 21:18:16 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <1159921325884697@web75.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

05.01.2012, 23:27, "David Miller" <davem@davemloft.net>:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Thu, 05 Jan 2012 05:42:18 +0400
>
>> =9AI had this problem with OpenBIOS. Timers don't tick and kernel fails =
on
>> =9AQEMU, when it's compiled with SMP support. The path fixes problem.
>
> This means that OpenBIOS does not provide the hardware to the client
> program in the same state that OpenFirmware does, which in my opinion
> is a bug.
>
> We can still apply a patch like this, but I'd like to see it tested
> on real hardware and OpenFirmware machines.

I've just tested it on:

cpu        : Texas Instruments, Inc. - MicroSparc
fpu        : SuperSparc on-chip FPU
promlib        : Version 3 Revision 2
prom        : 2.12
type        : sun4m
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo    : 498.07
Cpu1Bogo    : 498.07
Cpu2Bogo    : 498.07
Cpu3Bogo    : 498.07
MMU type    : TI Viking/MXCC
contexts    : 65536
nocache total    : 5242880
nocache used    : 1296384
State:
CPU0        : online
CPU1        : online
CPU2        : online
CPU3        : online

It seems that everything is ok.

Kirill
