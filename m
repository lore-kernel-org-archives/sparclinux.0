From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jan 2011 20:59:56 +0000
Subject: Re: R_SPARC_13
Message-Id: <20110118.130027.28804895.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110117.225022.59651505.davem@davemloft.net>
	<4D3570D7.2090000@oldelvet.org.uk>
	<1295356994.20446.3.camel@duncow>
In-Reply-To: <1295356994.20446.3.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richm@oldelvet.org.uk
Cc: 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, Jesper.Nilsson@axis.com, jeffm@suse.com

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 18 Jan 2011 13:23:14 +0000

> To close this off as a non-issue as far as my boot failures are
> concerned I did some further checking and objdump is displaying
> R_SPARC_OLO10 as two separate entries. I checked the scsi_mod.ko binary
> and found the appropriate Elf64_Rela entry. That has 0x21 as the LSB of
> r_info and that is the proper code for R_SPARC_OLO10 which is what you
> expected in the first place!

Thanks for figuring this out Richard.

I'll look into fixing binutils so that it properly reports the
correct R_SPARC_OLO10 relocation in dumps.  There really is no
excuse for what it's currently doing.  In fact, I think this
quirk has sent me on wild goose chases in the past.

