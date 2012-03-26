From: Joe Perches <joe@perches.com>
Date: Mon, 26 Mar 2012 17:03:59 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <1332781439.6160.100.camel@joe2Laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
	 <1332778595.6160.84.camel@joe2Laptop>
	 <CAFPAmTSyYJkATAD32WqHZY_PdWGjitEq4vgqCZeqjo+V24dh3Q@mail.gmail.com>
	 <1332779529.6160.96.camel@joe2Laptop>
	 <CAFPAmTTAf660w7Xcidzi5KHrJoDSEiWJdOMhyUesGxih8bs1wA@mail.gmail.com>
In-Reply-To: <CAFPAmTTAf660w7Xcidzi5KHrJoDSEiWJdOMhyUesGxih8bs1wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: davem@davemloft.net, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-03-26 at 12:55 -0400, Kautuk Consul wrote:
> Is it possible to include this kinda checking
> (multiline statements with paranthesis checking assuming tab
> indentation 8) in the
> checkpatch.pl script ?
> It would be easier to not make such mistakes in future with that kind of tool.

Funny you should ask...

Use the latest version of checkpatch and
add the --strict option to the command line.

https://lkml.org/lkml/2012/3/2/15

It works for most cases.

