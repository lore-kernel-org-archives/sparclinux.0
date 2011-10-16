From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Oct 2011 20:22:57 +0000
Subject: Re: [PATCH 03/21] sparc: drop unused Kconfig symbol
Message-Id: <20111016202257.GA25970@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1318595257.6132.59.camel@x61.thuisdomein> <alpine.LNX.2.00.1110150111520.26030@post.netunix.com>
In-Reply-To: <alpine.LNX.2.00.1110150111520.26030@post.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn@netunix.com
Cc: Paul Bolle <pebolle@tiscali.nl>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 15, 2011 at 01:14:02AM +0100, crn@netunix.com wrote:
>
> How does this affect Javastations, ISTR that they need PCI and one
> (rare) variant has a PCI slot. ??

It was replaced by a more specific CONFIG_SPARC_PCIC symbol
in commit: cfe3af5dde34a019c1bd2485b1dc0f2d7a326ccd

	Sam
