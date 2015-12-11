From: Jiri Kosina <jikos@kernel.org>
Date: Fri, 11 Dec 2015 23:26:11 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:

> I'm personally happy with the existing code, and I've been wondering why
> there's this effort to apply further cleanups - to me, the changelogs
> don't seem to make that much sense, unless we want to start using
> printk() extensively in NMI functions - using the generic nmi backtrace
> code surely gets us something that works across all architectures...

It is already being used extensively, and not only for all-CPU backtraces. 
For starters, please consider

- WARN_ON(in_nmi())
- BUG_ON(in_nmi())
- anything being printed out from MCE handlers

-- 
Jiri Kosina
SUSE Labs

