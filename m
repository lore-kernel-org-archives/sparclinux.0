From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 06 Aug 2017 18:46:27 +0000
Subject: Re: [PATCH] Fix compat_sys_sigpending breakage introduced by v4.13-rc1~6^2~12
Message-Id: <CA+55aFzzodcmCF+z35vKr90YWNjuDNUYbffcOw3DkivF4zh2oQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170805200050.GA24804@altlinux.org> <20170806182203.GA12956@ZenIV.linux.org.uk>
In-Reply-To: <20170806182203.GA12956@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anatoly Pugachev <matorola@gmail.com>, Eugene Syromyatnikov <evgsyr@gmail.com>

On Sun, Aug 6, 2017 at 11:22 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Anyway, all of that can be done later; for now let's go with your patch.
> ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
>
> I would pick it through my tree, but the local network is half-disasembled
> for move (containers arrive tomorrow, flight to Boston on 9th, stuff should
> arrive there by the weekend, so I hope to be back to normal by the 14th
> or so, assuming I'll have any sanity left by that time).  Could somebody
> else pick that one?  Linus?

I'll take it directly,

                   Linus
