From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 02 May 2009 10:38:07 +0000
Subject: Re: Another set of debian niagara bugs
Message-Id: <20090502103807.GA7202@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090430.030130.124967500.davem@davemloft.net>
In-Reply-To: <20090430.030130.124967500.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 30, 2009 at 03:01:30AM -0700, David Miller wrote:
> 
> LDOM guests can't install correctly because sunvdc and sunvnet don't
> automatically load.
> 
> You can get through the installation by picking them in the various
> module list menus.
> 
> But once you reboot into the system, the initram can't load the sunvdc
> module and therefore root won't mount.
> 
> Ubuntu had this and the niagara console detection working two years
> ago :-(

I've filed http://bugs.debian.org/526621 for this issue.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
