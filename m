From: "David S. Miller" <davem@redhat.com>
Date: Mon, 31 May 2004 19:26:32 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <20040531122632.2dd7f831.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 31 May 2004 12:41:37 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> No, I'm not using serial console currently, I did put in a cg6 and I'm
> using this and a type 5 keyboard as the prom console (console=prom). So
> this patch problably does not help here?

Right, but why aren't you using the suncg6 frame buffer driver?
console=prom is not only slow, it's deadlock prone as well
