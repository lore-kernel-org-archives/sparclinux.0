From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 12 Feb 2013 19:42:32 +0000
Subject: Re: Should SPARC use cpuidle? (was: linux-next: build failure after merge of the final tree (acpi tr
Message-Id: <20130212194232.GA15705@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au> <51197D8B.6010407@kernel.org> <20130212173505.GA2155@merkur.ravnborg.org> <511A837B.8020804@kernel.org>
In-Reply-To: <511A837B.8020804@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

> 
> > Do you btw. have any hints how I can convert to the cpu_idle thing you hinted?
> 
> If you have exactly 1 idle state, then cpuidle isn't that interesting,
> except, perhaps the standard residency counters.  If you have multiple
> states to choose from, cpuidle becomes more valuable.
> 
> There are lots of cpuidle users now, including x86's intel_idle,
> processor_idle, and the entire ARM tree.

I think LEON has only a single power-down state.
The APC stuff I know nothing about :-(

So for now I think I will let it be as it is then.

	Sam
