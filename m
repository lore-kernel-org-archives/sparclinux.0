From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 04 Jun 2009 09:22:48 +0000
Subject: Re: [Bugme-new] [Bug 13444] New: SparcServer 1000E SMP can cause kernel-nullpointer with some hw con
Message-Id: <20090604092248.GA9649@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090603144241.99669d0e.akpm@linux-foundation.org>
In-Reply-To: <20090603144241.99669d0e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Yeah. 2.4.x is a "bit" old. But it was easier to fix. As the 2.6.x-series
> is giving me all kinds of trouble. The SMP-code was redesigned for 2.6, 
> and I havn't been able to confirm if it works or not.
> I could have a go at it if someone could give me a small pointer in how to 
> get the piggyback_32 utility working with 2.6s System.map.
> (looks like "A end" is missing from it)

Just a quick guess..

Try to add:

	end = .;

to arch/sparc/kernel/vmlinux.lds.S

Do this above the definition of _end.

Or better change piggyback_32 to support _end.

	Sam
