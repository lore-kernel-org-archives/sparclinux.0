From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 07 Dec 2004 15:38:02 +0000
Subject: Re: mmap breakage
Message-Id: <Pine.LNX.4.61.0412071028590.2693@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, 6 Dec 2004, David S. Miller wrote:

> What needs to execute ld-linux.so.2 directly in order to run
> and has a huge data section? :-)  Is it some part of the GLIBC
> build, perhaps during locale generation?

No, this bug has been triggered during autobuilding of at least two=20
different Debian packages, kmd [0] and fet [1]. kmd is a graphical=20
debugger for ARM boards, and fet is some sort of personal organizer.

When ldd is run on the binaries late in the building stage to extract
the information about the dynamic libraries and generate the correct=20
dependencies, it (among other things) invokes the command:

/lib/ld-linux.so.2 --verify ./a.out

which fails with SIGILL, if one is unlucky.

[0] http://bugs.debian.org/268450
[1] http://buildd.debian.org/fetch.php?&pkg=FEt&ver=3D3.9.19-1&arch=3Dsparc=
&stamp=1101448389&file=3Dlog&as=3Draw

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
