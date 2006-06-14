From: David Miller <davem@davemloft.net>
Date: Wed, 14 Jun 2006 22:31:52 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <20060614.153152.31232376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ludovic Court=E8s <ludo@chbouib.org>
Date: Wed, 14 Jun 2006 19:35:26 +0200

> However, the resulting kernel hangs right after the "Booting Linux..."
> message.  Unfortunately, I might have a few objects compiled with 4.x in
> the middle of those compiled with 3.4.6.  Is this likely to cause
> troubles?

Absolutely.    Changing the compiler changes many defines use in
the build, via include/linux/compiler.h, and this can even change
data structure layout.
