From: David Miller <davem@davemloft.net>
Date: Wed, 30 Dec 2015 17:56:03 +0000
Subject: Re: [PATCH 07/34] sparc: reuse asm-generic/barrier.h
Message-Id: <20151230.125603.75638711551088484.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-8-git-send-email-mst@redhat.com>
In-Reply-To: <1451473761-30019-8-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com, mingo@kernel.org, mpe@ellerman.id.au, andreyknvl@google.com, sparclinux@vger.kernel.org


I find it a little bit irritating when I receive a patch directly
addressed to me to review, but I don't see the "00/34" cover letter.

I want to see what this series is about, and what the motiviation
for this change is.

I'm also highly frustrated, in general, with mix-and-match CC: lists
for patch series.  Just put everyone relevant in the CC: for the
entire series.  That way I can easily inspect other parts of the
series to see infrastructure buildup, and examples of other
conversions or versions of the change.

Thanks.

