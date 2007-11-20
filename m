From: Joe Perches <joe@perches.com>
Date: Tue, 20 Nov 2007 07:48:36 +0000
Subject: Re: [PATCH 06/59] arch/sparc: Add missing "space"
Message-Id: <1195544916.4675.117.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <1195523331-15303-6-git-send-email-joe@perches.com>
	 <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
	 <1195523331-15303-7-git-send-email-joe@perches.com>
	 <20071119.234500.127324508.davem@davemloft.net>
In-Reply-To: <20071119.234500.127324508.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

On Mon, 2007-11-19 at 23:45 -0800, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Mon, 19 Nov 2007 17:47:58 -0800
> > Signed-off-by: Joe Perches <joe@perches.com>
> Please check your patches, for trailing white "space".
> Adds trailing whitespace.
> diff:10:		prom_printf("PCIC: Error, cannot map " 
> Adds trailing whitespace.
> diff:19:		prom_printf("PCIC: Error, cannot map " 
> warning: 2 lines add whitespace errors.
> I've fixed it up this time.

It doesn't add whitespace, but it does keep the trailing
whitespace that's already there.

cheers, Joe

