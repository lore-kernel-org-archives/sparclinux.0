From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 06 Aug 2007 15:46:04 +0000
Subject: Re: Sparc-2.6.24 GIT tree
Message-Id: <46B7423C.20501@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070805.180930.21926239.davem@davemloft.net>
In-Reply-To: <20070805.180930.21926239.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> 
> I use arch/sparc64/defconfig, enable CONFIG_FUSION* and CONFIG_SMP,
> works fine on all my Niagara boxes.
> -

What compiler version do you use?

I've got a horrible feeling I've just spent a day fighting against a
miscompilation by gcc-4.2.

Perhaps this is a known problem? I'm rebuilding with gcc-4.1.2 now and
will report back shortly....

Andrew Walrond
