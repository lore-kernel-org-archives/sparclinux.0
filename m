From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 09:42:01 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070731.024201.59657057.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 31 Jul 2007 11:37:00 +0200

> 	My U2 is a NIS and NFS client and iceape works fine. NIS and
> NFS server is on my U60 (and on this workstation, iceape hangs). All
> accounts on U60 are local.

You mentioned you are using netfilter, can you reboot with your
filtering rules disabled and retest?
