From: "David S. Miller" <davem@redhat.com>
Date: Mon, 31 May 2004 19:44:58 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <20040531124458.35a92ad1.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 31 May 2004 22:29:33 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> Why is prom console deadlock prone?

Because it is the only facility in the kernel that causes
frequent calls into the OBP firmware, which requires full
cpu register state save on entry and exit.
