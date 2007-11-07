From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: Wed, 07 Nov 2007 08:55:36 +0000
Subject: Re: Strange CPU occupation...
Message-Id: <87wssujuyf.fsf@informatik.uni-tuebingen.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4728773C.7010802@systella.fr>
In-Reply-To: <4728773C.7010802@systella.fr> (BERTRAND Joel's message of "Wed,
	31 Oct 2007 13:38:20 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: BERTRAND Joel <joel.bertrand@systella.fr>
Cc: sparclinux@vger.kernel.org, linux-raid@vger.kernel.org, iscsitarget-devel@lists.sourceforge.net

BERTRAND Jo=EBl <joel.bertrand@systella.fr> writes:

>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>
>  5426 root      15  -5     0    0    0 R  100  0.0  46:32.54
> md_d0_raid5

First: You can tune the stripe cache.

Secondly: You might want the raid speedup patches that implement
prioritized queueing. That reduces the number of incomplete stripes
written to disk and thus speeds up things a lot.

Thirdly: If you have multiple cores then you probably want patches to
multithread the raid5 code. With just one thread it is ultimately cpu
bound and just won't get faster. XORing and maintainance overhead
seems to be awfully cpu intensive.

Fourth: Learn to live with it. Software Raid5/6 is expensive.

> and some process are in D state :
> Root gershwin:[/etc] > ps auwx | grep D
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       270  0.0  0.0      0     0 ?        D    Oct27   1:17 [pdflush]
> root      3676  0.9  0.0      0     0 ?        D    Oct27  56:03 [nfsd]
> root      5435  0.0  0.0      0     0 ?        D<   Oct27   3:16 [md7_rai=
d1]
> root      5438  0.0  0.0      0     0 ?        D<   Oct27   1:01 [kjourna=
ld]
> root      5440  0.0  0.0      0     0 ?        D<   Oct27   0:33 [loop0]
> root      5441  0.0  0.0      0     0 ?        D<   Oct27   0:05 [kjourna=
ld]
> root     16442  0.0  0.0  20032  1208 pts/2    D+   13:23   0:00 iftop
> -i eth2
>
> 	Why md7_raid is in D state ? Same question about iftop ?

I would say it is just waiting for the underlying devices to finish
some I/O request. And iftop will be in some kernel call waiting for
something or other.

MfG
        Goswin
