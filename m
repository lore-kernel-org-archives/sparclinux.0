From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 17:05:43 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <CAFPAmTQbm7LUvbt4NWAmL_4g=7b7cnFjv6NowoaSn9oZTwWVmg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
	<1332778595.6160.84.camel@joe2Laptop>
	<CAFPAmTSyYJkATAD32WqHZY_PdWGjitEq4vgqCZeqjo+V24dh3Q@mail.gmail.com>
	<1332779529.6160.96.camel@joe2Laptop>
	<CAFPAmTTAf660w7Xcidzi5KHrJoDSEiWJdOMhyUesGxih8bs1wA@mail.gmail.com>
	<1332781439.6160.100.camel@joe2Laptop>
In-Reply-To: <1332781439.6160.100.camel@joe2Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: davem@davemloft.net, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 26, 2012 at 1:03 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2012-03-26 at 12:55 -0400, Kautuk Consul wrote:
>> Is it possible to include this kinda checking
>> (multiline statements with paranthesis checking assuming tab
>> indentation 8) in the
>> checkpatch.pl script ?
>> It would be easier to not make such mistakes in future with that kind of tool.
>
> Funny you should ask...
>
> Use the latest version of checkpatch and
> add the --strict option to the command line.
>
> https://lkml.org/lkml/2012/3/2/15
>
> It works for most cases.
>

Ah yes, I am not in the habit of using the --strict option.
I will use that in future, sorry for my ignorance.

And thanks to all you guys for helping me out here. :)
