From: David Miller <davem@davemloft.net>
Date: Fri, 27 Oct 2006 05:37:09 +0000
Subject: Re: 2.6.19-rc3 on sb100 - iihk!
Message-Id: <20061026.223709.77057387.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200610270726.53577.pkarlsen@mandriva.com>
In-Reply-To: <200610270726.53577.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Fri, 27 Oct 2006 07:26:53 +0200

> Oh, btw. another issue, my SB100 reports 11.11 bogomips total, did the sa=
me=20
> with 2.6.17-rc3, don't know at what time it got broken, known issue?

It's not broken, that's the correct value.

The mechanism used to calucate the value and the meaning of it
changed, comparing values created by the old and new method is not
valid.
