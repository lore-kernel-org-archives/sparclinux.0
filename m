From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 20:35:55 +0000
Subject: Re: [PATCH] of/pdt: allow DT device matching by fixing 'name'
Message-Id: <20110223203555.GT14597@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110216222820.487AE9D401C@zog.reactivated.net>
 <1297896277.3011.5.camel@macbook.infradead.org>
 <AANLkTikAF2X1A5jfoNfCPRhZkZ7qPdZ57c8B5b9z4+qr@mail.gmail.com>
 <20110218190659.7f955e4c@queued.net>
 <20110223194352.GR14597@angua.secretlab.ca>
 <20110223115414.547b8c17@queued.net>
In-Reply-To: <20110223115414.547b8c17@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: Daniel Drake <dsd@laptop.org>, David Woodhouse <dwmw2@infradead.org>, cbou@mail.ru, linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Wed, Feb 23, 2011 at 11:54:14AM -0800, Andres Salomon wrote:
> On Wed, 23 Feb 2011 12:43:52 -0700
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > On Fri, Feb 18, 2011 at 07:06:59PM -0800, Andres Salomon wrote:
> > Wait; why are you binding to a device based on name?  Binding by name
> > and/or device_type is strongly discouraged for new code.  Use
> > compatible instead.
> > 
> 
> Daniel posted a separate patch showing his code, would you mind
> commenting on that?  I noticed he didn't cc you though, here's the
> patch:
> 
> https://patchwork.kernel.org/patch/574901/

Done.

g.

