From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 16 Jul 2009 23:42:15 +0000
Subject: Re: [PATCH,resend] sparc64: build compressed image (zImage) by
Message-Id: <646765f40907161642u4d7bb2fo1e4d3a682acf7958@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200907162041.53181.elendil@planet.nl> <20090716201601.GA6038@merkur.ravnborg.org>
In-Reply-To: <20090716201601.GA6038@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Frans Pop <elendil@planet.nl>, sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org, Jurij Smakov <jurij@wooyd.org>, David Miller <davem@davemloft.net>

On Fri, Jul 17, 2009 at 06:16, Sam Ravnborg<sam@ravnborg.org> wrote:
> Hmmm..
> This path does the following:
> 1) zImage becomes default for sparc and sparc64
> 2) fixes zImage on sparc64 (it dod not work before)
> 3) On sparc zImage is a stripped version of vmlinux, on sparc64 it is a g=
zipped not-stripped
> =A0 version of vmlinux - so it introduces a significantly different zImag=
e.
>
> Could we agree on the _same_ format for zImage on sparc and sparc64 and t=
hen apply that patch?
>
> I know Julian is working on unifying piggyback_{32,64}.c so maybe that is
> covered by his work?

I have been fiddling with that, but time is been at a premium at the moment.

I don't believe that changes to the zImage / vmlinux targets will
affect this as the tftpboot code uses the uncompressed (I believe)
"Image" target.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
