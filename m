From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 27 Sep 2005 22:09:59 +0000
Subject: Re: [sparc32] Kernel module to control front LED
Message-Id: <20050927.150959.55978399.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
In-Reply-To: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Tue, 27 Sep 2005 18:18:59 -0300

> Is this in any way similar to what the guardian service processor in
> PARISC64 machines provide? I.e. one can see what the leds in the machine
> front panel remotely :-)

Nah, this is just a physical single LED on the front panel of
the machine that you can toggle on an off by flipping a bit
in an I/O register.
