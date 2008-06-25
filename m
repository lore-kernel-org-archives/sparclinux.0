From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jun 2008 22:30:07 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <20080625.153007.207008169.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
	<Pine.LNX.4.64.0806240156230.27784@engineering.redhat.com>
	<200806251617.40871.vda.linux@googlemail.com>
In-Reply-To: <200806251617.40871.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vda.linux@googlemail.com
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 25 Jun 2008 16:17:40 +0200

> And you know what? This is likely not the end yet! It's possible
> spin_lock_irqXXX, __wake_up_common, waitqueue_active or bit_waitqueue
> are inlines - I didn't check.

The thing to do in these kinds of scenerios is to provide top-level
routes in kernel/sched.c where all the inlining occurs, rather
than doing it in header files and thus expanding this stuff in
multiple places.
