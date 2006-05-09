From: Rene Rebe <rene@exactcode.de>
Date: Tue, 09 May 2006 06:53:58 +0000
Subject: Re: Question on cross-compiler
Message-Id: <200605090853.58352.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Tuesday 09 May 2006 07:03, Jurzitza, Dieter wrote:
> Dear listmembers,
> is there anyone out who could give me a hint on how to build a
> cross-compiler for Ultra Sparc 64 Bit on a native 32 Bit environment? My
> build always barfs about incompatible libc.so - what is clear since it is
> 32 and not 64 Bit. Any pointer to some FAQ / whatsoever would be highly
> appreciated!

Despite a bit off-topic here, crosstool (http://www.kegel.com/crosstool/) o=
r=20
Development Environments such as T2 (http://www.t2-project.org) can help yo=
u=20
to build the cross compiler.

> Thanks in advance,
> take care

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
