From: Emanuele Rocca <ema@debian.org>
Date: Sun, 25 Feb 2007 13:33:29 +0000
Subject: Re:  sparc64 / bbc_i2c.c
Message-Id: <20070225133329.GA22364@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1171978032.18442.11.camel@lax.shef.ac.uk> <20070225044754.1d849a8d.akpm@linux-foundation.org>
In-Reply-To: <20070225044754.1d849a8d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "J.J. Green" <j.j.green@sheffield.ac.uk>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org>, [2007-02-25  4:47 -0800]:
>  > On Tue, 20 Feb 2007 13:27:12 +0000 "J.J. Green" <j.j.green@sheffield.a=
c.uk> wrote:
>  > I got bitten by this problem on sparc64 (a blade 1000)
>  >=20
>  >   http://ubuntuforums.org/showthread.php?t)7474

>  The code around there looks relatively unbuggy to me.  Removing that
>  remove_wait_queue() would be very bad - it would cause later stack
>  corruption.

The following patch by J=F6rg Friedrich fixes the issue without removing
the call to remove_wait_queue():

http://lists.debian.org/debian-sparc/2007/02/msg00045.html

ciao,
    ema
