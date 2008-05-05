From: David Miller <davem@davemloft.net>
Date: Mon, 05 May 2008 19:39:08 +0000
Subject: Re: [2.6 patch] sparc64: remove online_page()
Message-Id: <20080505.123908.238254784.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080505182336.GH17139@cs181133002.pp.htv.fi>
In-Reply-To: <20080505182336.GH17139@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@kernel.org
Cc: jeremy.fitzhardinge@citrix.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 5 May 2008 21:23:36 +0300

> The identical online_page() implementations from all architectures got 
> moved to mm/memory_hotplug.c - except for the sparc64 one that even was 
> dead code due to MEMORY_HOTPLUG not being available there.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied, thanks Adrian.
