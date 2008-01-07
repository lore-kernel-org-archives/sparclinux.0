From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 07 Jan 2008 12:42:22 +0000
Subject: Re: [RFC PATCH 02/11] Add fastcall to do_IRQ for i386
Message-Id: <Pine.LNX.4.58.0801070742070.26038@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.934978594@goodmis.org>
 <20080103173639.GB30582@Krystal> <Pine.LNX.4.58.0801031246220.4826@gandalf.stny.rr.com>
 <4781AFB1.6040807@zytor.com>
In-Reply-To: <4781AFB1.6040807@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>


On Sun, 6 Jan 2008, H. Peter Anvin wrote:
>
> I thought we had dropped support for the non-REGPARM case, so why don't
> we just make it work for REGPARM and be done with it?
>

I'm working on that ;-)

-- Steve

