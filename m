From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2006 20:45:00 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061018.134500.31640618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Wed, 18 Oct 2006 21:41:24 +0100

> Yes, I have a hpt366 ide controller for hard disks.

That's almost certainly the driver where the bug is.
