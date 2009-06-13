From: David Miller <davem@davemloft.net>
Date: Sat, 13 Jun 2009 23:56:23 +0000
Subject: Re: [PATCH] Bring sparc64 dynamic ftrace up to snuff...
Message-Id: <20090613.165623.04217938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090613.011020.214065340.davem@davemloft.net>
	<20090613194027.GA25439@elte.hu>
In-Reply-To: <20090613194027.GA25439@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, rostedt@goodmis.org

From: Ingo Molnar <mingo@elte.hu>
Date: Sat, 13 Jun 2009 21:40:27 +0200

> btw., just one (really stupid) question here: can ftrace_call be 
> misaligned, and is misalignment a problem on Sparc? If it's not a 
> problem then disregard the rest of the mail.

Every instruction must be 4-byte aligned on sparc.

Any instruction in the .text.* sections will thus always be 4-byte
aligned.
