From: Erlend Aasland <erlend-a@ux.his.no>
Date: Fri, 30 Jan 2004 00:22:35 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130002234.GA25728@badne4.ux.his.no>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Using an Ultra10, silo-1.4.3 (compiled w/gcc-3.2.3) I can successfully
boot kernel 2.4.23 and 2.4.24 (both 2.9MB).

Regards,
		Erlend Aasland

On 01/29/04 13:29, Ben Collins wrote:
> I've tested and fixed initrd support for sparc64, so that's safe.
> 
> I've also cleaned up some things. Upon further testing, I was able to
> boot a 6.8Meg image. Not sure why it didn't work the first time, but
> beware it may be flakey.
> 
> I'm a little disappointed. I haven't gotten any feedback from people
> testing this new version. So either no one cares, or it works good and
> people don't want to waste their time sending "worked for me" emails :)
> 
> Usual place: http://www.sparc-boot.org/pub/silo/
> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> WatchGuard - http://www.watchguard.com/
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
