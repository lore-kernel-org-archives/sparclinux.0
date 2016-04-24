From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 18:47:27 +0000
Subject: Re: [PATCH] aeroflex/greth: fix warning about unused variable
Message-Id: <20160424184727.GA14746@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160424175105.GA14620@ravnborg.org>
In-Reply-To: <20160424175105.GA14620@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 24, 2016 at 07:51:05PM +0200, Sam Ravnborg wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 24 Apr 2016 18:39:52 +0200
> Subject: [PATCH] aeroflex/greth: fix warning about unused variable
> 
> Fix following warning:
> aeroflex/greth.c:1326:11: warning: unused variable 'phy' [-Wunused-variable]
> 
> The variable was unused - remove it.
> It looks like this warning has been there forever - was found by an
> allyesconfig build of sparc32.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Kristoffer Glembo <kristoffer@gaisler.com>

Kristoffer Glembo's mail bounces.
I have asked Gaisler for a replacement as maintainer.

	Sam
