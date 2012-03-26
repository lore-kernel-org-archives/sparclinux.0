From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 16:55:56 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <CAFPAmTTAf660w7Xcidzi5KHrJoDSEiWJdOMhyUesGxih8bs1wA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
	<1332778595.6160.84.camel@joe2Laptop>
	<CAFPAmTSyYJkATAD32WqHZY_PdWGjitEq4vgqCZeqjo+V24dh3Q@mail.gmail.com>
	<1332779529.6160.96.camel@joe2Laptop>
In-Reply-To: <1332779529.6160.96.camel@joe2Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: davem@davemloft.net, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

>>
>> you must be having the same problem in viewing the patch file
>> as me due to the email client itself inserting invalid spaces here and t=
here.
>
> Nope. =A0That's not it.
>
>> by the way, what tab-spaces are you using when you open it in vim ?
>
> I use vim as an editor as infrequently as possible.
>
> Your original patch used 6 tabs and 2 spaces.
> Tab size in kernel style is always 8.
>
> Again, make sure your tab indentation is set to 8.
>

I see what you are saying.
One question: Is it possible to include this kinda checking
(multiline statements with paranthesis checking assuming tab
indentation 8) in the
checkpatch.pl script ?
It would be easier to not make such mistakes in future with that kind of to=
ol.
