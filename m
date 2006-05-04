From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 04 May 2006 23:07:06 +0000
Subject: Re: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <20060504.160706.66354181.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200604280042.08024.pkarlsen@mandriva.com>
In-Reply-To: <200604280042.08024.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Thu, 4 May 2006 15:21:25 +0200

> This didn't do the trick, it made things crash at once, spitting out seve=
ral=20
> pages of  errors.. :\
> A lot of these with tracebacks..
> BUG: scheduling while atomic: swapper/0x00000011/1

Thanks for testing, I'll try to figure out what's wrong.
