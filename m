From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 17 Aug 2005 18:57:58 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <20050817.115758.54436459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Subject: Re: 2.4 kernels and max # of rules with iptables
Date: Wed, 17 Aug 2005 13:53:38 -0500

> I guess that would help...
> 
> kmalloc failed, size of kreplsize is 939608

Yes, when running 32-bit programs on a 64-bit kernel,
there will be a hard limit of how many ipt_replace
entries can be loaded because we have to copy the
user's rule set into a kernel copy and therefore we
have to allocate kmalloc() memory to hold that.

You _could_ experiment with making the code there use
vmalloc()/vfree() instead, and if you get it working cleanly I'd be
happy to add such a patch to fix this.
