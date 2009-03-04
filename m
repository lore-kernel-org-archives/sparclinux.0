From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 04 Mar 2009 00:40:50 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <646765f40903031640x39b3361fic8833a4bf15b1381@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
In-Reply-To: <20090303192932.31705cf7@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@linux.intel.com>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Trent Piepho <tpiepho@freescale.com>

On Wed, Mar 4, 2009 at 11:29, Sean MacLennan <smaclennan@pikatech.com> wrote:
> On Tue, 3 Mar 2009 16:09:06 -0800
> "Andrew Morton" <akpm@linux-foundation.org> wrote:
>
>> afacit that interface is powerpc-only.
>
> Yes it is. You might want a CONFIG_PPC with that.
>
> It has been..... uhhhh carry the two... longer than I want to admit
> since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
> platform? Is sparc used much in the embedded world?
>
> If yes, the of_register_platform_driver is just a nice wrapper. It
> would be trivial to either change it to work on sparc, or add the
> wrapper to the sparc includes.

These inconsistencies are causing more problems with PPC drivers
depending on the generic infrastructure.

See: http://lkml.org/lkml/2009/1/11/376 for a similar issue.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
