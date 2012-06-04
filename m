From: Marcel van Nies <morcles@gmail.com>
Date: Mon, 04 Jun 2012 21:22:16 +0000
Subject: Re: sparc32: some more testing
Message-Id: <CACEWtaCXrxD84ePM9WqL2xTXqK=nTtdeh0xrxz9OP9HqDvJfiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

> Try to drop the tsunami special blockops to see
> if that has any effect.
>
> Just comment out this line:
>
> =A0 =A0 =A0 =A0hypersparc_setup_blockops();
>
> in srmmu.c

Tried it:

Linux version 3.4.0-08244-ge49e6ff-dirty
...
Freeing unused kernel memory: 148k freed
init[1]: segfault at 0 ip 5000dac8 (rpc f000bf68) sp eff978a0 error 30001 i=
n ld-
2.3.5.so[50000000+1a000]
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b

[f002b2d0 : do_group_exit+0x28/0xbc ] [f0035d4c : get_signal_to_deliver+0x1=
a8/0x
51c ] [f000eef4 : do_signal+0x44/0x768 ] [f000f950 : do_notify_resume+0x2c/=
0x3c
] [f000ccdc : signal_p+0x14/0x24 ] [f000bf68 : srmmu_fault+0x58/0x68 ]
Press Stop-A (L1-A) to return to the boot prom
