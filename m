From: David Miller <davem@davemloft.net>
Date: Wed, 01 Aug 2007 20:53:45 +0000
Subject: Re: [RESEND] [BUG] futex_unlock_pi() hurts my brain and may cause
Message-Id: <20070801.135345.15245832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070731.184250.71089148.davem@davemloft.net>
In-Reply-To: <20070731.184250.71089148.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Wed, 01 Aug 2007 13:21:08 +0200

> 	David, I have tried your patch. It does not fix futex bug
> (iceape hangs with same futex call).

Sigh, thanks for testing, I was almost sure this was the bug.
