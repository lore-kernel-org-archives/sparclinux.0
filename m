From: "David S. Miller" <davem@redhat.com>
Date: Fri, 16 Sep 2005 19:57:15 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <20050916.155715.74748747.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
	<20050915.133026.21581824.davem@davemloft.net>
	<Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org

From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)

> Also I have question about second (hw tcp v4 csum failed):
...
> As you see in both errors is "0". Is this correct reporting broken packet=
s=20
> in kernel messages instead in RX errors ?

It is protocol level error, therefore it is not counted
in raw device level statistics.

BTW, when you get the "hw tcp v4 csum failed", the kernel ignores
the hw checksum and rechecks it using software.
