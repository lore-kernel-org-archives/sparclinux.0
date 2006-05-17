From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 May 2006 22:32:17 +0000
Subject: Re: klibc and SPARC
Message-Id: <20060517.153217.28779183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 13:43:58 -0700 (PDT)

> Does it make sense to say that these prom configurations are only
> recognized by kinit if openpromfs is available (without which it will
> simply behave as on any other platform), or should I go through the
> additional trouble of supporting both methods?

You need to enable a particular driver either way,
either CONFIG_SUN_OPENPROMFS or CONFIG_SUN_OPENPROMIO.

The NFS configuration bits you are moving into klibc
are going to be expected to work even if both of those
config options are disabled, it's expected to always
be available and work.
