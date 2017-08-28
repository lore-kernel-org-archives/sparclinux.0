From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 28 Aug 2017 04:41:49 +0000
Subject: Re: [PATCH] Fix compat_sys_sigpending breakage introduced by v4.13-rc1~6^2~12
Message-Id: <20170828044149.GA19729@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20170805200050.GA24804@altlinux.org>
 <20170806182203.GA12956@ZenIV.linux.org.uk>
In-Reply-To: <20170806182203.GA12956@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, Eugene Syromyatnikov <evgsyr@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 06, 2017 at 07:22:03PM +0100, Al Viro wrote:

> I would pick it through my tree, but the local network is half-disasembled
> for move (containers arrive tomorrow, flight to Boston on 9th, stuff should
> arrive there by the weekend, so I hope to be back to normal by the 14th
> or so, assuming I'll have any sanity left by that time).

... and that hope had turned out to be far too optimistic.  Getting the things
back into working shape took two weeks longer than that; by now most of the
damage has been dealt with.  Dmitry's followups applied to for-next queue, with
apologies for delay.
