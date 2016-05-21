From: David Miller <davem@davemloft.net>
Date: Sat, 21 May 2016 01:34:43 +0000
Subject: Re: [PATCH] aeroflex/greth: fix warning about unused variable
Message-Id: <20160520.213443.1051641869321572095.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160424175105.GA14620@ravnborg.org>
In-Reply-To: <20160424175105.GA14620@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 19:51:05 +0200

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

Applied.
