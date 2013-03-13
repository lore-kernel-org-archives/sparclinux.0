From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 13 Mar 2013 06:33:20 +0000
Subject: Re: [PATCH] sparc: delete "if !ULTRA_HAS_POPULATION_COUNT"
Message-Id: <20130313063320.GC19681@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1363120519.3137.148.camel@x61.thuisdomein>
In-Reply-To: <1363120519.3137.148.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 12, 2013 at 09:35:19PM +0100, Paul Bolle wrote:
> Commit 2d78d4beb64eb07d50665432867971c481192ebf ("[PATCH] bitops:
> sparc64: use generic bitops") made the default of GENERIC_HWEIGHT depend
> on !ULTRA_HAS_POPULATION_COUNT. But since there's no Kconfig symbol with
> that name, this always evaluates to true. Delete this dependency.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
