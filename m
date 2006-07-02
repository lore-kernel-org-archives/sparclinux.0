From: Rene Rebe <rene@exactcode.de>
Date: Sun, 02 Jul 2006 15:14:19 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <200607021714.19680.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Sunday 02 July 2006 00:19, David Miller wrote:
> From: Rene Rebe <rene@exactcode.de>
> Date: Sat, 1 Jul 2006 14:21:56 +0200
>
> > after 5 hours of uptime with excessive load (software compilation). The
> > software is the T2 release from this week (software compiled from
> > vanilla sources) with GCC 4.1.1, Kernel 2.6.17.2:
>
> If you can reproduce this with gcc-4.0.x I'd really appreciate
> it.

I feared that. It will not be easy to reproduce it since it only happend on=
ce,
yesterday, and the machine continued to run fine (despite the oops) for
serveral more hours under high load so far.

Is there any chance the post 2.6.17 sparc64 and tg3 changes make a
difference or should I rather really try hard to reprouce it with the
2.6.17.2 kernel to find the real culprit?

Yours,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
