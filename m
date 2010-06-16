From: Kyle McMartin <kyle@mcmartin.ca>
Date: Wed, 16 Jun 2010 20:40:19 +0000
Subject: Re: Error "Unknown relocation: 36" on module load on Sparc
Message-Id: <20100616204019.GY20317@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTimuv7nOlcGFxqPZlwcAjLmFMiLAvbA5O7F32Wbg@mail.gmail.com> <4C192085.2090404@vlnb.net> <20100616192257.GW20317@bombadil.infradead.org> <20100616.133854.183053376.davem@davemloft.net>
In-Reply-To: <20100616.133854.183053376.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: kyle@mcmartin.ca, vst@vlnb.net, sparclinux@vger.kernel.org, simone.ricci@gmail.com, scst-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Nick.Couchman@seakr.com

On Wed, Jun 16, 2010 at 01:38:54PM -0700, David Miller wrote:
> This change is incorrect.
> 
> LM22 relocations do not get emitted for the "medlow" code model, which
> is what is explicitly specified on the kernel compiler command line
> for sparc64 via "-mcmodel=medlow".
> 
> Someone this person is using incorrect CFLAGS when building their
> module, and that's why they have this problem, because the compiler's
> default code model on sparc64 can generate those relocations.
>

Yeah, just saw your other mail. Thanks for the explanation!

--Kyle
