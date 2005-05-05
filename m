From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Thu, 05 May 2005 18:04:41 +0000
Subject: Re: ss20/ross/smp
Message-Id: <200505051804.j45I4fS5021466@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

[del]
>Debian woody will use a very different (older) tool chain stack then gento=
o.
>(gcc/libs).  Guessing this is likely diff letting me run SMP on roughly
>equiv. box.

It should not, but it may be. The versions of the tool chain I'm using shou=
ld
be alright for any 2.4.x kernel, SMP or not. For 2.6.x, they would be too o=
ld.

[del]
>I'm compiling with gcc 3.3.5   Yours is 2.95.4
>My understanding is this is very important re kernel compiles.
>Somebody else may want to chime in and note why the gcc
>version is (or isn't) important re SMP versus UP.

Well, I would be surprised if you could compile any 2.2.x kernel with such
bleeding edge gcc.

>>I will give 2.2 a spin to gather more info. I bought the system from ebay,
>>so there may be a hardware glitch I don't know about, but when it's runni=
ng
>>2.2.x SMP, I think we can rule that out.
>> =20
>>
>You may want to swap out CPUs, i.e. run with just one, then
>just the other, and double check that they're both good.
>This is a possibility.

It runs well with 2.2.26, stock kernel.org:

maril:~> uname -a
Linux maril 2.2.26 #1 SMP Thu May 5 16:35:15 CEST 2005 sparc unknown
maril:~> cat /proc/cpuinfo=20
cpu             : ROSS HyperSparc RT625 or RT626
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 150.32
Cpu1Bogo        : 149.91
MMU type        : ROSS HyperSparc
invall          : 0
invmm           : 0
invrnge         : 0
invpg           : 0
contexts        : 4096
CPU0            : online
CPU1            : online
maril:~> uptime
 20:01:33 up  1:16,  2 users,  load average: 1.04, 1.71, 1.92

Currently doing the third kernel compile in a row to provide some load.
The only thing which looks fishy are the different BogoMips values for
my CPUs. Is this normal?

TIA,
Uli
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9ration=
 S)
