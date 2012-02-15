From: David Miller <davem@davemloft.net>
Date: Wed, 15 Feb 2012 21:47:10 +0000
Subject: Re: [PATCH] arch/sparc/kernel/unaligned_64.c: included linux/bitops.h twice
Message-Id: <20120215.164710.1142246626753412621.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1329333604-31883-1-git-send-email-danny.kukawka@bisect.de>
In-Reply-To: <1329333604-31883-1-git-send-email-danny.kukawka@bisect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: danny.kukawka@bisect.de
Cc: dkukawka@suse.de, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Wed, 15 Feb 2012 20:20:04 +0100

> arch/sparc/kernel/unaligned_64.c included 'linux/bitops.h' twice,
> remove the duplicate.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Applied, thanks.
