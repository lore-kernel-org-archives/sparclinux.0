From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 05 Jan 2011 23:23:43 +0000
Subject: Re: [PATCH 0/4] sparc: drop SBUS ifdefs
Message-Id: <AANLkTimZm5jD+O8xYUGM9EcXRMEioW5r6Q+f75kX2Rxr@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105210217.GA22415@merkur.ravnborg.org>
In-Reply-To: <20110105210217.GA22415@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 6, 2011 at 08:02, Sam Ravnborg <sam@ravnborg.org> wrote:
> Kristoffer Glembo noticed that SBUS is always defined for SPARC.
> So I went out and dropped all #ifdef SBUS that were
> present in SPARC only code.

Good catch, but is this necessarily correct - i.e. do all sparc
machines have sbus hardware, and is it necessary to have sbus support
compiled into all sparc kernels? - should this be a (hidden) compile
option in like most other bus types? (e.g. PCI)

And beyond that, keeping these (unnecessary) #ifdefs is good
documentation - it makes it obvious that these drivers require sbus to
function. Would it potentially be a better choice to drop the SPARC
dependency as it's the only architecture that defines SBUS?

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
