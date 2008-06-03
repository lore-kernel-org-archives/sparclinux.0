From: David Miller <davem@davemloft.net>
Date: Tue, 03 Jun 2008 19:51:17 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <20080603.125117.231936152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18500.62552.958244.633204@harpo.it.uu.se>
	<20080603.062253.17158135.davem@davemloft.net>
	<18501.39659.952880.727014@alkaid.it.uu.se>
In-Reply-To: <18501.39659.952880.727014@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 3 Jun 2008 21:26:35 +0200

> It's a shame though that a bug fix needs to have such draconian consequences.

I agree, but the way the X server (tried to) work on sparc before
libpciaccess was even more draconian.
