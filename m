From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jun 2010 21:16:22 +0000
Subject: Re: Error "Unknown relocation: 36" on module load on Sparc
Message-Id: <20100622.141622.15223630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4C192085.2090404@vlnb.net>
	<20100616.133540.189696272.davem@davemloft.net>
	<4C210A07.80906@vlnb.net>
In-Reply-To: <4C210A07.80906@vlnb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vst@vlnb.net
Cc: sparclinux@vger.kernel.org, simone.ricci@gmail.com, scst-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Nick.Couchman@seakr.com, mmarek@suse.cz, linux-kbuild@vger.kernel.org

From: Vladislav Bolkhovitin <vst@vlnb.net>
Date: Tue, 22 Jun 2010 23:07:51 +0400

> But we surprised that such platform specific compiler flags have to be
> manually maintained by out of the kernel tree modules developers.

You don't, Kbuild should do it transprently for you.

It's possible you're simply not using kbuild correctly
for external module builds, or something in your Makefile
is overriding the arch specific CFLAGS.
