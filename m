From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 16 Sep 2019 09:38:07 +0000
Subject: Re: [RFC PATCH v2 00/12] Unify SMP stop generic logic to common code
Message-Id: <81e7e4da-93a3-c234-6ed6-0d709289776c@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
 <20190913182713.GB13294@shell.armlinux.org.uk>
In-Reply-To: <20190913182713.GB13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

On 13/09/2019 19:27, Russell King - ARM Linux admin wrote:
> On Fri, Sep 13, 2019 at 07:19:41PM +0100, Cristian Marussi wrote:
>> Tested as follows:
>>
>> - arm:
>> 1. boot
> 
> So this basically means the code paths you're touching are untested on
> ARM... given that, and the variety of systems we have out there, why
> should the patches touching ARM be taken?
> 

Yes, but sincerely it's an RFC, so I was not expecting any change to be picked up
by anyone at this stage: the expectation was to have some feedback on the general
approach used in the common code side of the series (patches 01-02-03-04):

is it worth ? is it over-engineered ? is it badly coded ? is it complete crap ?

In fact in the cover letter I stated:

> A couple more of still to be done potential enhancements have been noted
> on specific commits, and a lot more of testing remains surely to be done
> as of now, but, in the context of this RFC, any thoughts on this approach
> in general ?

I didn't want to port and test a lot of architectures before having some basic
feedback: in fact I did port more than one arch just to verify if they could
easily all fit into the new common code logic/layout I introduced, and, also,
to show that it could be generally useful to more than on arch. (as asked in V1)

As you noticed, though, I did certainly test as of now a lot more on some of them:

- arm64: because is where the initial bug was observed, so I had to verify if all
  of the above at least also fixed something at the end

- x86: because the original x86 SMP stop code differs more than other archs and so
  it was a good challenge to see if it could fit inside the new common SMP code logic
  (and in fact I had to extend the common framework to fit also x86 SMP stop needs)

Moreover within this series structure it is not mandatory for all archs to switch to the
new common logic: if not deemed important they can simply stick to their old code, while
other archs can switch to it.

So testing and porting to further archs is certainly work in progress at this time,
but in this RFC stage, I could be wrong, but I considered the arch-patches in this series more
as an example to showcase the usefulness (or not) of the series related to the common code
changes: I did not extensively tested all archs to the their full extent, so more fixes
could come in V3 (if ever) together with more testing and archs.

> Given that you're an ARM Ltd employee, I'm sure you can find 32-bit
> systems to test - or have ARM Ltd got rid of everything that isn't
> 64-bit? ;)
> 

well...worst case there's always Amazon anyway ... :D

Cheers

Cristian
