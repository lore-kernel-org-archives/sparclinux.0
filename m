From: David Miller <davem@davemloft.net>
Date: Thu, 21 Sep 2006 20:51:21 +0000
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-Id: <20060921.135121.35022014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060920172123.GA9334@ele.uri.edu>
	<20060920.105659.128612840.davem@davemloft.net>
	<17682.27477.995475.57130@alkaid.it.uu.se>
In-Reply-To: <17682.27477.995475.57130@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: simoneau@ele.uri.edu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 21 Sep 2006 12:37:09 +0200

> I don't think it's harmless. My Ultra5 has an add-on PCI USB controller
> card (Belkin). A 2.6.18-rc kernel compiled with gcc-4.1.1 will throw a few
> unaligned accesses when I initialise USB by inserting a USB memory stick.
> Removing the memory stick then results in PCI errors and other breakage.
> 
> The same kernel compiled with gcc-3.4.6 has no problems at all, so I've
> been assuming it's a gcc-4 issue and not a kernel issue.

Compiled with gcc-4.0.x I get the same ehci_hub_control unaligned
accesses, and putting the correct {get,put}_unaligned() in that
function makes them go away.

It's a pure mystery if gcc-3.4.x somehow avoids those, as by the
way the code is written those unaligned accesses are to be expected.
