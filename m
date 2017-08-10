From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Thu, 10 Aug 2017 23:13:04 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <9e6ba7c2-be99-92ff-e8cb-b64eef143c64@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 08/10/2017 03:03 PM, David Miller wrote:
> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> Date: Thu, 10 Aug 2017 17:34:47 -0400
>
>> Following patch is based on work done by Nick Alcock on 64-bit vDSO for =
sparc
>> in Oracle linux. I have extended it to include support for 32-bit vDSO f=
or sparc
>> on 64-bit kernel.
> This doesn't build:
>
> davem@patience:~/src/GIT/sparc-next$ make -s -j128
> In file included from arch/sparc/vdso/vdso2c.c:141:0:
> arch/sparc/vdso/vdso2c.h: In function =A1go64=A2:
> arch/sparc/vdso/vdso2c.h:20:14: warning: variable =A1secstrings=A2 set bu=
t not used [-Wunused-but-set-variable]
>    const char *secstrings;
>                ^~~~~~~~~~
> In file included from arch/sparc/vdso/vdso2c.c:145:0:
> arch/sparc/vdso/vdso2c.h: In function =A1go32=A2:
> arch/sparc/vdso/vdso2c.h:20:14: warning: variable =A1secstrings=A2 set bu=
t not used [-Wunused-but-set-variable]
>    const char *secstrings;
>                ^~~~~~~~~~
> Error: vvar_begin must be a multiple of 8192
> make[2]: *** [arch/sparc/vdso/vdso-image-64.c] Error 1
> make[2]: *** Waiting for unfinished jobs....
> Error: vvar_begin must be a multiple of 8192
> make[2]: *** [arch/sparc/vdso/vdso-image-32.c] Error 1
> make[1]: *** [arch/sparc/vdso] Error 2
>
>
> davem@patience:~/src/GIT/sparc-next$ gcc --version
> gcc (GCC) 6.3.0
> Copyright (C) 2016 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

My gcc version is bit old (4.4.7) and the build passed in my system. I=20
will reproduce the errors locally, fix them
and send out an updated patch.

Sorry!

>
> davem@patience:~/src/GIT/sparc-next$ as --version
> GNU assembler (GNU Binutils for Debian) 2.22
> Copyright 2011 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or later.
> This program has absolutely no warranty.
> This assembler was configured for a target of `sparc-linux-gnu'.
> davem@patience:~/src/GIT/sparc-next$ ld --version
> GNU ld (GNU Binutils for Debian) 2.22
> Copyright 2011 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) a later vers=
ion.
> This program has absolutely no warranty.
> davem@patience:~/src/GIT/sparc-next$

