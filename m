From: David Miller <davem@davemloft.net>
Date: Mon, 26 Mar 2012 20:11:37 +0000
Subject: Re: [PATCH 19/20 v2] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <20120326.161137.1457934065978161789.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332698315-2218-1-git-send-email-consul.kautuk@gmail.com>
	<20120325.150422.2000357641354896689.davem@davemloft.net>
	<CAFPAmTT6pcjzi8WsM+r3izreGiuNaK5c4NkDav=6+wFj55QF4Q@mail.gmail.com>
In-Reply-To: <CAFPAmTT6pcjzi8WsM+r3izreGiuNaK5c4NkDav=6+wFj55QF4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 11:35:56 -0400

> I use gmail which did not show me the indentation which you wanted.
> I understand what you said now and have sent a v3 for this.

No, you don't understand, it's still messed up, in fact you've
made it increasingly worse.
