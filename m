From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 23 Nov 2004 07:37:58 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <20041122233758.7765a64d.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 23 Nov 2004 00:18:48 -0600
Bob Breuer <breuerr@mc.net> wrote:

> Then when setting up the number of colors, where can I get the proper
> cache size from?  I've only enabled the page coloring for hypersparcs,
> should we do the coloring for the rest as well?

Use vac_cache_size on srmmu.
