From: Joerg Platte <lists@naasa.net>
Date: Thu, 01 Apr 2004 07:26:52 +0000
Subject: Re: srmmu: out of nocache
Message-Id: <200404010926.52034.lists@naasa.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Am Montag, 29. M=E4rz 2004 12:21 schrieben Sie:

> This patch changes the next-fit allocator to a next/first to possibly
> reduce fragmentation.  There is some performance cost associated.
> Please try it and report your results.  If it does fail, the log
> messages are important.

It works without problems. There were no more srmmu nocache messages in sys=
log=20
and no killed programs.

regards,
J=F6rg
