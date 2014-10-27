From: David Miller <davem@davemloft.net>
Date: Mon, 27 Oct 2014 22:43:27 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20141027.184327.1734954193920971940.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141024.133249.71272218161411159.davem@davemloft.net>
	<CA+55aFyqtuh53PmwO65NtM_PrPd51=EMWiv8dU8bNTrXL59=Jg@mail.gmail.com>
	<20141027140938.142f83a4c3bc6512dd73b54c@linux-foundation.org>
In-Reply-To: <20141027140938.142f83a4c3bc6512dd73b54c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, steve.capper@linaro.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 27 Oct 2014 14:09:38 -0700

> Perhaps sparc should be defining CONFIG_HAVE_GENERIC_RCU_GUP.
> 
> We really should switch x86 to the generic version - from a quick read
> it looks like it will work without needing any changes.
> 
> Steve, thoughts?

We need to add the necessary hooks to the generic code so that x86
doesn't so specualtive gets and instead do direct increments,
otherwise it's a performance regression, and then sparc can make use
of that as well.
