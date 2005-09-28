From: Eric Brower <ebrower@gmail.com>
Date: Wed, 28 Sep 2005 00:39:31 +0000
Subject: Re: [sparc32] Kernel module to control front LED
Message-Id: <ec7cefb050927173935272123@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
In-Reply-To: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 9/27/05, David S. Miller <davem@davemloft.net> wrote:
> From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
> Date: Tue, 27 Sep 2005 18:18:59 -0300
>
> > Is this in any way similar to what the guardian service processor in
> > PARISC64 machines provide? I.e. one can see what the leds in the machine
> > front panel remotely :-)
>
> Nah, this is just a physical single LED on the front panel of
> the machine that you can toggle on an off by flipping a bit
> in an I/O register.

Arnaldo,

Certain Sun systems do have this sort of feature-- it has been called
Lights Out Management (LOM), Remote System Control (RSC) and the like.
 Basically, proprietary, pre-IPMI management controllers of varying
functionality.  As DaveM mentions, this isn't it, though... :)

There is ongoing work to support such controllers (e.g. on Sun E250
and E450 servers).
--
E
