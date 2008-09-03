From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 22:10:26 +0000
Subject: Re: [patch 1/2] rtc-m48t59: reduce structure m48t59_private
Message-Id: <20080903.151026.252730832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200809032154.m83Lsgj3005964@imap1.linux-foundation.org>
In-Reply-To: <200809032154.m83Lsgj3005964@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: akpm@linux-foundation.org
Date: Wed, 03 Sep 2008 14:54:42 -0700

> Remove element size from the structure m48t59_private as it is used as
> local variable for storing temporary value.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> Cc: David Brownell <david-b@pacbell.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Applied to sparc-next-2.6
