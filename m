From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 06 Sep 2004 03:27:18 +0000
Subject: Re: sbus/audio directory in 2.6?
Message-Id: <20040905202718.6744620d.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040905101922.GA9339@palantir8>
In-Reply-To: <20040905101922.GA9339@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 5 Sep 2004 11:19:22 +0100
Martin Habets <errandir_news@mph.eclipse.co.uk> wrote:

> Is there an alternative in 2.6 for the dbri driver?

Nope.

> If not, does sbus/audio need to be ported to 2.6?

Just the DBRI driver needs to be ported, the other
two drivers (cs4231 and amd7930, they are under
sound/sparc) were ported already.
