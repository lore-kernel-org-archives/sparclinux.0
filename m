From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jun 2010 21:17:21 +0000
Subject: Re: Error "Unknown relocation: 36" on module load on Sparc
Message-Id: <20100622.141721.242120880.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100616.133540.189696272.davem@davemloft.net>
	<4C210A07.80906@vlnb.net>
	<20100622193530.GA26041@merkur.ravnborg.org>
In-Reply-To: <20100622193530.GA26041@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: vst@vlnb.net, sparclinux@vger.kernel.org, simone.ricci@gmail.com, scst-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Nick.Couchman@seakr.com, mmarek@suse.cz, linux-kbuild@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Jun 2010 21:35:30 +0200

> Most of your Makefile looks fine - I guess we need to find the bug
> in the build environmnet and not in the Makefile.

Sam, note that these guys are working with 2.6.26 or some
ancient kernel like that :-/
