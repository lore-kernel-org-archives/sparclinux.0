From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sun, 25 Nov 2007 21:19:50 +0000
Subject: Re: Bus error while building Erlang
Message-Id: <646765f40711251319u602e65ceuec897115d3addc17@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <47498C71.2080206@systella.fr>
In-Reply-To: <47498C71.2080206@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Nov 26, 2007 1:53 AM, BERTRAND Jo=EBl <joel.bertrand@systella.fr> wrote:
> Sergei Golovan wrote:
> > Hi!
>
>         Hello,
>
> > Recent build of erlang package failed on sparc architecture
> > (http://buildd.debian.org/build.php?&pkg=3Derlang&arch=3Dsparc&file=3Dl=
og).
> > I cannot find a reason looking at the log file, and I don't have an
> > access to any sparc machine to debug the failure.

I've been plagued by bus errors on my SS10 and U1E in the past whilst
using Debian Etch. It appeared to be a bug in the domain name =3D> IP
code - which caused all the stuff I wanted to run on it to immediately
fail.

What notes I could find on bus errors on Sparc led me to believe that
this error was caused by unaligned memory accesses. (please correct me
if I'm talking out of my arse) I guessed that the problem was
somewhere in libc. (and hence inaccessible for me) The problems all
went away when I upgraded the boxes to the new version of libc in
Lenny. (before Sparc32 support was dropped)

I'm guessing that something in erlc is doing a cast when it should do
a memcopy. However I've never even tried to get to the bottom of this
on my boxes, and given that the U1E now works fine, I've never had any
reason to.

Hope this is useful,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
