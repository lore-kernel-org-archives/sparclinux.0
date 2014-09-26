From: Bob Picco <bpicco@meloft.net>
Date: Fri, 26 Sep 2014 14:28:16 +0000
Subject: Re: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140926142816.GI4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154047.2222645314356554322.davem@davemloft.net>
In-Reply-To: <20140925.154047.2222645314356554322.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 25 2014, 11:59:48PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Thu, 25 Sep 2014 18:37:18 -0400
> 
> > You might want to tone these down:
> > [10014000000-100147fffff] PMD -> [ffff801fda800000-ffff801fdaffffff] on node
> > or terminate them altogether. Only a suggestion and will inspect further.
> 
> I used x86 as a model, but I guess with fragmented guest memory it can
> be a bit overboard.
Well I'm on a guest about as much as you. I did ask a question about the
guest fragmented memory (MAX_BANKS) but haven't heard back. Though a guest
really has little knowledge of the MCU.
> 
> It's KERN_DEBUG too btw, which means that unless you ask for it you
> won't see those messages.  I bet on the real console they don't
> appear, but if you look at dmesg you'll certainly see them.
I agree. The real benefit is to people like you and I who don't want to
walk the page table state for a struct page. Possibly also for those that
don't have an equivalent to crash. This is made more of a challenge by our
changes.
> 
> >> I'm eager to push this, but I also want it to get tested so I'll hold
> >> off for about a day or so in order to give some time for that.
> > DEBUG_PAGEALLOC wasn't healthy on T5-2. I'll scrutinize further in the
> > morning. It could be a legitimate issue.
> 
> Strange, does it hang or OOPS?  Can you show me the OOPS messages if
> you have them?
Let me examine first. Yesterday I put my shorts on backwards and doubt certain
cranial activity.
